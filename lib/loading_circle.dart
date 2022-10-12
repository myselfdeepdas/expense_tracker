import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:widget_loading/widget_loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 75,
        width: 75,
        child: SpinKitSpinningLines	(
          color: Color(0xFF3A69F9),
          size: 70.0,
        ),
      ),
    );
  }
}
