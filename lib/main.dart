import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/toast_controller.dart';
import 'views/common/scroll_behavior.dart';
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
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubicEmphasized,
                      child: SafeArea(
                        child: Material(color: Colors.transparent,
                          child: Container(
                            height: 100, width: double.infinity,
                            margin: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.7),
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.5),
                                ]
                              ),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                toastController.description.value
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                )
              ],
            ),
          )
          // child: MaterialApp(
          //   navigatorKey: NavKeys.mainNavKey,
          //   debugShowCheckedModeBanner: false,
          //   localizationsDelegates: context.localizationDelegates,
          //   supportedLocales: context.supportedLocales,
          //   locale: context.locale,
          //   initialRoute: '/welcome',
          //   onGenerateRoute: (settings) {
          //     Route? page;
              
          //     switch (settings.name) {
          //       case '/lobby':
          //         page = createRoute(
          //           const Lobby(),
          //           settings,
          //           begin: Offset(begin, 0),
          //           end: const Offset(0, 0),
          //         );
          //         break;
          //       case '/welcome':
          //         page = createRoute(
          //           const WelcomeScreenContainer(),
          //           settings,
          //           begin: Offset(begin, 0),
          //           end: const Offset(0, 0),
          //         );
          //         break;
          //       case '/register':
          //         page = createRoute(
          //           const Login(),
          //           settings,
          //           begin: Offset(begin, 0),
          //           end: const Offset(0, 0),
          //         );
          //         break;
          //     }

          //     page = page ?? createRoute(
          //       const WelcomeScreenContainer(),
          //       settings,
          //       begin: Offset(begin, 0),
          //       end: const Offset(0, 0),
          //     );

          //     return page;
          //   },
          // ),
        );
      },
    );
  }
}