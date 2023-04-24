import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/states/file_manager/file_manager_bloc.dart';
import 'package:my_app/states/folder_manager/folder_manager_bloc.dart';
import 'package:my_app/states/folder_manager/folder_manager_selector.dart';
import 'package:my_app/ui/widgets/item_folder_list.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/spacer.dart';

import '../../modals/create_folder_modal.dart';
part 'sections/empty_folder.dart';
part 'sections/list_folder.dart';

class MoveFileScreen extends StatefulWidget {
  const MoveFileScreen({super.key, required this.fileScan});
  final FileScan fileScan;
  @override
  State<StatefulWidget> createState() => _MoveFileScreenState();
}

class _MoveFileScreenState extends State<MoveFileScreen> {
  static const double leadingWidth = 44;
  FolderManagerBloc get folderManager => context.read<FolderManagerBloc>();
  FileScanManagerBloc get filerManager => context.read<FileScanManagerBloc>();

  @override
  void initState() {
    scheduleMicrotask(() async {
      folderManager.add(const GetAllFolderStarted());
    });

    super.initState();
  }

  void _onOpenModalCreateFolder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd').format(now);

        return ModalCreateFolder(
          onSummit: (text) =>
              folderManager.add(CreateFolderStarted(Folder(title: text))),
          initialValue: 'New folder_$formattedDate',
        );
      },
    );
  }

  _onMoveFileToFolder(Folder folder) {
    filerManager.add(UpdateFileScanStarted(widget.fileScan, folder));
    AppNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
            isBackButtonEnabled: true,
            leadingWidth: leadingWidth,
            appBarTitleText: Text(
              'Move to',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.black),
            )),
        floatingActionButton: ListFolderSelector((data) {
          if (data.isEmpty) {
            return const HSpacer(0);
          }

          return _buildFabScan(context);
        }),
        body: FolderManagerStatusSelector((status) {
          if (status == FolderManagerStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListFolderSelector((data) {
            if (data.isNotEmpty) {
              return ListScanFolder(onMove: (p0) => _onMoveFileToFolder(p0));
            }

            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmptyFolder(
                  onCreateFolder: _onOpenModalCreateFolder,
                  context: context,
                )
              ],
            );
          });
        }));
  }

  Widget _buildFabScan(BuildContext context) {
    double paddingBottomFloadButton =
        16 + MediaQuery.of(context).viewPadding.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottomFloadButton),
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: SvgPicture.asset(
          AppImages.iconFolderAdd,
          width: AppValues.iconDefaultSize,
          height: AppValues.iconDefaultSize,
          color: AppColors.lighterGrey,
        ),
        onPressed: () => _onOpenModalCreateFolder(),
      ),
    );
  }
}
