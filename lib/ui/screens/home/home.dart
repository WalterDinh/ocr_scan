import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/pdf.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/states/file_manager/file_manager_bloc.dart';
import 'package:my_app/states/file_manager/file_manager_selector.dart';
import 'package:my_app/states/folder_manager/folder_manager_bloc.dart';
import 'package:my_app/states/folder_manager/folder_manager_selector.dart';
import 'package:my_app/ui/modals/create_folder_modal.dart';
import 'package:my_app/ui/screens/edit_scan_result/edit_scan_result_argument.dart';
import 'package:my_app/ui/screens/home/widgets/search_input.dart';
import 'package:my_app/ui/screens/scan_history/scan_history.dart';
import 'package:my_app/ui/widgets/item_scan_folder.dart';
import 'package:my_app/ui/widgets/item_scan_history.dart';
import 'package:my_app/ui/widgets/ripple.dart';
import 'package:my_app/ui/widgets/spacer.dart';
import '../../widgets/main_app_bar.dart';
part 'sections/list_folder.dart';
part 'sections/list_scan_history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FolderManagerBloc get folderManager => context.read<FolderManagerBloc>();
  FileScanManagerBloc get filScanManager => context.read<FileScanManagerBloc>();

  @override
  void initState() {
    scheduleMicrotask(() async {
      folderManager.add(const GetAllFolderStarted());
      filScanManager.add(const GetAllFileScanStarted());
    });

    super.initState();
  }

  _onFabScanPressed() {
    AppNavigator.push(Routes.select_photo);
  }

  _onPressInputSearch() {
    AppNavigator.push(Routes.search);
  }

  _onNavigateToMyFolder() {
    AppNavigator.push(Routes.my_folder);
  }

  _onNavigateToScanHistory() {
    AppNavigator.push(Routes.scan_history);
  }

  _onNavigateToSetting() {
    AppNavigator.push(Routes.setting);
  }

  _onEdit(FileScan fileScan) {
    AppNavigator.push(
        Routes.edit_scan_result,
        EditScanResultArgument(fileScan.dataText, (text) {
          FileScan newFile = fileScan;
          newFile.dataText = text;
          filScanManager.add(UpdateFileScanStarted(fileScan, null));
        }));
  }

  _onOpenModalCreateFolder(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('MM/dd/yyyy').format(now);

        return ModalCreateFolder(
          onSummit: (text) =>
              {folderManager.add(CreateFolderStarted(Folder(title: text)))},
          initialValue: 'New folder_$formattedDate',
        );
      },
    );
  }

  _onDeleteFile(FileScan file) {
    filScanManager.add(DeleteFileScanStarted(file));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHomeAppBar(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchInput(
              hintText: 'Search...',
              onPressInput: _onPressInputSearch,
            ),
          ),
          _buildSectionHeader('My scan folder', _onNavigateToMyFolder, context),
          ListFolderSelector(
            (data) {
              List<Folder> dataList =
                  data.getRange(0, min(5, data.length)).toList();

              return ListScanFolder(
                  onCreateFolder: () => _onOpenModalCreateFolder(context),
                  listScanFolder: [Folder(), ...dataList]);
            },
          ),
          _buildSectionHeader(
              'Scan history', _onNavigateToScanHistory, context),
          ListFileScanSelector((data) {
            List<FileScan> dataList =
                data.getRange(0, min(10, data.length)).toList();
            if (dataList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: EmptyHistory(
                  context: context,
                ),
              );
            }

            return ListScanHistory(
              onEdit: _onEdit,
              onDelete: _onDeleteFile,
              listScanHistory: dataList,
            );
          })
        ],
      ),
      floatingActionButton: _buildFabScan(context),
    );
  }

  PreferredSizeWidget _buildHomeAppBar(BuildContext context) => MainAppBar(
        actions: [
          IconButton(
              onPressed: _onNavigateToSetting,
              icon: const Icon(
                Icons.settings,
                size: AppValues.iconSize_22,
                color: AppColors.black,
              )),
          const HSpacer(8)
        ],
        isBackButtonShowed: false,
      );

  Widget _buildSectionHeader(
          String title, Function() onPress, BuildContext context) =>
      Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: Theme.of(context).textTheme.labelLarge),
                Ripple(
                  onTap: onPress,
                  child: Text("See more",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.semiGrey)),
                ),
              ]));

  Widget _buildFabScan(BuildContext context) {
    double paddingBottomFloadButton =
        16 + MediaQuery.of(context).viewPadding.bottom;

    return Padding(
        padding: EdgeInsets.only(bottom: paddingBottomFloadButton),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: SvgPicture.asset(
            AppImages.iconScan,
            width: AppValues.iconDefaultSize,
            height: AppValues.iconDefaultSize,
          ),
          onPressed: () => _onFabScanPressed(),
        ));
  }
}
