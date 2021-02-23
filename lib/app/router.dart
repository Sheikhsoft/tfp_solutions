import 'package:auto_route/auto_route_annotations.dart';
import 'package:my_app/ui/views/endpoint/endpoint_view.dart';

import 'package:my_app/ui/views/finder/finder_view.dart';

import 'package:my_app/ui/views/profile/profile_view.dart';
import 'package:my_app/ui/views/startup/startup_view.dart';

@MaterialAutoRouter(routes: [
  MaterialRoute(page: StartupView, initial: true),
  MaterialRoute(page: ProfileView),
  MaterialRoute(page: FinderView),
  MaterialRoute(page: EndPointView),
])
class $Router {}
