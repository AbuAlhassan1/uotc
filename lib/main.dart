import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/toast_controller.dart';
import 'views/common/scroll_behavior.dart';
import 'views/common/toast_widget.dart';
import 'views/home.dart';
import 'views/register.dart';
import 'views/welcome/container.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

// Use This Command To Generate Transitions
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  usePathUrlStrategy();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar', ''),
      startLocale: const Locale('ar', ''),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final PageStorageKey storageKey = const PageStorageKey('pageKey');
  ToastStateController toastController = Get.put(ToastStateController());

  final router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const WelcomeScreenContainer()
        ),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Register()
        ),
      ),
      GoRoute(
        path: '/lobby',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Home()
        ),
        routes: [
          GoRoute(
            path: 'gg',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const Scaffold()
            ),
          ),
          ShellRoute(
            pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
              return MaterialPage(
                child: Scaffold(
                  body: child,
                  /* ... */
                  bottomNavigationBar: Container(color: Colors.red, height: 100,),
                ),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'details',
                builder: (BuildContext context, GoRouterState state) {
                  return const Scaffold();
                },
              ),
              GoRoute(
                path: 'gg',
                builder: (BuildContext context, GoRouterState state) {
                  return const Scaffold();
                },
              ),
              GoRoute(
                path: 'bb',
                builder: (BuildContext context, GoRouterState state) {
                  return const Scaffold();
                },
              ),
            ],
          ),
          GoRoute(
            path: 'settings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const Scaffold(backgroundColor: Colors.blue,)
            ),
          ),
        ]
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      )
    ),
  ); 
  
  Widget buildToasts(){
    String toast = '';
    int count = 1;
    toastController.description.value.forEach((key, value) {
      toast += toastController.description.value.length == count ? value : '$value \n';
      count++;
    });
    return Toast(text: toast, type: 'success');
  }

  @override
  Widget build(BuildContext context) {

    context.setLocale(const Locale('ar'));
    // double begin = context.locale.countryCode == 'en' ? 1 : -1;
    
    return 
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Stack(
              children: [
                MaterialApp.router(
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  debugShowCheckedModeBanner: false,
                  locale: context.locale,
                  routerConfig: router,
                ),
                Obx(
                  () =>
                    AnimatedAlign(
                      alignment: Alignment(0, toastController.toastAlignment.value),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                      child: Material(
                        color: Colors.transparent,
                        child: SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [buildToasts()]
                          ),
                        )
                      ),
                    ),
                )
              ],
            ),
          )
        );
      },
    );
  }
}