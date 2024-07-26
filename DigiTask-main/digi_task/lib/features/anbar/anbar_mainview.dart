import 'package:digi_task/features/anbar/data/repository/anbar_item_repository_impl.dart';
import 'package:digi_task/features/anbar/data/service/anbar_network_service.dart';
import 'package:digi_task/features/anbar/presentation/notifier/anbar_notifier.dart';
import 'package:digi_task/features/anbar/presentation/view/anbar_history.dart';
import 'package:digi_task/features/anbar/presentation/view/anbar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AnbarMainView extends StatelessWidget {
  const AnbarMainView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final anbarNetworkService = AnbarNetworkServiceImpl();
    
    final anbarRepository = AnbarItemRepositoryImpl(anbarNetworkService: anbarNetworkService);

    return ChangeNotifierProvider(
      create: (context) => AnbarNotifier(anbarRepository),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Anbar Main View'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Anbar'),
                Tab(text: 'Anbar Tarixcesi'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AnbarView(),
              AnbarHistoryView(),
            ],
          ),
        ),
      ),
    );
  }
}
