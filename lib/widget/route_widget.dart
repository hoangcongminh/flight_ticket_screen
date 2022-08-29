import 'package:flutter/material.dart';
import 'package:ticket/theme.dart';

import '../model/ticket.dart';

class RouteWidget extends StatelessWidget {
  final bool isSelected;
  final String routeTitle;
  final TicketItem? ticket;
  const RouteWidget({
    Key? key,
    required this.isSelected,
    required this.routeTitle,
    this.ticket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String info = ticket != null
        ? '${ticket!.fd100!.first.dv104} - ${ticket!.fd100!.first.dv105!} (${ticket!.fd100!.first.dd106![1].split(":").first}:${ticket!.fd100!.first.dd106![1].split(":")[1]} - ${ticket!.fd100!.first.dd107![1].split(":").first}:${ticket!.fd100!.first.dd107![1].split(":")[1]})'
        : '__-__';

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: isSelected ? Colors.blue : Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(routeTitle, style: isSelected ? selectedTextBold : boldText),
          const SizedBox(height: 8),
          Text(
            info,
            style: isSelected
                ? selectedText.copyWith(fontSize: 12)
                : greyText.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
