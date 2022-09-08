import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket/widget/ticket_price_info.dart';

import '../model/ticket.dart';
import '../theme.dart';

class TicketInfo extends StatelessWidget {
  final TicketItem? selectedTicket;
  const TicketInfo({
    Key? key,
    this.selectedTicket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedTicket != null) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.grey.shade300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Chặng bay', style: boldText),
                Row(
                  children: [
                    Text(
                        '${selectedTicket!.fd100!.first.fd300!.first.dv326} (${selectedTicket!.fd100!.first.dv104})',
                        style: greyText),
                    const Icon(Icons.arrow_forward, color: Colors.grey),
                    Text(
                        '${selectedTicket!.fd100!.first.fd300!.first.dv328} (${selectedTicket!.fd100!.first.dv105})',
                        style: greyText),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      '${selectedTicket!.fd100!.first.fd300!.first.d800!.dv810}/${selectedTicket!.fd100!.first.fd300!.first.d800!.dv803}',
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(selectedTicket!
                            .fd100!.first.d800!.fd801!.first.dv806!),
                        Text(selectedTicket!.fd100!.first.dv108!,
                            style: boldText),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${selectedTicket!.fd100!.first.dv120 ?? ''} (${selectedTicket!.fd100!.first.dv114})',
                  style: boldText,
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_outline),
                        Text('Nguoi lon (x${selectedTicket!.dn422})',
                            style: boldText),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TicketPriceInfo(
                        text: 'Giá vé cơ bản (x${selectedTicket!.dn422})'),
                    const SizedBox(height: 16),
                    TicketPriceInfo(
                        text: 'Thuế và phí (x${selectedTicket!.dn422})'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      NumberFormat.currency(locale: "vi_VN", symbol: "₫")
                          .format(selectedTicket!.dn425),
                      style: boldText,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      NumberFormat.currency(locale: "vi_VN", symbol: "₫")
                          .format(selectedTicket!.dn407),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      NumberFormat.currency(locale: "vi_VN", symbol: "₫")
                          .format(
                              selectedTicket!.dn413! + selectedTicket!.dn410!),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
