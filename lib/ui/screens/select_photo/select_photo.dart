import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/ui/screens/%08select_photo/widgets/item_gallery.dart';
import 'package:my_app/ui/widgets/image_picker/image_helper.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';
import 'package:photo_manager/photo_manager.dart';

class SelectPhotoScreen extends StatefulWidget {
  const SelectPhotoScreen({super.key});

  @override
  SelectPhotoScreenState createState() => SelectPhotoScreenState();
}

class SelectPhotoScreenState extends State<SelectPhotoScreen> {
  final List<Widget> _mediaList = [];
  int currentPage = 0;
  late int lastPage;
  final ImageHelper imageHelper = ImageHelper();

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    PermissionState result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(page: currentPage, size: 60);
      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder(
            future: asset.thumbnailData,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ItemGallery(
                  onPress: () {
                    return;
                  },
                  asset: asset,
                  data: snapshot.data as Uint8List,
                );
              }

              return Container();
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    } else {
      PhotoManager.openSetting();
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
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.darkGrey,
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
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
        child: Column(
          children: [
            Expanded(
                child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scroll) {
                _handleScrollEvent(scroll);

                return true;
              },
              child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return _mediaList[index];
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
