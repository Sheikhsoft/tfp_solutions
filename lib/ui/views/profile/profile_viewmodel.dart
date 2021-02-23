import 'package:email_validator/email_validator.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app/locator.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/datamodels/validation_item.dart';
import 'package:my_app/services/dynamic_link_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dynamicLinkService = locator<DynamicLinkService>();
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _mobile = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _address = ValidationItem(null, null);
  ValidationItem _city = ValidationItem(null, null);
  ValidationItem _country = ValidationItem(null, null);
  ValidationItem _postalCode = ValidationItem(null, null);
  ValidationItem _birthDay = ValidationItem(null, null);
  ValidationItem _gender = ValidationItem(null, null);

  ValidationItem get name => _name;
  ValidationItem get mobile => _mobile;
  ValidationItem get email => _email;
  ValidationItem get address => _address;
  ValidationItem get city => _city;
  ValidationItem get country => _country;
  ValidationItem get postalCode => _postalCode;
  ValidationItem get birthDay => _birthDay;
  ValidationItem get gender => _gender;

  String _linkMessage;
  bool _isCreatingLink = false;

  String get linkMessage => _linkMessage;
  bool get isCreatingLink => _isCreatingLink;

  bool get canSubmit =>
      _name.value.length > 3 && (EmailValidator.validate(_email.value));

  bool get isValid {
    if (_name.value != null &&
        _mobile.value != null &&
        _email.value != null &&
        _address.value != null &&
        _city.value != null &&
        _country.value != null &&
        _postalCode.value != null &&
        _birthDay.value != null &&
        _gender.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void setName(String name) {
    if (name.length >= 3) {
      _name = ValidationItem(name, null);
    } else {
      _name = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void setEmail(String email) {
    if (email.length >= 6 && EmailValidator.validate(email)) {
      _email = ValidationItem(email, null);
    } else {
      _email = ValidationItem(null, "Enter Valid Email Address");
    }
    notifyListeners();
  }

  void setMobileNumber(String mobileNumber) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (regExp.hasMatch(mobileNumber)) {
      _mobile = ValidationItem(mobileNumber, null);
    } else {
      _mobile = ValidationItem(null, "enter valid mobile number");
    }
    notifyListeners();
  }

  void setAddress(String address) {
    if (address.length >= 3) {
      _address = ValidationItem(address, null);
    } else {
      _address = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void setCity(String city) {
    if (city.length >= 3) {
      _city = ValidationItem(city, null);
    } else {
      _city = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void setCountry(String country) {
    if (country.length >= 3) {
      _country = ValidationItem(country, null);
    } else {
      _country = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void setPostalCode(String postCode) {
    String patttern = r'(^[0-9]{3,6}$)';
    RegExp regExp = new RegExp(patttern);
    if (postCode.length >= 3 && regExp.hasMatch(postCode)) {
      _postalCode = ValidationItem(postCode, null);
    } else {
      _postalCode = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void setBirthDay(String birthday) {
    if (birthday.length >= 3) {
      _birthDay = ValidationItem(birthday, null);
    } else {
      _birthDay = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void setGender(String gender) {
    if (gender.length >= 3) {
      _gender = ValidationItem(gender, null);
    } else {
      _gender = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void submitData() async {
    String param =
        "name=${_name.value}&mobile=${_mobile.value}&email=${_email.value}&address=${_address.value}&city=${_city.value}&country=${_country.value}&postalcode=${_postalCode.value}&birthDay=${_birthDay.value}&gender=${_gender.value}";
    String finderview = await _dynamicLinkService.createDynamicLink(
        shortn: false, route: Routes.finderView, params: param);
    if (finderview != null) {
      print(finderview);
      await launch(finderview);
    }
  }

  void initDynamicLinks() async {
    await _dynamicLinkService.handleDynamicLinks();
  }
}
