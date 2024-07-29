import 'package:flutter/material.dart';
import 'package:digi_task/core/constants/theme/theme_ext.dart';

class AnbarHistoryView extends StatelessWidget {
  const AnbarHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text("Anbar Tarixçəsi", style: context.typography.subtitle2Medium),
      ),
    );
  }
}
