import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/app.dart';
import 'package:my_app/core/network.dart';
import 'package:my_app/data/repositories/scan_repository.dart';
import 'package:my_app/data/source/local/local_data_source.dart';
import 'package:my_app/data/source/scan_data_source.dart';
import 'package:my_app/states/folder_manager/folder_manager_bloc.dart';
import 'package:my_app/states/scan_photo/scan_photo_bloc.dart';
import 'package:my_app/states/select_image_from_gallery/select_image_from_gallery_bloc.dart';

import 'package:my_app/states/theme/theme_cubit.dart';

import 'data/repositories/local_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiRepositoryProvider(
      providers: [
        ///
        /// Services
        ///
        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),

        ///
        /// Data sources
        ///
        RepositoryProvider<ScanDataSource>(
          create: (context) => ScanDataSource(context.read<NetworkManager>()),
        ),
        RepositoryProvider<LocalDataSource>(
            create: (context) => LocalDataSource()),

        ///
        /// Repositories
        ///
        RepositoryProvider<ScanPhotoRepository>(
          create: (context) => ItemDefaultRepository(
            scanDataSource: context.read<ScanDataSource>(),
          ),
        ),

        RepositoryProvider<LocalDataRepository>(
          create: (context) => DataDefaultRepository(
            localDataSource: context.read<LocalDataSource>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          ///
          /// BLoCs
          ///
          BlocProvider<SelectImageFromGalleryBloc>(
              create: (context) => SelectImageFromGalleryBloc()),
          BlocProvider<ScanPhotoBloc>(
              create: (context) =>
                  ScanPhotoBloc(context.read<ScanPhotoRepository>())),
          BlocProvider<FolderManagerBloc>(
              create: (context) =>
                  FolderManagerBloc(context.read<LocalDataRepository>())),

          ///
          /// Theme Cubit
          ///
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          )
        ],
        child: const MainApp(),
      ),
    ),
  );
}
