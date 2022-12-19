import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'common/bottom_navigation_bar.dart';
import 'common/colors.dart';
import 'common/navigation_transition.dart';
import 'home.dart';

class Lobby extends StatelessWidget {
  const Lobby({super.key});

  @override
  Widget build(BuildContext context) {

    double begin = context.locale.countryCode == 'en' ? 1 : -1;

    return Scaffold(
      backgroundColor: UotcColors.offBlack,
      body: Stack(
        children: [
          Navigator(
            key: NavKeys.lobbyNavKey,
            initialRoute: '/home',
            onGenerateRoute: (settings) {
              Route? page;

              switch (settings.name) {
                case '/home':
                  page = createRoute(
                    const Home(),
                    settings,
                    begin: Offset(begin, 0),
                    end: const Offset(0, 0),
                  );
                  break;
                case '/profile':
                  page = createRoute(
                    const Scaffold(),
                    settings,
                    begin: Offset(begin, 0),
                    end: const Offset(0, 0),
                  );
                  break;
                case '/settings':
                  page = createRoute(
                    const Scaffold(),
                    settings,
                    begin: Offset(begin, 0),
                    end: const Offset(0, 0),
                  );
                  break;
                case '/chat':
                  page = createRoute(
                    const Scaffold(),
                    settings,
                    begin: Offset(begin, 0),
                    end: const Offset(0, 0),
                  );
                  break;
              }

              page = page ?? createRoute(
                const Home(),
                settings,
                begin: Offset(begin, 0),
                end: const Offset(0, 0),
              );

              return page;
            },
          ),
          const UotcBottomNavigationBar(),
        ],
      ),
    );
  }
}