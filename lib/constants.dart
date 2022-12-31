import 'package:flutter/material.dart';

class NavKeys {
  static final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>(debugLabel: 'mainNavKey');
  static final GlobalKey<NavigatorState> lobbyNavKey = GlobalKey<NavigatorState>(debugLabel: 'lobbyNavKey');
}

const String debugApiUrl = 'http://192.168.1.106:8000/api/';