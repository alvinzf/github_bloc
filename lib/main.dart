import 'dart:math';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sejuta_cita/bloc/app_bloc.dart';
import 'package:sejuta_cita/routes.dart';
import 'package:sejuta_cita/themes/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       tools: [...DevicePreview.defaultTools],
//       builder: (context) => MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AppBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Github Search',
        color: cWhite,
        theme: ThemeData(
          unselectedWidgetColor: cDisable,
          // fontFamily: ,
          textTheme: tTheme,
          scaffoldBackgroundColor: cScaffold,
          primarySwatch: mBlue,
        ),
        navigatorKey: AppNavigator.navigatorKey,
        onGenerateRoute: AppNavigator.onGenerateRoute,
        builder: (context, child) {
          final data = MediaQuery.of(context);
          final smallestSize = min(data.size.width, data.size.height);
          final textScaleFactor =
              min(smallestSize / designScreenSize.width, 1.0);
          return MediaQuery(
            data: data.copyWith(
              textScaleFactor: textScaleFactor,
            ),
            child: child,
          );
        },
      ),
    );
  }
}
