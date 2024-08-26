import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class ChatDetailsQrup extends StatelessWidget {
  final String chatTitle;

  const ChatDetailsQrup({super.key, required this.chatTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.groups_2_sharp,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chatTitle, style: context.typography.subtitle2Medium),
                const Text(
                  "İlkin Aliyev,Nicat Mammadov, Mən",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildReceivedMessage(context, 'Nicat Mammadov', "problem var",
                  "19:34", Colors.blue),
              _buildReceivedMessage(context, 'Nicat Mammadov',
                  "tapşırğı tamamlaya bilməyəcəm", "19:34", Colors.blue),
              _buildReceivedMessage(
                  context, 'Elmar Hasanov', "Niyə?", "19:34", Colors.green),
              _buildReceivedMessage(context, 'Nicat Mammadov', "vaxtım yoxdur",
                  "19:34", Colors.blue),
              _buildReceivedMessage(context, 'Nicat Mammadov',
                  "tapşırıq 12:30 da bitməlidi", "19:34", Colors.blue),
              _buildReceivedMessage(context, 'İlkin Aliyev',
                  "Bu tapşırığı götürəcəm", "19:34", const Color(0xFF3D8BA4)),
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String name,
      String message, String time, Color? color) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(
              name[0],
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style:
                        TextStyle(color: color, fontWeight: FontWeight.bold)),
                Text(message, style: const TextStyle(color: Colors.black)),
                const SizedBox(height: 5),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
