import 'dart:convert';

import 'package:my_app/app/locator.dart';
import 'package:my_app/datamodels/encryption_model.dart';
import 'package:my_app/services/encryption_service.dart';
import 'package:stacked/stacked.dart';

class EndPointViewModel extends BaseViewModel {
  final _encryptionService = locator<EncryptionService>();

  Future<Map<String, dynamic>> encryption(String data) async {
    EncryptionModel encryptionModel = await _encryptionService.encrypt(data);

    var joson = encryptionModel.toJson();
    Map<String, dynamic> jsonObj = joson;
    return jsonObj;
  }

  Future<Map<String, dynamic>> decryption(String data) async {
    String encryptionModel = await _encryptionService.decrypt(data);

    Map<String, dynamic> decryptedValue = jsonDecode(encryptionModel);

    return decryptedValue;
  }
}
