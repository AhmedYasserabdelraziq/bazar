import 'package:book_shop/config/routs/app_router.dart';
import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/screens/favorite_screen/logic/favorite_cubit.dart';
import 'package:book_shop/services/observer.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await setupLocator();
  runApp(DevicePreview(
    enabled: false,
    builder: (BuildContext context) {
      return const MyApp();
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: BlocProvider(
        create: (context) => FavoriteCubit(),
        child: MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          initialRoute: RouteName.SPLASH,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}