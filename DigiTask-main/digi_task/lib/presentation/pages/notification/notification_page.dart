import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/path/image_paths.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/core/utility/extension/image_path_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg)),
        title: Text('Bildirişlər', style: context.typography.subtitle2Medium),
        actions: [IconButton(onPressed: () {}, icon: SvgPicture.asset(IconPath.menu.toPathSvg))],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.emptynotification.toPathPng,
                width: 140,
                height: 140,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Bildirişləriniz yoxdur',
                style: context.typography.subtitle2Medium.copyWith(color: context.colors.neutralColor10),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Yeni bildirişləriniz burada göstəriləcək',
                style: context.typography.body2Regular.copyWith(color: context.colors.neutralColor80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
