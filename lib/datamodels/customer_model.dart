class CustomerModel {
  String data;

  CustomerModel({this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;

    return data;
  }
}
