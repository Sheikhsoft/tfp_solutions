// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/views/endpoint/endpoint_view.dart';
import '../ui/views/finder/finder_view.dart';
import '../ui/views/profile/profile_view.dart';
import '../ui/views/startup/startup_view.dart';

class Routes {
  static const String startupView = '/';
  static const String profileView = '/profile-view';
  static const String finderView = '/finder-view';
  static const String endPointView = '/end-point-view';
  static const all = <String>{
    startupView,
    profileView,
    finderView,
    endPointView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.profileView, page: ProfileView),
    RouteDef(Routes.finderView, page: FinderView),
    RouteDef(Routes.endPointView, page: EndPointView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    ProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProfileView(),
        settings: data,
      );
    },
    FinderView: (data) {
      final args = data.getArgs<FinderViewArguments>(
        orElse: () => FinderViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => FinderView(
          key: args.key,
          argumentValue: args.argumentValue,
        ),
        settings: data,
      );
    },
    EndPointView: (data) {
      final args = data.getArgs<EndPointViewArguments>(
        orElse: () => EndPointViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => EndPointView(
          key: args.key,
          decrypted: args.decrypted,
          encrypted: args.encrypted,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// FinderView arguments holder class
class FinderViewArguments {
  final Key key;
  final Map<String, String> argumentValue;
  FinderViewArguments({this.key, this.argumentValue});
}

/// EndPointView arguments holder class
class EndPointViewArguments {
  final Key key;
  final String decrypted;
  final Map<dynamic, dynamic> encrypted;
  EndPointViewArguments({this.key, this.decrypted, this.encrypted});
}
