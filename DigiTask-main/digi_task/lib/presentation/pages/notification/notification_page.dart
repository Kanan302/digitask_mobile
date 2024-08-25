import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {
      'email': 'texnik@mailinator.com',
      'message':
          'İstifadəçi Hyatt Mcknight adlı müştərinin tapşırığının icrasına başladı.',
      'date': '15 Avqust',
    },
    {
      'email': 'texnik@mailinator.com',
      'message':
          'İstifadəçi Hyatt Mcknight adlı müştərinin tapşırığını qəbul etdi.',
      'date': '15 Avqust',
    },
    {
      'email': 'texnik@mailinator.com',
      'message':
          'İstifadəçi Amaya Schwartz adlı müştərinin tapşırığının icrasına başladı.',
      'date': '13 Avqust',
    },
    {
      'email': 'texnik@mailinator.com',
      'message':
          'İstifadəçi Amaya Schwartz adlı müştərinin tapşırığını uğurla başa vurdu.',
      'date': '13 Avqust',
    },
  ];

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(IconPath.menu.toPathSvg),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['email']!,
                  style: const TextStyle(color: Colors.blue),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['message']!,
                  style: context.typography.body2Regular
                      .copyWith(color: context.colors.neutralColor40),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['date']!,
                  style: context.typography.body2Regular
                      .copyWith(color: context.colors.neutralColor70),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}


