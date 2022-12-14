import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticket/theme.dart';

class DateWidget extends StatelessWidget {
  final bool clickable;
  final bool isSelected;
  final DateTime departDate;
  final int totalPrice;
  const DateWidget({
    Key? key,
    required this.clickable,
    required this.isSelected,
    required this.departDate,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: clickable
          ? Colors.grey
          : isSelected
              ? Colors.blue
              : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('EEEE, dd/MM/yy').format(departDate).toString(),
            style: isSelected ? selectedText : null,
          ),
          const SizedBox(height: 8),
          totalPrice == 0
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade400,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                      width: 50,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30))),
                )
              : Text(
                  NumberFormat.currency(locale: "vi_VN", symbol: "₫")
                      .format(totalPrice),
                  style: isSelected ? selectedTextBold : boldText,
                ),
        ],
      ),
    );
  }
}
