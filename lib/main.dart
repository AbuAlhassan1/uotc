import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/toast_controller.dart';
import 'views/common/scroll_behavior.dart';
import 'views/common/toast_widget.dart';
import 'views/home.dart';
import 'views/lobby.dart';
import 'views/register.dart';
import 'views/welcome/container.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Use This Command To Generate Transitions
// flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
  final ToastStateController toastController = Get.put(ToastStateController());

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
      ShellRoute(
        pageBuilder: (BuildContext context, GoRouterState state, Widget myChild) {
          return MaterialPage(
            key: state.pageKey,
            child: HiddenDrawer(
              myChild: myChild,
            )
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/lobby',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const Home()
            ),
          ),
          GoRoute(
            path: '/details',
            builder: (BuildContext context, GoRouterState state) {
              return const Scaffold(
                backgroundColor: Colors.red,
              );
            },
          ),
          GoRoute(
            path: '/bb',
            builder: (BuildContext context, GoRouterState state) {
              return const Scaffold(
                backgroundColor: Colors.orange,
              );
            },
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const Scaffold(backgroundColor: Colors.blue,)
            ),
          ),
        ],
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
                      child: const Toast()
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