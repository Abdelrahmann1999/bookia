import 'package:bookia/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/core/Services/dio_provider.dart';
import 'package:bookia/core/Services/shared_pref.dart';
import 'package:bookia/core/Utils/themes.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioProvider.init();
  await SharedPref.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        // أي Cubit تاني
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.routers,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme(),
    );
  }
}
