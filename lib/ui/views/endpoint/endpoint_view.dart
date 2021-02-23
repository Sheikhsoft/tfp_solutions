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
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 90,
            child: CustomPaint(
              painter: RPSCustomPainter(),
              child: Container(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.navigate_before,
                        size: 40,
                        color: Colors.transparent,
                      ),
                      Text(
                        "End Point",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Icon(
                        Icons.navigate_before,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Encrypted JSon",
              style: TextStyle(fontSize: 24.0, color: Color(0xFF651FFF)),
            ),
            SizedBox(
              height: 10,
            ),
            _encryptionWidget(args.encrypted, 250),
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
          ],
        ),
      ),
      viewModelBuilder: () => EndPointViewModel(),
      onModelReady: (model) {},
    );
  }

  _encryptionWidget(Map<String, dynamic> jsonObj, double height) {
    return Container(
      height: height,
      child: SingleChildScrollView(child: JsonViewerWidget(jsonObj)),
    );
  }

  _decryptionWidget(Map<String, dynamic> jsonObj, double height) {
    return Container(
      height: height,
      child: SingleChildScrollView(child: JsonViewerWidget(jsonObj)),
    );
  }
}
