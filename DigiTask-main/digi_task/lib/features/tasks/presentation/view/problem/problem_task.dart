import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/task_service.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_detail.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:digi_task/notifier/home/main/main_notifier.dart';

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
        final date = taskData.date ?? '-';
        final startTime = taskData.startTime ?? '-';
        final endTime = taskData.endTime ?? '-';
        return '$date, $startTime - $endTime'; // e.g., "2023-08-17, 14:30:00 - 16:30:00"

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

  Future<void> _updateTask() async {
    try {
      final Dio dio = Dio();

      String formattedStartTime = '';
      String formattedEndTime = '';

      if (widget.taskData.startTime != null &&
          widget.taskData.startTime!.isNotEmpty) {
        try {
          final parsedStartTime =
              DateFormat('HH:mm').parse(widget.taskData.startTime!);
          formattedStartTime = DateFormat('HH:mm:ss').format(parsedStartTime);
        } catch (e) {
          print('Error parsing start time: $e');
        }
      }

      if (widget.taskData.endTime != null &&
          widget.taskData.endTime!.isNotEmpty) {
        try {
          final parsedEndTime =
              DateFormat('HH:mm').parse(widget.taskData.endTime!);
          formattedEndTime = DateFormat('HH:mm:ss').format(parsedEndTime);
        } catch (e) {
          print('Error parsing end time: $e');
        }
      }

      List<int?> groupIds = widget.taskData.group != null
          ? widget.taskData.group!.map((g) => g.id).toList()
          : [];

      Map<String, dynamic> updateData = {
        "full_name": widget.taskData.fullName ?? "",
        "start_time": formattedStartTime,
        "end_time": formattedEndTime,
        "registration_number": widget.taskData.registrationNumber ?? "",
        "contact_number": widget.taskData.contactNumber ?? "",
        "location": widget.taskData.location ?? "",
        "status": widget.taskData.status,
        "group": groupIds,
        "note": widget.taskData.note ?? "",
        "is_tv": widget.taskData.isTv ?? false,
        "is_voice": widget.taskData.isVoice ?? false,
        "is_internet": widget.taskData.isInternet ?? false,
        "date": widget.taskData.date,
      };

      final String uri =
          'http://135.181.42.192/services/update_task/${widget.taskId}/';

      final response = await dio.patch(
        uri,
        data: updateData,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task updated successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update task: ${response.statusMessage}'),
          ),
        );
        print('Failed to update task: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioException) {
        print('Dio error: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating task: ${e.response?.data}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Error updating task: An unknown error occurred')),
          );
        }
      } else {
        print('Unknown error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Error updating task: An unknown error occurred')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    task = TaskService().fetchTask(widget.taskId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainNotifier>().checkAdmin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.watch<MainNotifier>().isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Problem'),
        backgroundColor: Colors.white,
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(
                Icons.save,
                color: Colors.blue,
              ),
              onPressed: _updateTask,
            ),
        ],
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
                final availableServiceTypes =
                    _getAvailableServiceTypes(taskData);
                final hasAvailableServices = availableServiceTypes.isNotEmpty;
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
                          child: TextFormField(
                            initialValue: suffixText,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              labelText: data['title'] as String,
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                textBaseline: TextBaseline.alphabetic,
                              ),
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
                            readOnly: !isAdmin || isServisField,
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      if (widget.serviceType.isNotEmpty)
                        ServiceDetailsWidget(
                          serviceType: widget.serviceType,
                          taskId: widget.taskId,
                          taskData: taskData,
                        ),
                      const SizedBox(height: 16),
                      if (hasAvailableServices)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

  List<String> _getAvailableServiceTypes(TaskModel taskData) {
    List<String> availableServiceTypes = [];
    if (taskData.isInternet == true && taskData.internet == null) {
      availableServiceTypes.add('Internet');
    }
    if (taskData.isTv == true && taskData.tv == null) {
      availableServiceTypes.add('TV');
    }
    if (taskData.isVoice == true && taskData.voice == null) {
      availableServiceTypes.add('Voice');
    }
    return availableServiceTypes;
  }
}
