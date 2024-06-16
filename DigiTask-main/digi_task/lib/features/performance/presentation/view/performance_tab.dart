import 'package:digi_task/features/performance/presentation/notifier/performance_notifier.dart';
import 'package:digi_task/presentation/components/custom_progress_indicator.dart';
import 'package:digi_task/presentation/pages/home/widgets/select_time_card.dart';
import 'package:digi_task/shared/widgets/performance_table.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../notifier/performance_state.dart';

class PerformanceTab extends StatefulWidget {
  const PerformanceTab({super.key});

  @override
  State<PerformanceTab> createState() => _PerformanceTabState();
}

class _PerformanceTabState extends State<PerformanceTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          const Row(
            children: [
              SelectTimeCard(),
              SizedBox(
                width: 16,
              ),
              SelectTimeCard(),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Consumer<PerformanceNotifier>(
            builder: (context, notifier, child) {
              if (notifier.state is PerformanceLoading) {
                return const Center(child: CustomProgressIndicator());
              } else if (notifier.state is PerformanceSuccess) {
                final performance = (notifier.state as PerformanceSuccess).performanceList;
                return PerformanceTable(performance: performance);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
