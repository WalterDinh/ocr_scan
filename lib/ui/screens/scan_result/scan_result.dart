import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/states/scan_photo/scan_photo_bloc.dart';
import 'package:my_app/states/scan_photo/scan_photo_selector.dart';
import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_bloc.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: MainAppBar(
                    backgroundColor: Colors.transparent,
                    iconTheme:
                        IconThemeData(color: Theme.of(context).iconTheme.color),
                    actions: const [
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Center(child: Text("Done")),
                      )
                    ]),
                body: ScanPhotoStateStatusSelector((status) {
                  switch (status) {
                    case ScanPhotoStateStatus.loading:
                      return Scaffold(
                        body: _buildLoading(),
                      );

                    case ScanPhotoStateStatus.loadFailure:
                      return Scaffold(
                        body: _buildError(),
                      );

                    default:
                      return _buildBody();
                  }
                })),
          ),
        ),
        BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          selectedLabelStyle: const TextStyle(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.rotate_left_outlined), label: "Rotate"),
            BottomNavigationBarItem(
                icon: Icon(Icons.download), label: "Download"),
            BottomNavigationBarItem(
                icon: Icon(Icons.ios_share), label: "Share"),
            BottomNavigationBarItem(
                icon: Icon(Icons.change_circle_outlined), label: "Convert"),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz_outlined), label: "More"),
          ],
        )
      ],
    );
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
            Tab(text: 'JPG'),
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
}
