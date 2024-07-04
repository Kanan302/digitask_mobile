import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/detail_problem.dart';
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
              children: [
                ...List.generate(
                  mockData.length,
                  (index) {
                    final isServisField = mockData[index]['title'] == 'Servis';
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                          suffixIcon: isServisField
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      serviceType,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                )
                              : null,
                        ),
                        readOnly: isServisField,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Material(
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 26.0, horizontal: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Servis növü",
                                          style: context
                                              .typography.subtitle1Medium,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Hansı anketi doldurursunuz?',
                                        style: context.typography.body2Regular
                                            .copyWith(
                                          color: context.colors.neutralColor50,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (serviceType.contains('Internet'))
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: const BorderSide(
                                                      width: 4,
                                                      color: Colors.yellow),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreateProblem(
                                                            serviceType:
                                                                'Internet'),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Internet',
                                                style: context
                                                    .typography.body2SemiBold
                                                    .copyWith(
                                                  color: context
                                                      .colors.primaryColor50,
                                                ),
                                              ),
                                            ),
                                          if (serviceType.contains('Tv'))
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: const BorderSide(
                                                      width: 4,
                                                      color: Colors.yellow),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreateProblem(
                                                            serviceType: 'Tv'),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Tv',
                                                style: context
                                                    .typography.body2SemiBold
                                                    .copyWith(
                                                  color: context
                                                      .colors.primaryColor50,
                                                ),
                                              ),
                                            ),
                                          if (serviceType.contains('Voice'))
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: const BorderSide(
                                                      width: 4,
                                                      color: Colors.yellow),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreateProblem(
                                                            serviceType:
                                                                'Voice'),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Voice',
                                                style: context
                                                    .typography.body2SemiBold
                                                    .copyWith(
                                                  color: context
                                                      .colors.primaryColor50,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Problem anketi',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
