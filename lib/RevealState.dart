import 'dart:math';

import 'package:flutter/material.dart';

import 'RevealAnimationController.dart';
import 'RevealPaint.dart';

class RevealState extends State
    with TickerProviderStateMixin, ControllerCallback {
  Widget child;
  bool enableReveal = false;
  RevealAnimationController controller;

  Offset offset;
  RevealPaint revealPaint;
  Size renderBoxSize;
  double oldLongPressDis = 0;
  double THRESHOLD_DIFF = 0.2;
  bool canRunFingerUpAnim = false;

  RevealState(Widget child) {
    this.child = child;
    controller = RevealAnimationController(this, this);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = List();
    print("enableReveal = $enableReveal");

    if (enableReveal) {
      revealPaint = RevealPaint();
      revealPaint.radius = max(renderBoxSize.height, renderBoxSize.width) + 10;
      revealPaint.fraction = controller.fraction;
      revealPaint.setAlpha(controller.alpha);
      revealPaint.offset = offset;

      widgetList.add(revealWidget(renderBoxSize, revealPaint));
    }

    widgetList.add(nestedWidget());
    return getTapWidget(widgetList);
  }

  Widget getTapWidget(List<Widget> widgetList) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Stack(children: widgetList),
      onLongPressMoveUpdate: (e) {
        handleFingerMove(e.globalPosition.distance);
      },
      onHorizontalDragUpdate: (e) {
        handleFingerMove(e.globalPosition.distance);
      },
      onVerticalDragUpdate: (e) {
        handleFingerMove(e.globalPosition.distance);
      },
      onTapUp: (e) {
        print("onTapUp");
        handleTapUp();
      },
      onLongPressUp: () {
        handleTapUp();
      },
      onTapDown: (e) {
        print("onTapDown");
        handleTapDown(e);
      },
    );
  }

  void handleFingerMove(double pos) {
    if (canRunFingerUpAnim) {
      if (oldLongPressDis == 0) {
        oldLongPressDis = pos;
      } else {
        double diff = (oldLongPressDis - pos).abs();
        oldLongPressDis = 0;
        if (diff > THRESHOLD_DIFF) {
          handleTapUp();
        }
      }
    }
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  void handleTapDown(TapDownDetails e) {
    setState(() {
      canRunFingerUpAnim = true;
      RenderBox box = context.findRenderObject();
      offset = box.globalToLocal(e.globalPosition);
      renderBoxSize = Size(box.size.width, box.size.height);
      startAnimation();
      enableReveal = true;
    });
  }

  void handleTapUp() {
    canRunFingerUpAnim = false;
    controller.stopAnimation();
  }

  void startAnimation() {
    controller.startAnimation();
  }

  Widget revealWidget(Size _size, CustomPainter paint) {
    return Container(
        color: Colors.yellow,
        child: ClipRRect(
      borderRadius: BorderRadius.zero,
      child: CustomPaint(
        size: _size,
        painter: paint,
      ),
    ));
  }

  @override
  void onAnimationUpdate(double fraction, int alpha) {
    setState(() {
      controller.fraction = fraction;
    });
  }

  @override
  void onAnimationComplete(double fraction) {
    setState(() {
      controller.fraction = fraction;
    });
  }

  @override
  void onAlphaUpdate(int alpha) {
    setState(() {
      controller.alpha = alpha;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget customReveal() {
    return nestedWidget();
  }

  Widget nestedWidget() {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.pink,
          width: 100,
          height: 100,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("Outside");
            },
          ),
        ),
        Container(
          color: Colors.green,
          width: 50,
          height: 50,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              print("Inside");
            },
          ),
        ),
      ],
    );
  }
}
