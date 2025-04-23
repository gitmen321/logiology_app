import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const CustomLoader({
    super.key,
    this.size = 50.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPianoWave(
        type: SpinKitPianoWaveType.end,
        size: size,
        color: Colors.white,// Use theme color or fallback
      ),
    );
  }
}