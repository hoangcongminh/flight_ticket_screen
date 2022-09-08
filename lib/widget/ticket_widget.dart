import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class TicketWidget extends StatelessWidget {
  final bool isSelected;
  final String flightBrandLogoUrl;
  final String flightNumber;
  final String departureTime;
  final String departureCode;
  final String destinationTime;
  final String destinationCode;
  final int flightDuration;
  final int price;
  final String currency;
  final String ticketClassName;
  final String ticketClassCode;

  const TicketWidget({
    super.key,
    required this.isSelected,
    required this.flightBrandLogoUrl,
    required this.flightNumber,
    required this.departureTime,
    required this.departureCode,
    required this.destinationTime,
    required this.destinationCode,
    required this.flightDuration,
    required this.price,
    required this.currency,
    required this.ticketClassName,
    required this.ticketClassCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: isSelected
                    ? Colors.blue.shade200.withOpacity(0.5)
                    : Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(flightBrandLogoUrl),
                  const SizedBox(height: 8),
                  Text(flightNumber, style: boldText),
                ],
              ),
            ),
          ),
          Container(
            color: isSelected
                ? Colors.blue.shade200.withOpacity(0.5)
                : Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 10,
                  width: 25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    size: const Size(1, 150),
                    painter: DashedLineVerticalPainter(),
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: isSelected
                    ? Colors.blue.shade200.withOpacity(0.5)
                    : Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LocationInfo(
                            locationTime: departureTime,
                            locationCode: departureCode,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${flightDuration ~/ 60}h ${flightDuration % 60}m',
                                style: greyText,
                              ),
                              Image.asset('assets/images/flight.png'),
                              Text(
                                'Bay thẳng',
                                style: greyText,
                              ),
                            ],
                          ),
                          LocationInfo(
                            locationTime: departureTime,
                            locationCode: destinationCode,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    NumberFormat.currency(
                                            locale: "vi_VN", symbol: "₫")
                                        .format(price),
                                    style: ticketPriceStyle),
                                Text(
                                  '$ticketClassName ($ticketClassCode)',
                                  overflow: TextOverflow.fade,
                                  style: greyText,
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text('Chi tiết', style: blueText),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 16, color: Colors.blue),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    Key? key,
    required this.locationTime,
    required this.locationCode,
  }) : super(key: key);
  final String locationTime;
  final String locationCode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${locationTime.split(":").first}:${locationTime.split(":")[1]}',
          style: boldText,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: locationCodeStyle,
          child: Text(
            locationCode,
            style: locationCodeTextStyle,
          ),
        ),
      ],
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 8, dashSpace = 5, startY = 0;
    final paint = Paint()
      ..color = Colors.grey.shade500
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
