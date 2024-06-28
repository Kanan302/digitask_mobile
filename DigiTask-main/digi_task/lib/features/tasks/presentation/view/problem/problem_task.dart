import 'package:flutter/material.dart';

class ProblemTask extends StatelessWidget {
  final String serviceType;
  ProblemTask({super.key, required this.serviceType});

  final List<Map<String, dynamic>> mockData = [
    {'icon': Icons.person_2_outlined, 'title': 'Ad və soyad:'},
    {'icon': Icons.phone, 'title': 'Qeydiyyat nömrəsi'},
    {'icon': Icons.phone_callback_outlined, 'title': 'Əlaqə nömrəsi'},
    {'icon': Icons.location_on_outlined, 'title': 'Adres'},
    {'icon': Icons.location_disabled_outlined, 'title': 'Region'},
    {'icon': Icons.miscellaneous_services_outlined, 'title': 'Servis'},
    {'icon': Icons.access_time_rounded, 'title': 'Zaman'},
    {'icon': Icons.comment_bank_outlined, 'title': 'Status'},
    {'icon': Icons.engineering_outlined, 'title': 'Texniki qrup'},
    {'icon': Icons.info_outline, 'title': 'Problem'},
    {'icon': null, 'title': 'Qeyd'},
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
                (index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: mockData[index]['title'] as String,
                        labelStyle: const TextStyle(color: Colors.black),
                        prefixIcon: mockData[index]['icon'] != null
                            ? Icon(
                                mockData[index]['icon'] as IconData,
                                color: Colors.blue,
                              )
                            : null,
                        suffix: mockData[index]['title'] == 'Servis'
                            ? Text(
                                serviceType,
                                style: const TextStyle(color: Colors.black),
                              )
                            : null,
                      ),
                      readOnly: mockData[index]['title'] == 'Servis',
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
