import 'package:flutter/material.dart';
import 'package:my_app/app/locator.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/datamodels/encryption_model.dart';
import 'package:my_app/services/encryption_service.dart';
import 'package:my_app/ui/smart_widgets/map_style.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:convert';

class FinderViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _encryptionService = locator<EncryptionService>();

  //LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);
  double CAMERA_ZOOM = 1;
  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;

  LatLng _latlong;
  CameraPosition _cameraPosition;

  LatLng get latlong => _latlong;
  CameraPosition get cameraPosition => _cameraPosition;

  Completer<GoogleMapController> _controllerNew = Completer();
  // this set will hold my markers
  Set<Marker> _markersNew = {};

  Set<Marker> get markersNew => _markersNew;

  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish

  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != PermissionStatus.granted) getLocation();
      return;
    }
    getLocation();
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);

    _latlong = new LatLng(position.latitude, position.longitude);

    _cameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: _latlong);

    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/destination_map_marker.png');

    _markersNew.add(Marker(
        markerId: MarkerId('sourcePin'), position: _latlong, icon: sourceIcon));
    // destination pin
    _markersNew.add(Marker(
        markerId: MarkerId('destPin'),
        position: LatLng(40.2937136, -102.2610417),
        icon: destinationIcon));

    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(MapStyle.mapStyles);
    _controllerNew.complete(controller);
  }

  void navigateToEndPoint(Map<String, String> argumentValue) async {
    String decrypted = jsonEncode(argumentValue).toString();

    EncryptionModel encryptionModel =
        await _encryptionService.encrypt(decrypted);

    encryptionModel.toJson();

    print("decription: $decrypted");

    _navigationService.replaceWith(Routes.endPointView,
        arguments: EndPointViewArguments(
            decrypted: decrypted, encrypted: encryptionModel.toJson()));
  }
}
