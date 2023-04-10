import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/states/scan_photo/scan_photo_bloc.dart';
import 'package:my_app/states/scan_photo/scan_photo_selector.dart';
import 'package:my_app/ui/screens/select_photo/widgets/item_gallery.dart';
import 'package:my_app/ui/widgets/image_picker/image_helper.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

import '../../../routes.dart';

class SelectPhotoScreen extends StatefulWidget {
  const SelectPhotoScreen({super.key});

  @override
  SelectPhotoScreenState createState() => SelectPhotoScreenState();
}

class SelectPhotoScreenState extends State<SelectPhotoScreen> {
  final ImageHelper imageHelper = ImageHelper();
  ScanPhotoBloc get scanBloc => context.read<ScanPhotoBloc>();

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      scanBloc.add(const ScanPhotoLoadStarted());
    });
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (scanBloc.state.canLoadMore) {
        scanBloc.add(const ScanPhotoLoadMoreStarted());
      }
    }
  }

  Future onTakePhoto() async {
    final files = await imageHelper.pickImage(source: ImageSource.camera);
    XFile? file = files.first;
    if (file != null) {
      final cropFile = await imageHelper.crop(file: file);
      if (cropFile != null) {
        return;
      }
    }
  }

  Future onPickFromGallery() async {
    final files = await imageHelper.pickImage();
    XFile? file = files.first;
    if (file != null) {
      final cropFile = await imageHelper.crop(file: file);
      if (cropFile != null) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: MainAppBar(
        appBarTitleText:
            Text('Scan', style: Theme.of(context).textTheme.headlineMedium),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ripple(
              onTap: () => onPickFromGallery(),
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkGrey.withOpacity(0.2),
                          offset: const Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppValues.circularFlatButton / 2))),
                  width: AppValues.circularFlatButton,
                  height: AppValues.circularFlatButton,
                  child: const Icon(
                    Icons.photo,
                    size: AppValues.iconSize_22,
                  )),
            ),
            const VSpacer(16),
            Ripple(
              onTap: () => onTakePhoto(),
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.darkGrey.withOpacity(0.2),
                          offset: const Offset(0, 3),
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppValues.circularFlatButton / 2))),
                  width: AppValues.circularFlatButton,
                  height: AppValues.circularFlatButton,
                  child: const Icon(
                    Icons.photo_camera,
                    size: AppValues.iconSize_22,
                  )),
            )
          ],
        ),
      ),
      body: SafeArea(
          bottom: false,
          child: ScanPhotoStateStatusSelector((status) {
            switch (status) {
              case ScanPhotoStateStatus.loading:
                return _buildLoading();
              case ScanPhotoStateStatus.loadingMore:
                return _buildGrid();
              case ScanPhotoStateStatus.loadSuccess:
                return _buildGrid();
              case ScanPhotoStateStatus.loadFailure:
                return _buildError();
              case ScanPhotoStateStatus.loadMoreFailure:
                return _buildError();

              default:
                return Container();
            }
          })),
    );
  }

  Widget _buildLoading() {
    return const Center(child: Text('Loading....'));
  }

  Widget _buildGrid() {
    return Column(
      children: [
        Expanded(
            child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scroll) {
                  _handleScrollEvent(scroll);

                  return true;
                },
                child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                    itemCount: scanBloc.state.mediaList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder(
                          future: scanBloc.state.mediaList[index].thumbnailData,
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ItemGallery(
                                onPress: () {
                                  scanBloc.add(ScanPhotoSelectChanged(
                                      photoItem:
                                          scanBloc.state.mediaList[index]));
                                  AppNavigator.push(Routes.scan_result);
                                },
                                asset: scanBloc.state.mediaList[index],
                                data: snapshot.data as Uint8List,
                              );
                            }

                            return Container();
                          });
                    }))),
      ],
    );
  }

  Widget _buildError() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Container(
            padding: const EdgeInsets.only(bottom: 28),
            alignment: Alignment.center,
            child: const Icon(
              Icons.image_not_supported_outlined,
              size: 100,
              color: Colors.black26,
            ),
          ),
        ),
      ],
    );
  }
}
