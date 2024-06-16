import 'package:digi_task/core/constants/path/icon_path.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/core/utility/extension/icon_path_ext.dart';
import 'package:digi_task/features/tasks/presentation/notifier/task_notifier.dart';
import 'package:digi_task/features/tasks/presentation/notifier/task_state.dart';
import 'package:digi_task/shared/widgets/user_task_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../presentation/components/custom_progress_indicator.dart';
import '../../../../presentation/components/service_type.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> with TickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  int selecteIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: TabBar(
            onTap: (value) {
              if (value == 1) {
                context.read<TaskNotifier>().fetchTasks(queryType: "problem");
              } else {
                context.read<TaskNotifier>().fetchTasks(queryType: "connection");
              }
            },
            labelColor: context.colors.primaryColor50,
            labelStyle: context.typography.subtitle2Medium,
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: context.colors.neutralColor80,
            indicatorColor: context.colors.primaryColor50,
            tabs: const [
              Tab(
                text: "Qoşulmalar",
              ),
              Tab(
                text: "Problemlər",
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              final texts = ['Hamisi', 'Gözləmədə olan', 'Qəbul edilən', 'Keçmiş'];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: RawChip(
                    onPressed: () {
                      setState(() {
                        selecteIndex = index;
                      });
                      if (tabController.index == 0) {
                        switch (index) {
                          case 0:
                            context.read<TaskNotifier>().fetchTasks(queryType: "connection");
                            break;
                          case 1:
                            context.read<TaskNotifier>().fetchTasks(queryStatus: "waiting", queryType: "connection");
                            break;
                          case 2:
                            context.read<TaskNotifier>().fetchTasks(queryStatus: "inprogress", queryType: "connection");
                            break;
                          case 3:
                            context.read<TaskNotifier>().fetchTasks(queryStatus: "completed", queryType: "connection");
                            break;
                        }
                      }
                      if (tabController.index == 1) {
                        switch (index) {
                        case 0:
                            context.read<TaskNotifier>().fetchTasks(queryType: "problem");
                          break;
                        case 1:
                            context.read<TaskNotifier>().fetchTasks(queryStatus: "waiting", queryType: "problem");
                          break;
                        case 2:
                            context.read<TaskNotifier>().fetchTasks(queryStatus: "inprogress", queryType: "problem");
                          break;
                        case 3:
                            context.read<TaskNotifier>().fetchTasks(queryStatus: "completed", queryType: "problem");
                          break;
                      }
                      }
                     
                    },
                    showCheckmark: false,
                    label: Text(texts[index]),
                    labelStyle: context.typography.overlineSemiBold
                        .copyWith(color: selecteIndex == index ? Colors.white : context.colors.primaryColor50),
                    labelPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    backgroundColor: Colors.white,
                    selectedColor: context.colors.primaryColor50,
                    selected: selecteIndex == index,
                    shape: const StadiumBorder(side: BorderSide(color: Colors.transparent))),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Consumer<TaskNotifier>(
          builder: (context, notifier, child) {
            if (notifier.state is TaskProgress) {
              return const Center(
                child: CustomProgressIndicator(),
              );
            } else if (notifier.state is TaskSuccess) {
              final taskNotifier = notifier.state as TaskSuccess;
              return Expanded(
                child: ListView.builder(
                  itemCount: taskNotifier.tasks?.length,
                  itemBuilder: (context, index) {
                    print(taskNotifier.tasks?.length);
                    final nowDateTime = DateTime.now();
                    final dateTime = DateTime.parse(taskNotifier.tasks?[index].date ?? '');
                    String formattedDate = DateFormat('MMM d').format(dateTime);
                    String nowFormattedDate = DateFormat('MMM d').format(nowDateTime);
                    return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
                        child: UserTaskCard(
                          iconRow: Row(
                            children: [
                              if (taskNotifier.tasks?[index].isInternet == true) ...[
                                ServiceType(
                                  image: IconPath.internet.toPathSvg,
                                  title: "Internet",
                                ),
                              ],
                              if (taskNotifier.tasks?[index].isTv == true) ...[
                                ServiceType(
                                  image: IconPath.tv.toPathSvg,
                                  title: "Tv",
                                ),
                              ],
                              if (taskNotifier.tasks?[index].isVoice == true) ...[
                                ServiceType(
                                  image: IconPath.voice.toPathSvg,
                                  title: "Voice",
                                ),
                              ],
                            ],
                          ),
                          name: taskNotifier.tasks?[index].firstName ?? 'Not found user',
                          time: formattedDate == nowFormattedDate
                              ? 'Bu gün, ${taskNotifier.tasks?[index].time}'
                              : '$formattedDate, ${taskNotifier.tasks?[index].time}',
                          location: taskNotifier.tasks?[index].location ?? '',
                          number: taskNotifier.tasks?[index].contactNumber ?? '',
                          status: taskNotifier.tasks?[index].status ?? '',
                          notifier: notifier,
                          group: (taskNotifier.tasks?[index].group?.isNotEmpty ?? false)
                              ? '${taskNotifier.tasks?[index].group?.first.group}'
                              : "Empty group",
                        ));
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
