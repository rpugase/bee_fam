import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/images.dart';

class BeeBackground extends StatelessWidget {

  final Widget child;

  const BeeBackground({
    super.key,
    required this.child,
  });

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