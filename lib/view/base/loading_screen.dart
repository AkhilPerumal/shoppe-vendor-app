import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.flickr(
          leftDotColor: const Color(0xFF4B4B4D),
          rightDotColor: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
    );
  }
}
