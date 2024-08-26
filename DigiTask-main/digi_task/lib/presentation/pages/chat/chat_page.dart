import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/presentation/pages/chat/chat_details_nicat.dart';
import 'package:digi_task/presentation/pages/chat/chat_details_qrup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/path/icon_path.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, this.onTap});
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(IconPath.arrowleft.toPathSvg),
        ),
        title: Text('Chat', style: context.typography.subtitle2Medium),
        actions: [
          IconButton(
              onPressed: () {}, icon: SvgPicture.asset(IconPath.menu.toPathSvg))
        ],
      ),
      body: ListView(
        children: [
          _buildChatItem(context, 'Elmar Hasanov', 'Sualım var', '12m', 2),
          _buildChatItem(context, 'Qrup 1',
              'Ilkin Aliyev: Bu tapşırığı götürəcəm', '1h', 1, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ChatDetailsQrup(chatTitle: 'Qrup 1'),
              ),
            );
          }),
          _buildChatItem(
            context,
            'Nicat Mammadov',
            'yazır...',
            '12m',
            0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const ChatDetailNicat(chatTitle: 'Nicat Mammadov'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, String name, String message,
      String time, int unreadCount,
      {GestureTapCallback? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Text(
          name[0],
          style: const TextStyle(color: Colors.blue),
        ),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      onTap: onTap ?? () {},
    );
  }
}
