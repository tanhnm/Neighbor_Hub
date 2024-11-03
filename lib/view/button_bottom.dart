import 'package:flutter/material.dart';

class ButtonBottom extends StatelessWidget {
  const ButtonBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Column(children: [
        // Search input and suggestions code here...
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double x = scaffoldGeometry.scaffoldSize.width * 0.9 - 28;
    double y = scaffoldGeometry.scaffoldSize.height * 0.70 - 28;
    return Offset(x, y);
  }
}
