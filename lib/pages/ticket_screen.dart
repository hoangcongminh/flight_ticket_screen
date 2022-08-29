import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/bloc/ticket_bloc.dart';
import 'package:ticket/theme.dart';
import 'package:ticket/widget/ticket_widget.dart';

import '../widget/date_widget.dart';
import '../widget/route_widget.dart';

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
                    onPressed: () {},
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.date.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () =>
                                context.read<TicketBloc>().add(SelectDateEvent(
                                      selectedDate: index,
                                    )),
                            child: DateWidget(
                              isSelected: index == state.selectedDate,
                              departDate: DateTime.parse(
                                  state.date.data![index].departDate!),
                              totalPrice: state.date.data![index].totalPrice!,
                            ));
                      },
                    ),
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
                  childCount: state.tickets.length, // 1000 list items
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
