import 'package:my_app/app/locator.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/services/dynamic_link_service.dart';
import 'package:my_app/services/shared_preferences_service.dart';
import 'package:my_app/system/app_database.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _sharedPreferences = locator<SharedPreferencesService>();
  final _navigationService = locator<NavigationService>();
  final _dynamicLinkService = locator<DynamicLinkService>();

  bool _animationComplete = false;
  String _destinationRoute;
  dynamic _destinationArguments;

  bool _isFreshInstalled;

  Future isFreshInstall() async {
    _isFreshInstalled = await _sharedPreferences.isFreshInstalled();
  }

  Future initialise() async {
    //await isFreshInstall();
    await _dynamicLinkService.handleDynamicLinks();
    await _replaceWith(route: Routes.profileView);
  }

  Future _replaceWith({String route, dynamic arguments}) async {
    var hasDestinationRoute = _destinationRoute != null;
    var hasDestinationArguments = _destinationArguments != null;

    // Set the route only if we don't have a route
    if (!hasDestinationRoute) {
      _destinationRoute = route;
    }

    // set the arguments only if we don't have arguments
    if (!hasDestinationArguments) {
      _destinationArguments = arguments;
    }

    // navigate only if the animation is complete
    if (_animationComplete && _destinationRoute != null) {
      await _navigationService.replaceWith(
        _destinationRoute,
        arguments: _destinationArguments,
      );
    }
  }

  void indecateAnimationComplite() async {
    _animationComplete = true;
    await _replaceWith();
  }
}
