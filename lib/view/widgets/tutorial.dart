import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void showTutorials(
    {required GlobalKey keyName,
    required String message,
    required BuildContext context}) {
  final targets = [
    TargetFocus(
      color: Colors.pink,
      identify: 'Cart button',
      keyTarget: keyName,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) {
            return Text(
              message.toString(),
              style: const TextStyle(color: Colors.white),
            );
          },
        )
      ],
    ),
  ];

  final tutorial = TutorialCoachMark(
    targets: targets,
    onFinish: () {
      log("finish");
    },
    onClickTargetWithTapPosition: (target, tapDetails) {
      log("target: $target");
      log("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
    },
    onClickTarget: (target) {
      print(target);
    },
    // onSkip: (){
    //   print("skip");
    // }
  );
  tutorial.show(context: context);
}
