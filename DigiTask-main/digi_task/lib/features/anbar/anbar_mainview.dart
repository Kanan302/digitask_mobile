import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:digi_task/features/anbar/presentation/view/anbar_view.dart';
import 'package:flutter/material.dart';

class AnbarMainView extends StatefulWidget {
  const AnbarMainView({super.key});

  @override
  State<AnbarMainView> createState() => _AnbarMainViewState();
}

class _AnbarMainViewState extends State<AnbarMainView>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: tabController,
              labelColor: context.colors.primaryColor50,
              labelStyle: context.typography.subtitle2Medium,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: context.colors.neutralColor80,
              indicatorColor: context.colors.primaryColor50,
              tabs: const [
                Tab(text: "Anbar"),
                Tab(text: "Anbar Tarixçəsi"),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: const [
              AnbarView(),
              Center(child: Text('Anbar Tarixçəsi')),
            ],
          ))
        ],
      ),
    );
  }
}
