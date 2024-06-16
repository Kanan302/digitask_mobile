import 'package:digi_task/core/constants/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class SelectDropdownField extends StatelessWidget {
  const SelectDropdownField({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.typography.body2Regular,
          ),
          const SizedBox(
            height: 4,
          ),
          DropdownButtonFormField(
            autofocus: false,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 26,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 11),
              fillColor: context.colors.neutralColor100,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: context.colors.neutralColor70,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: context.colors.neutralColor70,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: context.colors.neutralColor40,
                ),
              ),
            ),
            items: [
              DropdownMenuItem(
                child: Text(
                  'Anbar 1',
                  style: context.typography.body2SemiBold,
                ),
              )
            ],
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
