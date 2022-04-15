import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

class MonthBar extends StatelessWidget {
  final String date;

  const MonthBar({
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.accentBlue02.withOpacity(0.8),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Text(
        'January 2022',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).backgroundColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
