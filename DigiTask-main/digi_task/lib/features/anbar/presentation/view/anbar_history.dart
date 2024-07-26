import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class AnbarHistoryView extends StatelessWidget {
  const AnbarHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Anbar Tarixçəsi', style: context.typography.subtitle2Medium),
      ),
      body: const Center(
        child: Text('Anbar Tarixçəsi'),
      ),
    );
  }
}
