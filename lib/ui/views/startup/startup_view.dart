import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:injectable/injectable.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends HookWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();

    return ViewModelBuilder<StartupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: Lottie.asset('assets/lottie/devs-app.json',
                controller: animationController, onLoaded: (composition) {
              animationController.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  model.indecateAnimationComplite();
                }
              });
              animationController
                ..duration = composition.duration
                ..forward();
            }),
          ),
        ),
      ),
      onModelReady: (model) => SchedulerBinding.instance
          .addPostFrameCallback((_) => model.initialise()),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
