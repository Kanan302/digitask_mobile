import 'package:flutter/material.dart';

class ProblemTask extends StatelessWidget {
  ProblemTask({super.key});

  final List<Map<String, dynamic>> mockData = [
    {'icon': Icons.person, 'title': 'Ad və soyad'},
    {'icon': Icons.phone, 'title': 'Qeydiyyat nömrəsi'},
    {'icon': Icons.phone_callback_outlined, 'title': 'Əlaqə nömrəsi'},
    {'icon': Icons.location_on_outlined, 'title': 'Adres'},
    {'icon': Icons.location_disabled_outlined, 'title': 'Region'},
    {'icon': Icons.miscellaneous_services_outlined, 'title': 'Servis'},
    {'icon': Icons.access_time_rounded, 'title': 'Zaman'},
    {'icon': Icons.comment_bank_outlined, 'title': 'Status'},
    {'icon': Icons.engineering_outlined, 'title': 'Texniki qrup'},
    {'icon': Icons.info_outline, 'title': 'Problem'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problem'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: List.generate(
                mockData.length,
                (index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: mockData[index]['title'] as String,
                      prefixIcon: Icon(mockData[index]['icon'] as IconData),
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
