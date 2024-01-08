// ignore_for_file: library_private_types_in_public_api

import 'package:checkmate/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(); // Animates the rotation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Transform.rotate(
        angle: -0.5 * 3.1415, // Adjust the starting angle if needed
        child: const CircularStepProgressIndicator(
            totalSteps: 100,
            currentStep: 72,
            selectedColor: Constants.primaryColor,
            unselectedColor: Constants.tertiaryColor,
            padding: 0,
            width: 80,
            height: 80,
            circularDirection: CircularDirection.clockwise,
            child: Icon(
              Icons.tag_faces,
              color: Constants.primaryColor,
              size: 65,
            ),
          )
      ),
    );
  }
}
