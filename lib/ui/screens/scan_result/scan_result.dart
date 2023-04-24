import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/core/pdf.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/states/scan_photo/scan_photo_bloc.dart';
import 'package:my_app/states/scan_photo/scan_photo_selector.dart';
import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_bloc.dart';
import 'package:my_app/ui/screens/edit_scan_result/edit_scan_result_argument.dart';
import 'package:my_app/ui/screens/scan_result/widgets/select_mimetype_modal.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/base/pair.dart';

part 'sections/scan_result_image.dart';

part 'sections/scan_result_text.dart';

class ScanResultScreen extends StatefulWidget {
  const ScanResultScreen({Key? key}) : super(key: key);

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  ScanPhotoBloc get scanPhotoBloc => context.read<ScanPhotoBloc>();

  SelectImageFromGalleryBloc get selectImageFromGalleryBloc =>
      context.read<SelectImageFromGalleryBloc>();

  @override
  void initState() {
    scheduleMicrotask(() {
      _tabController = TabController(length: 2, vsync: this, initialIndex: 1);

      scanPhotoBloc.add(
          ScanPhotoLoadStarted(selectImageFromGalleryBloc.state.photoScan));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScanPhotoStateStatusSelector((status) {
      if (status == ScanPhotoStateStatus.loading) {
        return _buildLoading();
      }

      return Column(
        children: [
          Expanded(
              child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: MainAppBar(
                        backgroundColor: Colors.transparent,
                        iconTheme: IconThemeData(
                            color: Theme.of(context).iconTheme.color),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Center(
                                child: Ripple(
                              onTap: () => AppNavigator.pop(),
                              child: const Text("Done"),
                            )),
                          )
                        ]),
                    body: status == ScanPhotoStateStatus.loadFailure
                        ? Scaffold(body: _buildError())
                        : _buildBody(),
                  ))),
          status != ScanPhotoStateStatus.loadFailure
              ? CurrentScanDataSelector(
                  (data) {
                    return BottomNavigationBar(
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      selectedItemColor: Colors.grey,
                      type: BottomNavigationBarType.fixed,
                      unselectedItemColor: Colors.grey,
                      unselectedLabelStyle: const TextStyle(color: Colors.grey),
                      selectedLabelStyle: const TextStyle(color: Colors.grey),
                      onTap: (value) => _onTapBottomNavItem(value, data),
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.download), label: "Download"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.ios_share), label: "Share"),
                        // BottomNavigationBarItem(
                        //     icon: Icon(Icons.change_circle_outlined), label: "Convert"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.more_horiz_outlined),
                            label: "More"),
                      ],
                    );
                  },
                )
              : const SizedBox()
        ],
      );
    });
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildTabBar(),
        _buildTabContent(),
      ],
    );
  }

  PreferredSizeWidget _buildTabBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        width: 200,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.grey,
            border: Border.all(),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: 'PDF'),
            Tab(text: 'TXT'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [
          ScanResultImage(),
          ScanResultText(),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SpinKitFadingCircle(
              color: Theme.of(context).primaryColor,
              size: AppValues.circularFlatButton)),
    );
  }

  Widget _buildError() {
    return CustomScrollView(
      slivers: [
        // PokemonRefreshControl(onRefresh: _onRefresh),
        SliverFillRemaining(
          child: Container(
            padding: const EdgeInsets.only(bottom: 28),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 60,
                  color: AppColors.green,
                ),
                Text(
                  'Something went wrong, try later',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.grey, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onTapBottomNavItem(int index, Pair data) async {
    switch (index) {
      case 0:
        var status = await Permission.storage.status;
        if (status.isGranted) {
          // print(data.first);

          // List<dynamic> dataText = data.first;
          // print(data.first);
          // String dataConverted =
          //     dataText.reduce((value, element) => '$value\n$element');
          final result = await PdfApi.saveDocumentToExternal(
              text: data.first, fileInput: data.second);
          if (result == null) {
            _onShowAlertDialog("Error");
          } else {
            print(result);
            _onShowAlertDialog("Success");
          }
        } else {
          Permission.storage.request();
        }
        break;
      case 1:
        if (_tabController!.index == 0) {
          PdfApi.shareDocument();
        } else {
          // List<String> dataText = data.first;
          PdfApi.shareTxtFile(data.first);
        }

        // _onShowShareFileModal(data);
        break;
      case 2:
        _onShowEditScreen(data);
        break;
    }
  }

  void _onShowDownloadFileModal(Pair data) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SelectMimeTypeModal(
              title: 'Download file',
              onTakeMimeType: (mimetype) async {
                switch (mimetype) {
                  case MimeType.pdf:
                    // PdfApi.copyFileDocumentToExternalStorage(file: data.second);
                    // List<String> dataText = data.first as List<String>;
                    // String dataConverted =
                    //     dataText.reduce((value, element) => '$value\n$element');
                    final result = await PdfApi.saveDocumentToExternal(
                        text: data.first, fileInput: data.second);
                    if (result == null) {
                      _onShowAlertDialog("Error");
                    } else {
                      _onShowAlertDialog("Success");
                    }
                    break;
                  case MimeType.txt:
                    // TODO: Handle this case.
                    break;
                  case MimeType.image:
                    // TODO: Handle this case.
                    break;
                }
                if (mounted) {
                  Navigator.pop(context);
                }
              },
            ));
  }

  void _onShowShareFileModal(Pair data) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SelectMimeTypeModal(
              title: 'Share file',
              onTakeMimeType: (mimetype) async {
                switch (mimetype) {
                  case MimeType.pdf:
                    PdfApi.shareDocument();
                    break;
                  case MimeType.txt:
                    List<String> dataText = data.first;
                    // PdfApi.shareTxtFile(dataText);
                    break;
                  case MimeType.image:
                    // TODO: Handle this case.
                    break;
                }
                if (mounted) {
                  Navigator.pop(context);
                }
              },
            ));
  }

  void _onShowEditScreen(Pair data) {
    AppNavigator.push(
        Routes.edit_scan_result,
        EditScanResultArgument(data.first, (text) {
          scanPhotoBloc.add(ScanTextChanged(text));
        }));
  }

  void _onShowAlertDialog(String text) {
    final alert = AlertDialog(
      content: Text(text),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"))
      ],
    );
    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }
}
