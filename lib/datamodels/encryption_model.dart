import 'package:encrypt/encrypt.dart';

class EncryptionModel {
  final String data;
  final bool hasError;
  final Map dataExtra;
  final List errors;

  EncryptionModel({this.data, this.hasError, this.dataExtra, this.errors});

  Map<String, dynamic> toJson() {
    List errors = this.errors != null
        ? this.errors.map((i) => i.toJson()).toList()
        : null;

    return {
      'data': data,
      'hasError': hasError,
      'dataExtra': dataExtra,
      'errors': errors
    };
  }
}
