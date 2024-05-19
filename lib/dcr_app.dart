import 'package:dcr_mobile/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';

class DCRApp extends StatelessWidget {
  const DCRApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Orientation: PORTRAIT Only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      // designSize: const Size(428, 926),
      splitScreenMode: true,
      minTextAdapt:
          true, // Whether to adapt the text according to the minimum of width and height
      useInheritedMediaQuery: true,
      builder: (context, widget) => MaterialApp(
        title: "DCR",
        navigatorObservers: [StackedService.routeObserver],
        navigatorKey: StackedService.navigatorKey, // For stacked_services
        onGenerateRoute: StackedRouter()
            .onGenerateRoute, // Auto generates all routes using stacked package
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,

        builder: (context, child) {
          return ScrollConfiguration(
            // To remove the glow effect entirely
            behavior: const ScrollBehavior(),
            child: MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            ),
          );
        },
      ),
    );
  }
}
