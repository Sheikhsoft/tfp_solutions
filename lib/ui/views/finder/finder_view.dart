import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/app/router.gr.dart';
import 'package:my_app/ui/smart_widgets/appbar.dart';
import 'package:stacked/stacked.dart';

import 'finder_viewmodel.dart';

class FinderView extends StatelessWidget {
  final Map<String, String> argumentValue;

  const FinderView({Key key, this.argumentValue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final FinderViewArguments args = ModalRoute.of(context).settings.arguments;
    print("from profile page ${args.argumentValue}");

    return ViewModelBuilder<FinderViewModel>.reactive(
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
                        "Finder",
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: (model.latlong != null)
              ? GoogleMap(
                  myLocationEnabled: true,
                  compassEnabled: true,
                  tiltGesturesEnabled: false,
                  markers: model.markersNew,
                  mapType: MapType.normal,
                  initialCameraPosition: model.cameraPosition,
                  onMapCreated: model.onMapCreated)
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => model.navigateToEndPoint(args.argumentValue),
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
          backgroundColor: Color(0xFF651FFF),
        ),
      ),
      viewModelBuilder: () => FinderViewModel(),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.getCurrentLocation()),
    );
  }
}
