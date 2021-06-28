import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.scale(
          scale:1.4,
          child: Center(
            child: Align(
              alignment: Alignment.center,
              child: SpinKitDualRing(
                size: MediaQuery.of(context).size.width*0.35,
                color: Colors.greenAccent,
                lineWidth: 2,
              ),
            ),
          ),
        ),
        Center(
          child: GlowIcon(
            Icons.airplanemode_active,
            size: MediaQuery.of(context).size.width*0.35,
            color: Colors.green,
            blurRadius: 75,
          ),
        ),
      ],
    );
  }
}
