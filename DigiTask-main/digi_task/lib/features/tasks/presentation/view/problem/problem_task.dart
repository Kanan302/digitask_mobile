import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_detail.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_dialog.dart';
import 'package:flutter/material.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/task_service.dart';

class ProblemTask extends StatefulWidget {
  final String serviceType;
  final int taskId;
  final TaskModel taskData;

  const ProblemTask({
    super.key,
    required this.serviceType,
    required this.taskId,
    required this.taskData,
  });

  @override
  _ProblemTaskState createState() => _ProblemTaskState();
}

class _ProblemTaskState extends State<ProblemTask> {
  late Future<TaskModel> task;
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
    {'icon': null, 'title': 'Qeyd'},
  ];

  @override
  void initState() {
    super.initState();
    task = TaskService().fetchTask(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problem'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<TaskModel>(
            future: task,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text('No data available'));
              } else {
                final taskData = snapshot.data!;
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ...mockData.map((data) {
                        final isServisField = data['title'] == 'Servis';
                        final suffixText =
                            _getSuffixText(taskData, data['title'] as String);
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: TextField(
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              labelText: data['title'] as String,
                              labelStyle: const TextStyle(color: Colors.black, fontSize: 18),
                              prefixIcon: data['icon'] != null
                                  ? Icon(
                                      data['icon'] as IconData,
                                      color: Colors.blue,
                                    )
                                  : null,
                              suffixIcon: isServisField
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.serviceType,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    )
                                  : null,
                            ),
                            readOnly: true,
                            controller: TextEditingController(text: suffixText),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      if (widget.serviceType != null)
                        ServiceDetailsWidget(
                          serviceType: widget.serviceType,
                          taskId: widget.taskId,
                          taskData: taskData,
                        ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ServiceDialog(
                                  serviceType: widget.serviceType,
                                  taskId: widget.taskId,
                                  taskData: widget.taskData,
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
                );
              }
            },
          ),
        ),
      ),
    );
  }

  String _getSuffixText(TaskModel taskData, String title) {
    switch (title) {
      case 'Ad və soyad:':
        return taskData.fullName ?? '';
      case 'Qeydiyyat nömrəsi':
        return taskData.registrationNumber ?? '';
      case 'Əlaqə nömrəsi':
        return taskData.contactNumber ?? '';
      case 'Adres':
        return taskData.location ?? '';
      case 'Region':
        return taskData.group?.isNotEmpty == true
            ? taskData.group!.first.region ?? ''
            : 'N/A';
      case 'Zaman':
        return '${taskData.date}, ${taskData.time}';
      case 'Status':
        return taskData.status ?? '';
      case 'Texniki qrup':
        return taskData.group?.isNotEmpty == true
            ? taskData.group!.first.group ?? ''
            : 'N/A';
      case 'Qeyd':
        return taskData.note ?? '';
      default:
        return '';
    }
  }
}
