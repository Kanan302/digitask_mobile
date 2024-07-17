import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/features/tasks/presentation/view/problem/detail_problem.dart';
import 'package:flutter/material.dart';

class ServiceDialog extends StatelessWidget {
  final String serviceType;
  final int taskId;

  const ServiceDialog({
    super.key,
    required this.serviceType,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "Servis növü",
                    style: context.typography.subtitle1Medium,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hansı anketi doldurursunuz?',
                  style: context.typography.body2Regular.copyWith(
                    color: context.colors.neutralColor50,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (serviceType.contains('Internet'))
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              width: 4,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateProblem(
                                serviceType: 'Internet',
                                taskId: taskId,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Internet',
                          style: context.typography.body2SemiBold.copyWith(
                            color: context.colors.primaryColor50,
                          ),
                        ),
                      ),
                    if (serviceType.contains('Tv'))
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              width: 4,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateProblem(
                                serviceType: 'Tv',
                                taskId: taskId,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Tv',
                          style: context.typography.body2SemiBold.copyWith(
                            color: context.colors.primaryColor50,
                          ),
                        ),
                      ),
                    if (serviceType.contains('Voice'))
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              width: 4,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateProblem(
                                serviceType: 'Voice',
                                taskId: taskId,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Voice',
                          style: context.typography.body2SemiBold.copyWith(
                            color: context.colors.primaryColor50,
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
  }
}
