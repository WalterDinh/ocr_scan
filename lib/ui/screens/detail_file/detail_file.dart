import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/core/pdf.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/states/file_detail_manager/file_detail_manager_bloc.dart';
import 'package:my_app/states/file_detail_manager/file_detail_manager_selector.dart';
import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_bloc.dart';
import 'package:my_app/ui/screens/edit_scan_result/edit_scan_result_argument.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/ripple.dart';

import '../../../core/base/pair.dart';

part 'sections/scan_result_image.dart';

part 'sections/scan_result_text.dart';

class DetailFileScreen extends StatefulWidget {
  const DetailFileScreen({Key? key, required this.file}) : super(key: key);
  final FileScan file;
  @override
  State<DetailFileScreen> createState() => _DetailFileScreenState();
}

class _DetailFileScreenState extends State<DetailFileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  FileDetailBloc get fileDetailBloc => context.read<FileDetailBloc>();

  SelectImageFromGalleryBloc get selectImageFromGalleryBloc =>
      context.read<SelectImageFromGalleryBloc>();

  @override
  void initState() {
    scheduleMicrotask(() {
      _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

      fileDetailBloc.add(FileDetailLoadStarted(widget.file.dataText));
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
    return FileDetailStateStatusSelector((status) {
      if (status == FileDetailStateStatus.loading) {
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
                    body: status == FileDetailStateStatus.loadFailure
                        ? Scaffold(body: _buildError())
                        : _buildBody(),
                  ))),
          status != FileDetailStateStatus.loadFailure
              ? CurrentScanDataSelector(
                  (data) {
                    return BottomNavigationBar(
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      backgroundColor: Colors.white,
                      selectedItemColor: AppColors.black,
                      type: BottomNavigationBarType.fixed,
                      unselectedItemColor: AppColors.black,
                      unselectedLabelStyle:
                          const TextStyle(color: AppColors.black),
                      selectedLabelStyle:
                          const TextStyle(color: AppColors.black),
                      onTap: (value) => _onTapBottomNavItem(value, data),
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.download,
                              color: AppColors.darkGreen,
                            ),
                            label: "Download"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.ios_share,
                              color: AppColors.darkGreen,
                            ),
                            label: "Share"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.darkGreen,
                            ),
                            label: "Edit"),
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
          border: Border.all(color: AppColors.darkGreen),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: AppColors.green,
            border: Border.all(color: AppColors.darkGreen),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.darkGreen,
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
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    switch (index) {
      case 0:
        if (_tabController!.index == 0) {
          final result = await PdfApi.savePdfToExternal(text: data.first);
          if (result) {
            if (Platform.isAndroid) {
              scaffoldMessenger
                  .showSnackBar(const SnackBar(content: Text('Success')));
            }
          } else {
            _onShowAlertDialog("Error");
          }
        } else {
          final result = await PdfApi.saveTxtToExternal(text: data.first);
          if (result) {
            if (Platform.isAndroid) {
              scaffoldMessenger
                  .showSnackBar(const SnackBar(content: Text('Success')));
            }
          } else {
            _onShowAlertDialog("Error");
          }
        }
        break;
      case 1:
        if (_tabController!.index == 0) {
          PdfApi.shareDocument(data.first);
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

  void _onShowEditScreen(Pair data) {
    AppNavigator.push(
        Routes.edit_scan_result,
        EditScanResultArgument(data.first, (text) {
          fileDetailBloc.add(ScanTextChanged(text, widget.file));
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
