import 'package:flutter/material.dart';
import 'package:my_app/app/locator.dart';
import 'package:my_app/ui/setup_bottom_sheet_ui.dart';
import 'package:my_app/ui/setup_dialog_ui.dart';

import 'package:stacked_services/stacked_services.dart';

import 'app/router.gr.dart' as auto_router;
import 'app/router.gr.dart';

void main() {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF651FFF),
      ),
      title: 'TFP Solutions',
      //home: DialogExampleView(),
      initialRoute: Routes.startupView,
      onGenerateRoute: auto_router.Router().onGenerateRoute,
      navigatorKey: locator<DialogService>().navigatorKey,
    );
  }
}
