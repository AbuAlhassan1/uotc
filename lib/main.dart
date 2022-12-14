import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uotc/views/lobby/lobby.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'views/common/navigation_transition.dart';
import 'views/common/scroll_behavior.dart';
import 'views/welcome/container.dart';

// Use This Command To Generate Transitions
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', ''),
      startLocale: const Locale('ar', ''),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final PageStorageKey storageKey = const PageStorageKey('pageKey');

  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: '/welcome',
            onGenerateRoute: (settings) {
              Route page;
              
              switch (settings.name) {
                case '/':
                  page = createRoute(
                    const Lobby(),
                    settings,
                    begin: const Offset(0, 0),
                    end: const Offset(0, 0),
                  );
                  break;
                case '/welcome':
                  page = createRoute(
                    const WelcomeScreenContainer(),
                    settings,
                    begin: const Offset(0, 0),
                    end: const Offset(0, 0),
                  );
                  break;
                default:
                  page = createRoute(
                    const Lobby(),
                    settings,
                    begin: const Offset(0, 0),
                    end: const Offset(0, 0),
                  );
                  break;
              }
              
              return page;
            },
          ),
        );
      },
    );
  }
}