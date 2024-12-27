import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String title, value;

  const ReusableRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    var themeText = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: themeText.bodySmall,
          ),
          Text(
            value,
            style: themeText.bodySmall,
          ),
        ],
      ),
    );
  }
}