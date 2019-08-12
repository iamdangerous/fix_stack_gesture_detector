import 'package:fix_library_app/RevealWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return nestedWidget();
  }

  Widget customReveal() {
    return RevealWidget(nestedWidget());
  }

  Widget nestedWidget() {
    return Stack(
      children: <Widget>[
        getGestureWidget(100, 100, Colors.pink, "outside"),
        getGestureWidget(50, 50, Colors.green, "inside"),
      ],
    );
  }


  Widget getGestureWidget(double width, double height, Color color, String message){
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        color: color,
        width: width,
        height: height,
      ),
      onTap: () {
        print(message);
      },
    );
  }

  Widget getAnimatedWidget(double width, double height, Color color, String message){
    return AnimatedContainer(
      height: height,
      width: width,
      duration: Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Material(
        color: color,
        child: InkWell(
          onTap: () {
            print(message);
          },
        ),
      ),
    );
  }
}
