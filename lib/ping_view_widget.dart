import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:ping_view_widget/utils/extension.dart';
import 'package:ping_view_widget/ping_view_theme_data.dart';

enum PingDirection { LEFT_TO_RIGHT, RIGHT_TO_LEFT }

class PingView extends StatefulWidget {
  final TextSpan locationInformatinText;
  final TextSpan ispInformationText;
  final TextSpan techInformationText;
  final Color startColor;
  final Color endColor;
  final PingDirection pingDirection;
  final bool running;

  PingView({
    Key? key,
    required this.locationInformatinText,
    required this.ispInformationText,
    required this.techInformationText,
    this.startColor = const Color(0xFF0e74b3),
    this.endColor = const Color(0xFF3ebdb8),
    this.pingDirection = PingDirection.LEFT_TO_RIGHT,
    this.running = false,
  }) : super(key: key);

  @override
  _PingViewState createState() => _PingViewState();
}

class _PingViewState extends State<PingView>
    with SingleTickerProviderStateMixin {
  late AnimationController pingAnimationController;

  // final TextSpan ispInformation = TextSpan(
  //   children: [
  //     TextSpan(text: 'Test Server'),
  //     TextSpan(text: '\nJaipur,Rajasthan')
  //   ],
  //   style: TextStyle(color: Colors.black, fontSize: 12),
  // );
  // final TextSpan ipInformation = TextSpan(
  //   children: [
  //     TextSpan(text: 'Internal IP : 192.168.0.15'),
  //     TextSpan(text: '\nExternal IP : 10.25.13.65')
  //   ],
  //   style: TextStyle(color: Colors.grey, fontSize: 10),
  // );
  // final TextSpan lteIformation = TextSpan(children: [
  //   TextSpan(
  //     text: 'LTE',
  //     style: TextStyle(
  //       color: Colors.black,
  //       fontSize: 11,
  //     ),
  //   ),
  // ]);

  @override
  void initState() {
    super.initState();

    pingAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat(reverse: true);
    if (widget.running) pingAnimationController.forward();

    pingAnimationController.addListener(() {
      if (pingAnimationController.isCompleted) {
        pingAnimationController.reverse();
      }
      if (pingAnimationController.isDismissed) {
        pingAnimationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    PingViewThemeData pingViewThemeData = PingViewThemeData();
    return Container(
      child: _PingViewWidgetObject(
        state: this,
        themeData: pingViewThemeData,
      ),
    );
  }
}

class _PingViewWidgetObject extends LeafRenderObjectWidget {
  _PingViewWidgetObject({required this.state, required this.themeData});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _PingViewRenderBox(
      state: state,
      themeData: themeData,
    );
  }

  final _PingViewState state;
  final PingViewThemeData themeData;

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
  }
}

class _PingViewRenderBox extends RenderBox {
  //  Color(0xff96a8ff)
  //  Color(0xFF76cbd5)
  // final Color startColor;
  // final Color endColor;
  final _PingViewState state;
  final PingViewThemeData themeData;
  late Animation<double> _pingAnimation;
  late Animation<Color?> _pingColorAnimation;

  _PingViewRenderBox({
    required this.state,
    required this.themeData,
    // this.startColor = const Color(0xFF0e74b3),
    // this.endColor = const Color(0xFF3ebdb8),
  })  : _pingAnimation = CurvedAnimation(
            parent: state.pingAnimationController, curve: Curves.easeInOut),
        _pingColorAnimation = ColorTween(
                begin: state.widget.startColor, end: state.widget.endColor)
            .animate(state.pingAnimationController);

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return Size(
      constraints.hasBoundedWidth ? constraints.maxWidth : 300,
      constraints.hasBoundedHeight ? constraints.maxHeight : 240,
    );
  }

  @override
  bool get sizedByParent => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    Canvas canvas = context.canvas;

    Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2) + offset,
        width: size.width,
        height: size.height);

    canvas.clipRect(rect);

    // canvas.drawRect(rect, Paint()..color = Colors.red.withOpacity(.5));

    canvas.translate(offset.dx, offset.dy);

    double delta = 60;

    Path? path;

    // path.moveToOffset(Offset(delta, delta));

    path = addCurveToPath(
        canvas,
        path,
        Offset(delta, delta),
        Offset(size.width - delta, delta),
        Offset(size.width + delta, size.height));

    path.lineToOffset(Offset(size.width + delta, size.height));
    path.lineToOffset(Offset(-delta, size.height));

    path = addCurveToPath(
      canvas,
      path,
      Offset(-delta, size.height),
      Offset(delta, delta),
      Offset(size.width - delta, delta),
    );

    path.close();

    //Draw rect
    // Wasted my 3hr in gradient, Flutter gradient doesn't work well with
    // paint
    canvas.drawPath(
        path,
        Paint()
          ..shader = ui.Gradient.linear(
              Offset(rect.width / 2, rect.height), Offset(rect.width / 2, 0), [
            Color(0xffCBF6F9).withOpacity(.2),
            Color(0xffCBF6F9),
          ], [
            0,
            .5
          ])
        // colors: [
        //   Colors.white,
        //   // Colors.blue,
        //   // Color(0xffE7F3F7),
        //   Color(0xffCBF6F9),
        // ],
        // begin: Alignment.topCenter,
        // end: Alignment.bottomCenter,
        // stops: [0, 1]).createShader(rect),
        );

    //Draw rect border
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);

    //Ping start point
    Offset startPoint = Offset(-delta, size.height) + Offset(delta * 2, -delta);

    //Ping end point
    Offset endPoint =
        Offset(size.width - delta, delta) + Offset(-delta / 2, delta / 2);

    //Draw start ping oval
    canvas.drawOval(Rect.fromCenter(center: startPoint, width: 20, height: 9),
        Paint()..color = state.widget.startColor);

    //Draw end ping oval
    canvas.drawOval(Rect.fromCenter(center: endPoint, width: 20, height: 9),
        Paint()..color = state.widget.endColor);

    path = Path();
    double arcRadius = (startPoint - endPoint).distance * .75;

    path.moveTo(startPoint.dx, startPoint.dy);
    path.arcToPoint(endPoint, radius: Radius.circular(arcRadius));

    //Draw path from start to end ping point
    canvas.drawPath(
        dashPath(
          path,
          dashArray: CircularIntervalList<double>(<double>[6, 6]),
        ),
        Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
    // state.pingAnimationController.addListener(() {

    //Draw ping circle with gradient animate along with path
    Offset currentPingOffset = calculate(path, _pingAnimation.value);
    canvas.drawGlowingCircle(currentPingOffset, 6,
        Paint()..color = _pingColorAnimation.value ?? Colors.transparent,
        shadowSpread: 1, spreadValue: 4);

    //Animated Path Between End point and ping point
    var stroke = Paint()
      ..color = _pingColorAnimation.value ?? Colors.transparent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawGlowingPath(
        Path()
          ..moveToOffset(
              state.widget.pingDirection == PingDirection.LEFT_TO_RIGHT
                  ? startPoint
                  : endPoint)
          ..arcToPoint(currentPingOffset,
              radius: Radius.circular(arcRadius),
              clockwise:
                  state.widget.pingDirection == PingDirection.LEFT_TO_RIGHT),
        stroke,
        shadowSpread: 1,
        spreadValue: 2);

    //Draw IPS text
    final ispPainter = TextPainter(
      text: state.widget.ispInformationText,
      textDirection: TextDirection.ltr,
    );
    ispPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final ispTextCenterOffset =
        Offset((ispPainter.width) / 2, (ispPainter.height) / 2);
    ispPainter.paint(
        canvas, (startPoint - ispTextCenterOffset).translate(0, 25));

    //Draw IP text
    final ipPainter = TextPainter(
      text: state.widget.locationInformatinText,
      textDirection: TextDirection.ltr,
    );
    ipPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final ipTextCenterOffset =
        Offset((ipPainter.width) / 2, (ipPainter.height) / 2);
    ipPainter.paint(canvas, (endPoint - ipTextCenterOffset).translate(0, 25));

    //Draw LTE text
    Offset lteTextOffset = endPoint.translate(0, -delta);

    final ltePainter = TextPainter(
      text: state.widget.techInformationText,
      textDirection: TextDirection.ltr,
    );
    ltePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final lteTextCenterOffset =
        Offset((ltePainter.width) / 2, (ltePainter.height) / 2);
    ltePainter.paint(
        canvas, (lteTextOffset - lteTextCenterOffset).translate(0, 0));

    //Draw circle around LTE text
    canvas.drawCircle(
        lteTextOffset,
        ltePainter.width / 2 + 5,
        Paint()
          ..color = state.widget.endColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);

    //Connect LTE text to end point
    canvas.drawPath(
        dashPath(
          Path()
            ..moveToOffset(endPoint)
            ..lineToOffset(
                lteTextOffset - Offset(0, -(ltePainter.width / 2 + 5))),
          dashArray: CircularIntervalList<double>(<double>[6, 6]),
        ),
        Paint()
          ..color = state.widget.endColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  Offset calculate(Path path, double value) {
    ui.PathMetrics pathMetrics = path.computeMetrics();
    ui.PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    ui.Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos?.position ?? Offset.zero;
  }

  // var temp = const Offset(0.0, 0.0);
  Path addCurveToPath(Canvas canvas, Path? path, Offset a, Offset b, Offset c,
      {double distance = 10.0}) {
    // print((a - b).distance);
    Offset p1 = calculate(
        Path()
          ..moveToOffset(a)
          ..lineToOffset(b),
        1 - distance / (a - b).distance);

    Offset p2 = calculate(
        Path()
          ..moveToOffset(b)
          ..lineToOffset(c),
        distance / (b - c).distance);

    if (path == null) {
      path = Path();
      path.moveToOffset(p1);
    }

    path.lineToOffset(p1);

    path.arcToPoint(p2, radius: Radius.circular(distance * 2.5));

    path.lineToOffset(p2);

    return path;
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _pingAnimation.addListener(markNeedsPaint);
    _pingColorAnimation.addListener(markNeedsPaint);
    // _valueIndicatorAnimation.addListener(markNeedsPaint);
    // _enableAnimation.addListener(markNeedsPaint);
    // _state.startPositionController.addListener(markNeedsPaint);
    // _state.endPositionController.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _pingAnimation.removeListener(markNeedsPaint);
    _pingColorAnimation.removeListener(markNeedsPaint);
    super.detach();
  }
}
