import 'package:flutter/material.dart';

class NavKeys {
  static final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>(debugLabel: 'mainNavKey');
  static final GlobalKey<NavigatorState> lobbyNavKey = GlobalKey<NavigatorState>(debugLabel: 'lobbyNavKey');
}