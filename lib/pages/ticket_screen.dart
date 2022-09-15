import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ticket/bloc/ticket_bloc.dart';
import 'package:ticket/theme.dart';
import 'package:ticket/widget/ticket_widget.dart';

import '../widget/route_widget.dart';
import 'list_date_widget.dart';

class TicketScreen extends StatefulWidget {
  final bool isSelectReturnTicket;
  final VoidCallback onSelectTicket;
  const TicketScreen({
    super.key,
    required this.onSelectTicket,
    required this.isSelectReturnTicket,
  });

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TicketBloc, TicketState>(
      builder: (context, state) {
        if (state is TicketLoaded) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ha Noi (HAN)', style: appbarTop),
                        const Icon(Icons.arrow_forward),
                        Text('Ho Chi Minh (SGN)', style: appbarTop),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('1 nguoi lon', style: appbarBottom),
                    const SizedBox(height: 8),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showSortWidget(context);
                    },
                    icon: const Icon(Icons.sort),
                  ),
                  IconButton(
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => FilterBottmSheet(
                          isReturnTicket: widget.isSelectReturnTicket,
                          isVNA: widget.isSelectReturnTicket
                              ? state.isVNAReturn ?? false
                              : state.isVNA ?? false,
                          isDepartBefore12: widget.isSelectReturnTicket
                              ? state.isDepartBefore12Return ?? false
                              : state.isDepartBefore12 ?? false,
                          isPriceLessThan5Mil: widget.isSelectReturnTicket
                              ? state.isPriceLessThan5MilReturn ?? false
                              : state.isPriceLessThan5Mil ?? false,
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListDateWidget(
                        isSelectReturnTicket: widget.isSelectReturnTicket),
                  ),
                ),
              ),
              if (state.selectedTicket != null)
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: Delegate(
                    child: Container(
                      color: Colors.grey.shade300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (widget.isSelectReturnTicket) {
                                  widget.onSelectTicket();
                                }
                              },
                              child: RouteWidget(
                                routeTitle: 'Chuyến đi',
                                isSelected: !widget.isSelectReturnTicket,
                                ticket: state.selectedTicket,
                              ),
                            ),
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              if (!widget.isSelectReturnTicket) {
                                widget.onSelectTicket();
                              }
                            },
                            child: RouteWidget(
                              routeTitle: state.selectedReturnTicket != null
                                  ? "Chuyến về"
                                  : "Chọn vé chuyến về",
                              isSelected: widget.isSelectReturnTicket,
                              ticket: state.selectedReturnTicket,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final ticket = !widget.isSelectReturnTicket
                        ? state.tickets[index]
                        : state.returnTickets[index];
                    return GestureDetector(
                      onTap: () async {
                        context.read<TicketBloc>().add(
                              SelectTicketEvent(
                                selectedTicket: widget.isSelectReturnTicket
                                    ? state.returnTickets[index]
                                    : state.tickets[index],
                                isReturnTicket: widget.isSelectReturnTicket,
                              ),
                            );
                        if (!widget.isSelectReturnTicket) {
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          widget.onSelectTicket();
                        }
                      },
                      child: TicketWidget(
                        isSelected: widget.isSelectReturnTicket
                            ? ticket == state.selectedReturnTicket
                            : ticket == state.selectedTicket,
                        flightBrandLogoUrl:
                            '${ticket.fd100!.first.d800!.dv810}/${ticket.fd100!.first.d800!.dv803}',
                        flightNumber: ticket.fd100!.first.dv108!,
                        departureTime: ticket.fd100!.first.dd106![1],
                        departureCode: ticket.fd100!.first.dv104!,
                        destinationTime: ticket.fd100!.first.dd107![1],
                        destinationCode: ticket.fd100!.first.dv105!,
                        flightDuration: ticket.fd100!.first.dn111!,
                        price: ticket.dn425!,
                        currency: ticket.currency!,
                        ticketClassName: ticket.fd100!.first.dv120 ?? '',
                        ticketClassCode: ticket.fd100!.first.dv114!,
                      ),
                    );
                  },
                  childCount: !widget.isSelectReturnTicket
                      ? state.tickets.length
                      : state.returnTickets.length, // 1000 list items
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<void> showSortWidget(BuildContext context) {
    return showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Material(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Gia giam'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<TicketBloc>().add(
                        SortTicket(
                          isReturnTickets: widget.isSelectReturnTicket,
                          priceValue: 1,
                        ),
                      );
                },
              ),
              ListTile(
                title: const Text('Gia tang'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<TicketBloc>().add(
                        SortTicket(
                          isReturnTickets: widget.isSelectReturnTicket,
                          priceValue: 2,
                        ),
                      );
                },
              ),
              ListTile(
                title: const Text('Gio bay giam'),
                onTap: () {
                  Navigator.of(context).pop();

                  context.read<TicketBloc>().add(
                        SortTicket(
                          isReturnTickets: widget.isSelectReturnTicket,
                          flightValue: 1,
                        ),
                      );
                },
              ),
              ListTile(
                title: const Text('Gio bay tang'),
                onTap: () {
                  Navigator.of(context).pop();

                  context.read<TicketBloc>().add(
                        SortTicket(
                          isReturnTickets: widget.isSelectReturnTicket,
                          flightValue: 2,
                        ),
                      );
                },
              ),
              ListTile(
                title: const Text('Gio ha canh giam'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<TicketBloc>().add(
                        SortTicket(
                          isReturnTickets: widget.isSelectReturnTicket,
                          landingValue: 1,
                        ),
                      );
                },
              ),
              ListTile(
                title: const Text('Gio ha canh tang'),
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<TicketBloc>().add(
                        SortTicket(
                          isReturnTickets: widget.isSelectReturnTicket,
                          landingValue: 2,
                        ),
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilterBottmSheet extends StatefulWidget {
  final bool isReturnTicket;
  final bool isVNA;
  final bool isDepartBefore12;
  final bool isPriceLessThan5Mil;
  const FilterBottmSheet({
    super.key,
    required this.isReturnTicket,
    required this.isVNA,
    required this.isDepartBefore12,
    required this.isPriceLessThan5Mil,
  });

  @override
  State<FilterBottmSheet> createState() => _FilterBottmSheetState();
}

class _FilterBottmSheetState extends State<FilterBottmSheet> {
  late bool isVNA;
  late bool isDepartBefore12;
  late bool isPriceLessThan5Mil;
  @override
  void initState() {
    isVNA = widget.isVNA;
    isDepartBefore12 = widget.isDepartBefore12;
    isPriceLessThan5Mil = widget.isPriceLessThan5Mil;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('VNA'),
              value: isVNA,
              onChanged: (newValue) {
                setState(() {
                  isVNA = newValue!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Giờ khởi hành < 12h'),
              value: isDepartBefore12,
              onChanged: (newValue) {
                setState(() {
                  isDepartBefore12 = newValue!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Giá < 5tr'),
              value: isPriceLessThan5Mil,
              onChanged: (newValue) {
                setState(() {
                  isPriceLessThan5Mil = newValue!;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Thoát'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.read<TicketBloc>().add(FilterTicket(
                          isReturnTickets: widget.isReturnTicket,
                          isVNA: isVNA,
                          isDepartBefore12: isDepartBefore12,
                          isPriceLessThan5Mil: isPriceLessThan5Mil,
                        ));
                  },
                  child: const Text('Lọc'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  Delegate({
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
