library loading;

import 'package:flutter/material.dart';

import 'decorate/decorate.dart';
import 'indicators/ball_triangle_path.dart';

///34 different types animation enums.
enum Indicator {
  ballPulse,
  ballGridPulse,
  ballClipRotate,
  squareSpin,
  ballClipRotatePulse,
  ballClipRotateMultiple,
  ballPulseRise,
  ballRotate,
  cubeTransition,
  ballZigZag,
  ballZigZagDeflect,
  ballTrianglePath,
  ballTrianglePathColored,
  ballTrianglePathColoredFilled,
  ballScale,
  lineScale,
  lineScaleParty,
  ballScaleMultiple,
  ballPulseSync,
  ballBeat,
  lineScalePulseOut,
  lineScalePulseOutRapid,
  ballScaleRipple,
  ballScaleRippleMultiple,
  ballSpinFadeLoader,
  lineSpinFadeLoader,
  triangleSkewSpin,
  pacman,
  ballGridBeat,
  semiCircleSpin,
  ballRotateChase,
  orbit,
  audioEqualizer,
  circleStrokeSpin,
}

/// Entrance of the loading.
class LoadingIndicator extends StatelessWidget {
  /// Indicate which type.
  final Indicator indicatorType;

  /// The color you draw on the shape.
  final Color color;
  final List<Color> colors;

  LoadingIndicator({
    Key key,
    this.indicatorType = Indicator.ballTrianglePath,
    this.color,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actualColor = color ?? Theme.of(context).primaryColor;
    return Container(
      width: 44,
      height: 44,
      child: DecorateContext(
        decorateData: DecorateData(indicator: indicatorType, color: actualColor, colors: colors),
        child: AspectRatio(
          aspectRatio: 1,
          child: BallTrianglePath(),
        ),
      ),
    );
  }
}
