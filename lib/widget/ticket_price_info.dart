import 'package:flutter/material.dart';

class TicketPriceInfo extends StatelessWidget {
  final String text;
  const TicketPriceInfo({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 5,
          width: 5,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}
