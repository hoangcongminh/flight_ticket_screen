import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:ticket/utils/datetime_extension.dart';

import '../bloc/date_bloc.dart';
import '../widget/date_widget.dart';
import 'calender_screen.dart';

class ListDateWidget extends StatefulWidget {
  final bool isSelectReturnTicket;
  const ListDateWidget({super.key, required this.isSelectReturnTicket});

  @override
  State<ListDateWidget> createState() => _ListDateWidgetState();
}

class _ListDateWidgetState extends State<ListDateWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  void setupScrollController(context) {
    itemPositionsListener.itemPositions.addListener(() {
      if (itemPositionsListener.itemPositions.value.last.index ==
          BlocProvider.of<DateBloc>(context).state.date!.length - 1) {
        BlocProvider.of<DateBloc>(context).add(const FetchDateEvent());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<DateBloc, DateState>(
      builder: (context, state) {
        if (state.status == DateStatus.success) {
          if (state.isScroll!) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              itemScrollController.jumpTo(
                  index: state.date!.map((e) => e.departDate).toList().indexOf(
                        widget.isSelectReturnTicket
                            ? context.read<DateBloc>().state.selectedReturnDate
                            : context.read<DateBloc>().state.selectedDepartDate,
                      ),
                  alignment: 0.3);
            });
          }
          return Row(
            children: [
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: state.date!.length,
                  scrollDirection: Axis.horizontal,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: state.date![index].departDate!
                              .isBefore(state.currentDate!)
                          ? null
                          : () => context.read<DateBloc>().add(
                                widget.isSelectReturnTicket
                                    ? SelectedReturnDate(
                                        selectedReturnDate:
                                            state.date![index].departDate!)
                                    : SelectDepartDateEvent(
                                        selectedDepartDate:
                                            state.date![index].departDate!,
                                      ),
                              ),
                      child: DateWidget(
                        clickable: state.date![index].departDate!
                            .isBefore(state.currentDate!),
                        isSelected: widget.isSelectReturnTicket
                            ? state.selectedReturnDate!
                                .isSameDate(state.date![index].departDate!)
                            : state.selectedDepartDate!
                                .isSameDate(state.date![index].departDate!),
                        departDate: state.date![index].departDate!,
                        totalPrice: state.date![index].totalPrice!,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CalenderView(
                          isSelectReturnTicket: widget.isSelectReturnTicket,
                          selectedDate: widget.isSelectReturnTicket
                              ? state.selectedReturnDate!
                              : state.selectedDepartDate!),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.calendar_month,
                ),
              )
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
