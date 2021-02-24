import 'package:injectable/injectable.dart';
import 'package:my_app/app/locator.dart';
import 'package:my_app/datamodels/customer_model.dart';
import 'package:my_app/services/api.dart';

@lazySingleton
class CustomerService {
  final _api = locator<Api>();

  Future<String> getCustomerData() async {
    var customerModel = await _api.getCustomerData();
    return customerModel.data;
  }
}
