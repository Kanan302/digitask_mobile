import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/path/icon_path.dart';

class SelectTimeCard extends StatefulWidget {
  const SelectTimeCard({super.key});

  @override
  State<SelectTimeCard> createState() => _SelectTimeCardState();
}

class _SelectTimeCardState extends State<SelectTimeCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.neutralColor100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '01/06/2023',
                style: context.typography.body1SemiBold.copyWith(color: context.colors.neutralColor50),
              ),
              const SizedBox(
                width: 12,
              ),
              SvgPicture.asset(IconPath.date.toPathSvg),
            ],
          ),
        ),
      ),
    );
  }
}
