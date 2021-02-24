import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/datamodels/customer_model.dart';

@lazySingleton
class Api {
  static const endPoint =
      'https://onecalltest.tfp.com.my:9443/api/Home/DemoApi/GetCustomer/';

  var client = new http.Client();

  Future<CustomerModel> getCustomerData() async {
    var response = await client.get(endPoint);
    print('response:$response');
    var parsed = json.decode(response.body);
    return CustomerModel.fromJson(parsed);
  }
}
