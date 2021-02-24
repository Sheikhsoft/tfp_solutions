import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/ui/smart_widgets/appbar.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'endpoint_viewmodel.dart';

class EndPointView extends HookWidget {
  final String decrypted;
  final Map<dynamic, dynamic> encrypted;
  const EndPointView({Key key, this.decrypted, this.encrypted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 2;
    final EndPointViewArguments args =
        ModalRoute.of(context).settings.arguments;
    //print("from profile page ${args.e}");
    Map<String, dynamic> decryptedValue = jsonDecode(args.decrypted);
    //Map<String, dynamic> encryptedValue = jsonDecode(args.encrypted);

    return ViewModelBuilder<EndPointViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 90),
          child: AppBarWedget(
            title: "End Point",
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Decrypted JSon",
              style: TextStyle(fontSize: 24.0, color: Color(0xFF651FFF)),
            ),
            SizedBox(
              height: 10,
            ),
            _decryptionWidget(decryptedValue, height - 100.0),
            Text(
              "Thank You",
              style: TextStyle(fontSize: 24.0, color: Color(0xFF651FFF)),
            ),
            Text(
              "Developed By",
              style: TextStyle(fontSize: 18.0, color: Color(0xFF651FFF)),
            ),
            Text(
              "Sk Shamimul Islam",
              style: TextStyle(fontSize: 26.0, color: Color(0xFF651FFF)),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => EndPointViewModel(),
      onModelReady: (model) {},
    );
  }

  _decryptionWidget(Map<String, dynamic> jsonObj, double height) {
    return Container(
      height: height,
      child: SingleChildScrollView(child: JsonViewerWidget(jsonObj)),
    );
  }
}
