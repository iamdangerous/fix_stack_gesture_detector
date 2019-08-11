import 'package:fix_library_app/RevealWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return nestedWidget();
//    return customReveal();
//    return RevealWidget(Container(
//        color: Colors.red,
//        width: 300,
//        height: 100,
//        child: Row(
//          children: <Widget>[
//            Align(
//              alignment: Alignment.center,
//              child: GestureDetector(
//                behavior: HitTestBehavior.translucent,
//                onTapDown: (TapDownDetails details) {
//                  print("onTapDown");
//                },
//                onTap: _print,
//                child: Text(
//                  "Hello1",
//                  style: TextStyle(fontSize: 20),
//                ),
//              ),
//            ),
//            Align(
//              alignment: Alignment.center,
//              child: GestureDetector(
//                onTap: _print,
//                child: Text(
//                  "Hello2",
//                  style: TextStyle(fontSize: 20),
//                ),
//              ),
//            ),
//            Align(
//              alignment: Alignment.center,
//              child: GestureDetector(
//                onTap: _print,
//                child: Text(
//                  "Hello3",
//                  style: TextStyle(fontSize: 20),
//                ),
//              ),
//            )
//          ],
//        )));
  }

  void _print() {
    print("Awesome");
  }

  Widget customReveal() {
    return RevealWidget(nestedWidget());
  }

  Widget nestedWidget() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.pink,
            foregroundDecoration: BoxDecoration(color: Color.fromRGBO(155, 85, 250, 0.4)),
          ),
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print("Outside");
          },
        ),
        GestureDetector(
          child: Container(
            foregroundDecoration: BoxDecoration(color: Color.fromRGBO(155, 85, 250, 0.4)),
            color: Colors.green,
            width: 50,
            height: 50,
          ),
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print("Inside");
          },
        ),
      ],
    );
  }
}
