import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/app/locator.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/datamodels/navigation_model.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class DynamicLinkService {
  final _navigationService = locator<NavigationService>();
  Future handleDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      await _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    await _handleDeepLink(data);
  }

  Future _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      // Check if we want to make a post
      var isFinderView = deepLink.pathSegments.contains('finder-view');

      if (isFinderView) {
        // get the title of the post
        String name = deepLink.queryParameters['name'];
        String mobile = deepLink.queryParameters['mobile'];
        String email = deepLink.queryParameters['email'];
        String address = deepLink.queryParameters['address'];
        String city = deepLink.queryParameters['city'];
        String country = deepLink.queryParameters['country'];
        String postalcode = deepLink.queryParameters['postalcode'];
        String birthDay = deepLink.queryParameters['birthDay'];
        String gender = deepLink.queryParameters['gender'];

        Map<String, String> argument = {
          "name": name,
          "mobile": mobile,
          "email": email,
          "address": address,
          "city": city,
          "country": country,
          "postalcode": postalcode,
          "birthDay": birthDay,
          "gender": gender,
        };

        if (name != null &&
            mobile != null &&
            email != null &&
            address != null &&
            city != null &&
            country != null &&
            postalcode != null &&
            birthDay != null &&
            gender != null) {
          // if we have a post navigate to the CreatePostViewRoute and pass in the title as the arguments.

          _navigationService.replaceWith(deepLink.path,
              arguments: FinderViewArguments(argumentValue: argument));
        }
      }
    }
  }

  Future<String> createDynamicLink(
      {bool shortn, String route, String params}) async {
    if (params == null) {
      params = "";
    }
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://sheikhsoft.page.link/',
      link: Uri.parse('https://sheikhsoft.page.link${route}?$params'),
      androidParameters: AndroidParameters(
        packageName: 'com.sheikhsoft.tfp_solutions',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
    );

    Uri url;
    if (shortn) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    return url.toString();
  }
}
