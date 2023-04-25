import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/configs/colors.dart';
import 'package:my_app/configs/images.dart';
import 'package:my_app/core/pdf.dart';
import 'package:my_app/core/values/app_values.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/routes.dart';
import 'package:my_app/states/file_manager/file_manager_bloc.dart';
import 'package:my_app/states/file_manager/file_manager_selector.dart';
import 'package:my_app/ui/screens/edit_scan_result/edit_scan_result_argument.dart';
import 'package:my_app/ui/widgets/item_scan_history.dart';
import 'package:my_app/ui/widgets/main_app_bar.dart';
import 'package:my_app/ui/widgets/spacer.dart';
part 'sections/empty_file.dart';
part 'sections/list_file_scan.dart';

class ScanHistoryScreen extends StatefulWidget {
  const ScanHistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScanHistoryScreenState();
}

class _ScanHistoryScreenState extends State<ScanHistoryScreen> {
  static const double leadingWidth = 44;
  FileScanManagerBloc get filScanManager => context.read<FileScanManagerBloc>();

  @override
  void initState() {
    scheduleMicrotask(() async {
      filScanManager.add(const GetAllFileScanStarted());
    });

    super.initState();
  }

  _onFabScanPressed() {
    AppNavigator.push(Routes.select_photo);
  }

  _onDeleteFile(FileScan file) {
    filScanManager.add(DeleteFileScanStarted(file));
  }

  // void _onRenameFile(FileScan file) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return ModalCreateFolder(
  //         isUpdate: true,
  //         onSummit: (text) => {
  //           filScanManager.add(UpdateFileScanStarted(
  //               FileScan(
  //                   id: file.id,
  //                   title: text,
  //                   createDate: file.createDate,
  //                   dataText: file.dataText,
  //                   folderId: file.folderId,
  //                   size: file.size),
  //               null))
  //         },
  //         initialValue: file.title,
  //       );
  //     },
  //   );
  // }

  _onHandleOptions(HistoryOptionType type, FileScan file) {
    if (type == HistoryOptionType.delete) {
      _onDeleteFile(file);
    }
    if (type == HistoryOptionType.move) {
      AppNavigator.push(Routes.move_file, file);
    }
    // if (type == HistoryOptionType.rename) {
    //   _onDeleteFile(file);
    // }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
            isBackButtonEnabled: true,
            leadingWidth: leadingWidth,
            appBarTitleText: Text(
              'Scan history',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.black),
            )),
        floatingActionButton: _buildFabScan(context),
        body: FileScanManagerStatusSelector((status) {
          if (status == FileScanManagerStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListFileScanSelector((data) {
            if (data.isNotEmpty) {
              return ListFileScan(
                onEdit: _onEdit,
                listFile: data,
                onHandleOptions: (type, file) => _onHandleOptions(type, file),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmptyHistory(
                  context: context,
                )
              ],
            );
          });
        }));
  }

  Widget _buildFabScan(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: SvgPicture.asset(
            AppImages.iconScan,
            width: AppValues.iconDefaultSize,
            height: AppValues.iconDefaultSize,
            color: AppColors.lighterGrey,
          ),
          onPressed: () => _onFabScanPressed(),
        ),
      );
}
