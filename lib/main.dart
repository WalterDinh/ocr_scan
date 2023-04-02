import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/app.dart';
import 'package:my_app/core/network.dart';

import 'package:my_app/states/theme/theme_cubit.dart';

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
      ],
      child: MultiBlocProvider(
        providers: [
          ///
          /// BLoCs
          ///

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
