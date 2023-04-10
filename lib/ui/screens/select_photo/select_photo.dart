import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/core/values/app_values.dart';

import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_bloc.dart';
import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_selector.dart';
import 'package:my_app/ui/screens/select_photo/widgets/item_gallery.dart';
import 'package:my_app/ui/widgets/image_picker/image_helper.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';

class SelectPhotoScreen extends StatefulWidget {
  const SelectPhotoScreen({super.key});

  @override
  SelectPhotoScreenState createState() => SelectPhotoScreenState();
}

class SelectPhotoScreenState extends State<SelectPhotoScreen> {
  static const double _endReachedThreshold = 200;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  final ImageHelper imageHelper = ImageHelper();
  SelectImageFromGalleryBloc get selectImageFromGalleryBloc =>
      context.read<SelectImageFromGalleryBloc>();

  bool showTitle = false;

  @override
  void initState() {
    scheduleMicrotask(() {
      selectImageFromGalleryBloc.add(const SelectImageFromGalleryLoadStarted());
      _scrollKey.currentState?.innerController.addListener(_onScroll);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    final innerController = _scrollKey.currentState?.innerController;

    if (innerController == null || !innerController.hasClients) return;

    final thresholdReached =
        innerController.position.extentAfter < _endReachedThreshold;

    if (thresholdReached) {
      // Load more!
      selectImageFromGalleryBloc.add(SelectImageFromGalleryLoadMoreStarted());
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

  void _onSelectPhoto(int photoIndex) {
    selectImageFromGalleryBloc
        .add(SelectImageFromGallerySelectChanged(photoIndex: photoIndex));
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
      body: NestedScrollView(
          key: _scrollKey,
          headerSliverBuilder: (_, __) => [
                const SliverAppBar(
                  floating: true,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness:
                        Brightness.dark, //<-- For Android SEE HERE (dark icons)
                    statusBarBrightness:
                        Brightness.light, //<-- For iOS SEE HERE (dark icons)
                  ),
                  pinned: true,
                  elevation: 0,
                  iconTheme: IconThemeData(color: AppColors.black),
                  backgroundColor: Colors.transparent,
                ),
              ],
          body: SelectImageFromGalleryStateStatusSelector((status) {
            switch (status) {
              case SelectImageFromGalleryStateStatus.loading:
                return _buildLoading();

              case SelectImageFromGalleryStateStatus.loadFailure:
                return _buildError();

              default:
                return _buildGrid();
            }
          })),
    );
  }

  Widget _buildLoading() {
    return const Center(child: Text('Loading....'));
  }

  Widget _buildError() {
    return CustomScrollView(
      slivers: [
        // PokemonRefreshControl(onRefresh: _onRefresh),
        SliverFillRemaining(
          child: Container(
            padding: const EdgeInsets.only(bottom: 28),
            alignment: Alignment.center,
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.black26,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            sliver: NumberOfPhotoImagesSelector((numberOfMedia) {
              return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      crossAxisCount: 3),
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return SelectImageFromGallerySelector(index, (photo, _) {
                        return FutureBuilder(
                            future: photo.thumbnailData,
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return ItemGallery(
                                  onPress: () => _onSelectPhoto(index),
                                  asset: photo,
                                  data: snapshot.data as Uint8List,
                                );
                              }

                              return Container();
                            });
                      });
                    },
                    childCount: numberOfMedia,
                  ));
            })),
        SliverToBoxAdapter(
          child: PhotoImageCanLoadMoreSelector((canLoadMore) {
            if (!canLoadMore) {
              return const SizedBox.shrink();
            }

            return Container(
              padding: const EdgeInsets.only(bottom: 28),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }),
        ),
      ],
    );
  }
}
