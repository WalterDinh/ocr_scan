import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/fade_page_route.dart';
import 'package:my_app/data/repositories/local_repository.dart';
import 'package:my_app/data/source/local/model/file_scan.dart';
import 'package:my_app/data/source/local/model/folder.dart';
import 'package:my_app/states/file_detail_manager/file_detail_manager_bloc.dart';
import 'package:my_app/states/file_manager/file_manager_bloc.dart';
import 'package:my_app/states/folder_detail_manager/folder_detail_bloc.dart';
import 'package:my_app/states/search/search_bloc.dart';
import 'package:my_app/ui/screens/detail_file/detail_file.dart';
import 'package:my_app/ui/screens/detail_folder/detail_folder.dart';
import 'package:my_app/ui/screens/edit_scan_result/edit_scan_result_argument.dart';
import 'package:my_app/ui/screens/intro/intro.dart';
import 'package:my_app/ui/screens/move_file/move_file.dart';
import 'package:my_app/ui/screens/my_folder/my_folder.dart';
import 'package:my_app/ui/screens/scan_history/scan_history.dart';
import 'package:my_app/ui/screens/scan_result/scan_result.dart';
import 'package:my_app/ui/screens/edit_scan_result/edit_scan_result.dart';
import 'package:my_app/ui/screens/search/search.dart';
import 'package:my_app/ui/screens/select_photo/select_photo.dart';
import 'package:my_app/ui/screens/home/home.dart';
import 'package:my_app/ui/screens/setting/setting.dart';

enum Routes {
  splash,
  home,
  select_photo,
  scan_result,
  intro,
  search,
  move_file,
  my_folder,
  scan_history,
  setting,
  edit_scan_result,
  folder_detail,
  file_detail
}

class _Paths {
  static const String splash = '/';
  static const String home = '/home';
  static const String select_photo = '/select_photo';
  static const String scan_result = '/scan_result';
  static const String intro = '/intro';
  static const String search = '/search';
  static const String move_file = '/move_file';
  static const String my_folder = '/my_folder';
  static const String scan_history = '/scan_history';
  static const String setting = '/setting';
  static const String edit_scan_result = '/edit_scan_result';
  static const String folder_detail = '/folder_detail';
  static const String file_detail = '/file_detail';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.home: _Paths.home,
    Routes.select_photo: _Paths.select_photo,
    Routes.scan_result: _Paths.scan_result,
    Routes.intro: _Paths.intro,
    Routes.search: _Paths.search,
    Routes.move_file: _Paths.move_file,
    Routes.my_folder: _Paths.my_folder,
    Routes.scan_history: _Paths.scan_history,
    Routes.setting: _Paths.setting,
    Routes.edit_scan_result: _Paths.edit_scan_result,
    Routes.folder_detail: _Paths.folder_detail,
    Routes.file_detail: _Paths.file_detail,
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.select_photo:
        return FadeRoute(
          page: const SelectPhotoScreen(),
        );
      case _Paths.scan_result:
        return FadeRoute(page: const ScanResultScreen());
      case _Paths.move_file:
        return FadeRoute(
            page: MoveFileScreen(
          fileScan: settings.arguments as FileScan,
        ));
      case _Paths.search:
        return FadeRoute(
            page: BlocProvider<SearchBloc>(
                create: (context) => SearchBloc(
                      context.read<LocalDataRepository>(),
                    ),
                child: const SearchScreen()));
      case _Paths.home:
        return FadeRoute(page: const HomeScreen());
      case _Paths.my_folder:
        return FadeRoute(page: const MyFolderScreen());
      case _Paths.scan_history:
        return FadeRoute(page: const ScanHistoryScreen());
      case _Paths.setting:
        return FadeRoute(page: const SettingScreen());
      case _Paths.file_detail:
        final args = settings.arguments as FileScan;
        return FadeRoute(
            page: BlocProvider<FileDetailBloc>(
                create: (context) => FileDetailBloc(
                      context.read<FileScanManagerBloc>(),
                    ),
                child: DetailFileScreen(
                  file: args,
                )));
      case _Paths.folder_detail:
        final args = settings.arguments as Folder;
        return FadeRoute(
            page: BlocProvider<FolderDetailBloc>(
                create: (context) => FolderDetailBloc(
                      context.read<LocalDataRepository>(),
                    ),
                child: FolderDetail(
                  folder: args,
                )));
      case _Paths.edit_scan_result:
        final args = settings.arguments as EditScanResultArgument;
        return FadeRoute(
            page: EditScanResultScreen(
                dataText: args.dataText, onTextChange: args.onTextChange));
      default:
        return FadeRoute(page: const IntroScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
