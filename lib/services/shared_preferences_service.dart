import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SharedPreferencesService {
  static const String IS_FRESHLY_INSTALLED_PREFERENCE_KEY =
      "is_freshly_installed";

  Future<bool> isFreshInstalled() async {
    var pref = await SharedPreferences.getInstance();

    bool _isFreshlyInstalled =
        pref.getBool(IS_FRESHLY_INSTALLED_PREFERENCE_KEY);
    if (_isFreshlyInstalled == null) {
      //null means if fresh installed and flag wasn't stored before
      //so we save false into pref incase this flag is needed again or else where after fresh installation
      return await pref.setBool(IS_FRESHLY_INSTALLED_PREFERENCE_KEY, false);
    } else {
      return _isFreshlyInstalled;
    }

    //Other compact way to write it
    // bool isFreshlyInstalled = pref.getBool(IS_FRESHLY_INSTALLED_PREFERENCE_KEY) ?? true;
    // if (isFreshlyInstalled) {
    //   await pref.setBool(IS_FRESHLY_INSTALLED_PREFERENCE_KEY, !isFirstTimeUser);
    // }
    // return isFreshlyInstalled;
  }
}
