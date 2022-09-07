import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/images.dart';

class BeeBackground extends StatelessWidget {

  final Widget child;

  const BeeBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          Images.bgSvg,
          fit: BoxFit.fill,
        ),
        child,
      ],
    );
  }
}