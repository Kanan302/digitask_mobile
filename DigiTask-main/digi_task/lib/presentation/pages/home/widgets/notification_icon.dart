import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
    required this.iconPath, required this.onTap,
  });
  final String iconPath;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
