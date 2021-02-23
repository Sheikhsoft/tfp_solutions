import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/datamodels/encryption_model.dart';

@lazySingleton
class EncryptionService {
  final iv = IV.fromBase64("08rxdn/twix5AIm0YMBetQ==");
  final encrypter = Encrypter(AES(
      Key.fromBase64('Jn0evvsplJkGmXSRwoNo252vogmqwfZOqa3tFi6NgOA='),
      mode: AESMode.cbc));

  Future<EncryptionModel> encrypt(dynamic encryptValue) async {
    final encrypted = encrypter.encrypt(encryptValue, iv: iv);

    return EncryptionModel(
        data: encrypted.base64.toString(),
        hasError: false,
        dataExtra: {},
        errors: []);
  }

  Future<String> decrypt(Encrypted encryptValue) async {
    final decrypted = encrypter.decrypt(encryptValue, iv: iv);

    return decrypted;
  }
}
