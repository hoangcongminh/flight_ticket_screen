import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:ticket/theme.dart';
import 'package:ticket/utils/datetime_extension.dart';

import '../bloc/date_bloc.dart';

class CalenderView extends StatefulWidget {
  final DateTime selectedDate;
  final bool isSelectReturnTicket;
  const CalenderView({
    super.key,
    required this.isSelectReturnTicket,
    required this.selectedDate,
  });

  @override
  State<CalenderView> createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  late DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chọn ngày',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<DateBloc, DateState>(
                builder: (context, state) {
                  if (state.status == DateStatus.success) {
                    return PagedVerticalCalendar(
                      invisibleMonthsThreshold: 2,
                      initialDate: DateTime.now(),
                      addAutomaticKeepAlives: true,
                      onMonthLoaded: (year, month) {
                        context.read<DateBloc>().add(const FetchDateEvent(30));
                      },
                      startWeekWithSunday: true,
                      onDayPressed: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      monthBuilder: (context, month, year) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'Thang $month, $year',
                                style: boldText,
                              ),
                            ],
                          ),
                        );
                      },
                      dayBuilder: (context, date) {
                        final isToday = date.isSameDate(now);
                        final isSelected = date.isSameDate(selectedDate);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  border: isToday && !isSelected
                                      ? Border.all(color: Colors.grey)
                                      : null,
                                  color: isSelected ? Colors.blue : null,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : date.isAfter(now) || isToday
                                              ? Colors.black
                                              : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (state.date!
                                .where((element) =>
                                    element.departDate!.isSameDate(date))
                                .isNotEmpty)
                              Text(
                                NumberFormat.currency(
                                        locale: "vi_VN", symbol: "₫")
                                    .format(
                                  state.date!
                                      .where((element) =>
                                          element.departDate!.isSameDate(date))
                                      .first
                                      .totalPrice,
                                ),
                                style: const TextStyle(fontSize: 10),
                              ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<DateBloc>().add(widget.isSelectReturnTicket
                      ? SelectedReturnDate(selectedReturnDate: selectedDate)
                      : SelectDepartDateEvent(
                          selectedDepartDate: selectedDate));
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: const Text('Lưu'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
