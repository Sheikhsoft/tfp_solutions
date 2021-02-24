import 'dart:convert';
import 'dart:typed_data';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_app/app/locator.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/datamodels/customer.dart';
import 'package:my_app/datamodels/validation_item.dart';
import 'package:my_app/services/customer_service.dart';
import 'package:my_app/services/dynamic_link_service.dart';
import 'package:my_app/services/encryption_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dynamicLinkService = locator<DynamicLinkService>();
  final _customerService = locator<CustomerService>();
  final _encryptionService = locator<EncryptionService>();
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _mobile = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _address = ValidationItem(null, null);
  ValidationItem _city = ValidationItem(null, null);
  ValidationItem _country = ValidationItem(null, null);
  ValidationItem _postalCode = ValidationItem(null, null);
  ValidationItem _birthDay = ValidationItem(null, null);
  ValidationItem _gender = ValidationItem(null, null);
  ValidationItem _idType = ValidationItem(null, null);
  ValidationItem _idNumber = ValidationItem(null, null);
  ValidationItem _statevalue = ValidationItem(null, null);
  ValidationItem _nationality = ValidationItem(null, null);

  ValidationItem get name => _name;
  ValidationItem get mobile => _mobile;
  ValidationItem get email => _email;
  ValidationItem get address => _address;
  ValidationItem get city => _city;
  ValidationItem get country => _country;
  ValidationItem get postalCode => _postalCode;
  ValidationItem get birthDay => _birthDay;
  ValidationItem get gender => _gender;
  ValidationItem get idType => _idType;
  ValidationItem get idNumber => _idNumber;
  ValidationItem get statevalue => _statevalue;
  ValidationItem get nationality => _nationality;

  Image _customerPhoto;
  Image get customerPhoto => _customerPhoto;

  String _linkMessage;
  bool _isCreatingLink = false;

  Customer _customer;
  Customer get customer => _customer;

  String get linkMessage => _linkMessage;
  bool get isCreatingLink => _isCreatingLink;

  bool get canSubmit =>
      _name.value.length > 3 && (EmailValidator.validate(_email.value));

  Uint8List _bytes;
  Uint8List get imageBytes => _bytes;

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
    //String patttern = r'(^[0-9]{3,6}$)';
    //RegExp regExp = new RegExp(patttern);
    _postalCode = ValidationItem(postCode, null);
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
    _gender = ValidationItem(gender, null);
    notifyListeners();
  }

  void setIdType(String value) {
    _idType = ValidationItem(value, null);
    notifyListeners();
  }

  void setIdNumber(String value) {
    if (value.length >= 5) {
      _idNumber = ValidationItem(value, null);
    } else {
      _idNumber = ValidationItem(null, "Must be at least 3 characters");
    }

    notifyListeners();
  }

  void setStateValue(String value) {
    _statevalue = ValidationItem(value, null);

    notifyListeners();
  }

  void setNationality(String value) {
    if (value.length >= 5) {
      _nationality = ValidationItem(value, null);
    } else {
      _nationality = ValidationItem(null, "Must be at least 3 characters");
    }

    notifyListeners();
  }

  void submitData() async {
    String param =
        "name=${_name.value}&mobile=${_mobile.value}&email=${_email.value}&address=${_address.value}&city=${_city.value}&country=${_country.value}&postalcode=${_postalCode.value}&birthDay=${_birthDay.value}&gender=${_gender.value}&idType=${_idType.value}&idNumber=${_idNumber.value}&state=${_statevalue.value}&nationality=${_nationality.value}";
    String finderview = await _dynamicLinkService.createDynamicLink(
        shortn: false, route: Routes.finderView, params: param);
    if (finderview != null) {
      print(finderview);
      await launch(finderview);
    }
  }

  void initDynamicLinks() async {
    await getCustomerData();
    await _dynamicLinkService.handleDynamicLinks();
  }

  Future getCustomerData() async {
    String encryptedString = await _customerService.getCustomerData();
    String decryptingString = await decryptString(encryptedString);
    Map<dynamic, dynamic> jsonValue = jsonDecode(decryptingString);
    print(jsonValue);
    _customer = Customer.fromJson(json.decode(decryptingString));

    // put them here
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String imagenJson = _customer.photos;
    Uint8List _image = base64Decode(imagenJson);
    _customerPhoto = Image.memory(_image);

    notifyListeners();
    setName("${_customer.firstName} ${_customer.lastName}");
    setEmail(_customer.emailAddress);
    setCity(_customer.city);
    setPostalCode(_customer.postCode.toString());
    setCountry(_customer.country);
    setAddress(_customer.address);
    setBirthDay(_customer.dateOfBirth);
    setGender(_customer.gender);
    setIdNumber(_customer.idNumber);
    setNationality(_customer.nationality);
    setIdType(_customer.idType);
    print("state value ${_customer.state}");
    setStateValue(_customer.state);
  }

  Future<String> decryptString(String enctypedString) async {
    String decryptValue = await _encryptionService.decrypt(enctypedString);
    //print(decryptValue);
    return decryptValue;
  }
}
