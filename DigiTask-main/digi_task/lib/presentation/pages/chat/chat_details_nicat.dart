import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class ChatDetailNicat extends StatelessWidget {
  final String chatTitle;

  const ChatDetailNicat({super.key, required this.chatTitle});

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
              child: Text(
                chatTitle[0],
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chatTitle, style: context.typography.subtitle2Medium),
                const Text(
                  "Online",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green,
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
                _buildReceivedMessage(
                    context, "problem var", "19:34", chatTitle),
                _buildReceivedMessage(context, "tapşırığı tamamlaya bilməyəcəm",
                    "19:34", chatTitle),
                _buildSentMessage(context, "Problem nədir?", "19:34"),
                _buildReceivedMessage(
                    context, "vaxtım yoxdur", "19:34", chatTitle),
                _buildReceivedMessage(context, "tapşırıq 12:30 da bitməlidir",
                    "19:34", chatTitle),
                _buildSentMessage(
                    context, "Başqa texniki yönləndiririk", "19:34"),
                _buildReceivedMessage(
                    context, "təşəkkür edirəm", "19:34", chatTitle),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(
      BuildContext context, String message, String time, String? title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(
              title![0],
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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

  Widget _buildSentMessage(BuildContext context, String message, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 113, 203),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(
              time,
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Mesaj yaz",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
