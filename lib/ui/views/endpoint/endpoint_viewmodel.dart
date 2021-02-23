import 'dart:convert';

import 'package:my_app/app/locator.dart';
import 'package:my_app/datamodels/encryption_model.dart';
import 'package:my_app/services/encryption_service.dart';
import 'package:stacked/stacked.dart';

class EndPointViewModel extends BaseViewModel {
  final _encryptionService = locator<EncryptionService>();
  Future<Map<dynamic, dynamic>> encryption(String data) async {
    EncryptionModel encryptionModel = await _encryptionService.encrypt(data);

    var joson = encryptionModel.toJson();
    Map<dynamic, dynamic> jsonObj = joson;
    return jsonObj;
  }
}
