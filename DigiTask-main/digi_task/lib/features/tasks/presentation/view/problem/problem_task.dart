import 'dart:async';
import 'package:digi_task/features/tasks/presentation/view/problem/task_service.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_card.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_dropdown.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_multiselect.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/problem_timefield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:digi_task/features/tasks/data/model/task_model.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_detail.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/widgets/service_dialog.dart';
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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController fullNameController;
  late TextEditingController registrationNumberController;
  late TextEditingController contactNumberController;
  late TextEditingController locationController;
  late TextEditingController statusController;
  late TextEditingController groupController;
  late TextEditingController noteController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  String? selectedTechnicalGroup;
  String? selectedStatus;
  List<String> selectedServices = [];

  final List<String> statusOptions = ['completed', 'inprogress', 'waiting'];
  final List<String> technicalGroupOptions = ['Qrup 1', 'Qrup 2'];
  final List<String> services = ['Tv', 'Internet', 'Voice'];

  final List<Map<String, dynamic>> mockData = [
    {'icon': Icons.person_2_outlined, 'title': 'Ad və soyad:'},
    {'icon': Icons.phone, 'title': 'Qeydiyyat nömrəsi'},
    {'icon': Icons.phone_callback_outlined, 'title': 'Əlaqə nömrəsi'},
    {'icon': Icons.location_on_outlined, 'title': 'Adres'},
    {'icon': Icons.miscellaneous_services_outlined, 'title': 'Servis'},
    {'icon': Icons.date_range_outlined, 'title': 'Tarix'},
    {'icon': null, 'title': 'Qeyd'},
  ];

  @override
  void initState() {
    super.initState();
    task = TaskService().fetchTask(widget.taskId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainNotifier>().checkAdmin();
    });

    fullNameController =
        TextEditingController(text: widget.taskData.fullName ?? '');
    registrationNumberController =
        TextEditingController(text: widget.taskData.registrationNumber ?? '');
    contactNumberController =
        TextEditingController(text: widget.taskData.contactNumber ?? '');
    locationController =
        TextEditingController(text: widget.taskData.location ?? '');
    statusController =
        TextEditingController(text: widget.taskData.status ?? '');
    groupController = TextEditingController(
      text: widget.taskData.group != null &&
              widget.taskData.group!.isNotEmpty &&
              widget.taskData.group![0].group != null
          ? widget.taskData.group![0].group
          : '',
    );
    noteController = TextEditingController(text: widget.taskData.note ?? '');
    dateController = TextEditingController(text: widget.taskData.date ?? '');
    startTimeController = TextEditingController(
      text: widget.taskData.startTime != null
          ? DateFormat('HH:mm')
              .format(DateFormat('HH:mm:ss').parse(widget.taskData.startTime!))
          : '',
    );

    endTimeController = TextEditingController(
      text: widget.taskData.endTime != null
          ? DateFormat('HH:mm')
              .format(DateFormat('HH:mm:ss').parse(widget.taskData.endTime!))
          : '',
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    registrationNumberController.dispose();
    contactNumberController.dispose();
    locationController.dispose();
    statusController.dispose();
    groupController.dispose();
    noteController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final selectedDateTime = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);

      final fullTime = DateFormat('HH:mm:ss').format(selectedDateTime);
      final displayTime = DateFormat('HH:mm:ss').format(selectedDateTime);

      setState(() {
        controller.text = displayTime;
        if (controller == startTimeController) {
          widget.taskData.startTime = fullTime;
        } else if (controller == endTimeController) {
          widget.taskData.endTime = fullTime;
        }
      });

      print(
          'Updated ${controller == startTimeController ? 'Start Time' : 'End Time'}: $displayTime');
    }
  }

  Future<TaskModel> _fetchProblem() async {
    try {
      final Dio dio = Dio();
      final String url =
          'http://135.181.42.192/services/task/${widget.taskId}/';

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final taskData = TaskModel.fromJson(response.data);
        return taskData;
      } else {
        throw Exception('Failed to fetch task: ${response.statusMessage}');
      }
    } catch (e) {
      String errorMessage = 'Error fetching task: An unknown error occurred';
      if (e is DioException) {
        if (e.response != null) {
          errorMessage = 'Error fetching task: ${e.response?.data}';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
      return Future.error(errorMessage);
    }
  }

  Future<void> _updateTask() async {
    try {
      final Dio dio = Dio();
      final selectedGroup =
          selectedTechnicalGroup ?? widget.taskData.group?.first.group ?? '';
      final groupId = selectedGroup == 'Qrup 1' ? 1 : 2;
      final groupData = groupId != null ? [groupId] : [];

      Map<String, dynamic> updateData = {
        "full_name": fullNameController.text,
        "start_time": widget.taskData.startTime,
        "end_time": widget.taskData.endTime,
        "registration_number": registrationNumberController.text,
        "contact_number": contactNumberController.text,
        "location": locationController.text,
        "status": statusController.text,
        "note": noteController.text,
        "is_tv": widget.taskData.isTv ?? false,
        "is_voice": widget.taskData.isVoice ?? false,
        "is_internet": widget.taskData.isInternet ?? false,
        "date": dateController.text,
        "group": groupData,
      };

      print('Update Data: $updateData');

      final String uri =
          'http://135.181.42.192/services/update_task/${widget.taskId}/';

      final response = await dio.patch(uri, data: updateData);
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 200) {
        setState(() {
          task = _fetchProblem();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task updated successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update task: ${response.statusMessage}'),
          ),
        );
      }
    } catch (e) {
      String errorMessage = 'Error updating task: An unknown error occurred';
      if (e is DioException) {
        if (e.response != null) {
          errorMessage = 'Error updating task: ${e.response?.data}';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
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
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await _updateTask();
                }
              },
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
                fullNameController.text = taskData.fullName ?? '';
                registrationNumberController.text =
                    taskData.registrationNumber ?? '';
                contactNumberController.text = taskData.contactNumber ?? '';
                locationController.text = taskData.location ?? '';
                selectedStatus ??= taskData.status;
                statusController.text = selectedStatus ?? "";

                // startTimeController.text = taskData.startTime ?? '-';
                // endTimeController.text = taskData.endTime ?? '';

                noteController.text = taskData.note ?? '';
                dateController.text = taskData.date ?? '';
                groupController.text = (taskData.group != null &&
                        taskData.group!.isNotEmpty &&
                        taskData.group![0].group != null
                    ? taskData.group![0].group
                    : '')!;

                final availableServiceTypes =
                    _getAvailableServiceTypes(taskData);
                final hasAvailableServices = availableServiceTypes.isNotEmpty;
                return Container(
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ...mockData
                            .where((data) => data['title'] != 'Saat')
                            .map((data) {
                          final isServisField = data['title'] == 'Servis';
                          final controller =
                              _getControllerForTitle(data['title'] as String);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: TextFormField(
                              controller: controller,
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
                              onTap: () {
                                if (data['title'] == 'Saat') {
                                  _selectTime(context, controller);
                                }
                              },
                              readOnly: !isAdmin || isServisField,
                              validator: data['title'] == 'Tarix'
                                  ? (value) {
                                      final datePattern =
                                          RegExp(r'^\d{4}-\d{2}-\d{2}$');
                                      if (value == null ||
                                          !datePattern.hasMatch(value)) {
                                        return 'Tarix formatı yyyy-mm-dd olmalıdır';
                                      }
                                      return null;
                                    }
                                  : null,
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TimeSelectionField(
                                labelText: 'Başlangıç Saatı',
                                controller: startTimeController,
                                isAdmin: isAdmin,
                                onTap: () async {
                                  await _selectTime(
                                      context, startTimeController);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TimeSelectionField(
                                labelText: 'Bitiş Saatı',
                                controller: endTimeController,
                                isAdmin: isAdmin,
                                onTap: () async {
                                  await _selectTime(context, endTimeController);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: DropdownWithIcon(
                                  labelText: 'Status',
                                  icon: Icons.comment_bank_outlined,
                                  value: statusOptions
                                          .contains(statusController.text)
                                      ? statusController.text
                                      : null,
                                  items: statusOptions,
                                  onChanged: isAdmin
                                      ? (String? newValue) {
                                          setState(() {
                                            selectedStatus = newValue;
                                            statusController.text =
                                                newValue ?? '';
                                          });
                                        }
                                      : null,
                                  isAdmin: isAdmin,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Statusu seçin';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: DropdownWithIcon(
                                  labelText: 'Texniki qrup',
                                  icon: Icons.engineering_outlined,
                                  value: technicalGroupOptions
                                          .contains(groupController.text)
                                      ? groupController.text
                                      : null,
                                  items: technicalGroupOptions,
                                  onChanged: isAdmin
                                      ? (String? newValue) {
                                          setState(() {
                                            selectedTechnicalGroup = newValue;
                                            groupController.text =
                                                newValue ?? '';
                                          });
                                        }
                                      : null,
                                  isAdmin: isAdmin,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Texniki qrup seçin';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        MultiSelectWithIcon(
                          labelText: 'Servis',
                          icon: Icons.miscellaneous_services_outlined,
                          isAdmin: isAdmin,
                          emptyText: 'Servis növü seçin zəhmət olmasa',
                          options: services,
                          items: selectedServices,
                          onChanged: (List<String> value) {
                            setState(() {
                              selectedServices = value;
                            });
                          },
                        ),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                              child: const CardWithTitleAndIcon(
                                title: 'Problem anketi',
                                icon: Icons.add,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  TextEditingController _getControllerForTitle(String title) {
    switch (title) {
      case 'Ad və soyad:':
        return fullNameController;
      case 'Qeydiyyat nömrəsi':
        return registrationNumberController;
      case 'Əlaqə nömrəsi':
        return contactNumberController;
      case 'Adres':
        return locationController;
      case 'Tarix':
        return dateController;
      case 'Status':
        return statusController;
      case 'Texniki qrup':
        return groupController;
      case 'Qeyd':
        return noteController;

      default:
        return TextEditingController();
    }
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
