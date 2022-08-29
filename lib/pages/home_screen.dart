import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:ticket/pages/ticket_screen.dart';
import 'package:ticket/widget/ticket_info.dart';

import '../bloc/ticket_bloc.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  late PanelController panelController;
  bool isOpened = false;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TicketScreen(
                      isSelectReturnTicket: false,
                      onSelectTicket: () =>
                          tabController.animateTo(tabController.index + 1),
                    ),
                    TicketScreen(
                      isSelectReturnTicket: true,
                      onSelectTicket: () =>
                          tabController.animateTo(tabController.index - 1),
                    ),
                  ],
                ),
              ),
              BlocBuilder<TicketBloc, TicketState>(
                builder: (context, state) {
                  if (state is TicketLoaded && state.selectedTicket != null) {
                    return const SizedBox(height: 100);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
          BlocBuilder<TicketBloc, TicketState>(
            builder: (context, state) {
              if (state is TicketLoaded && state.selectedTicket != null) {
                return SlidingUpPanel(
                  controller: panelController,
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  minHeight: 100,
                  backdropEnabled: true,
                  panelBuilder: (scrollController) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            panelController.open();
                          },
                          child: SizedBox(
                            height: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Tổng giá', style: greyText),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Text(
                                            NumberFormat.currency(
                                                    locale: "vi_VN",
                                                    symbol: "₫")
                                                .format(state.selectedTicket !=
                                                        null
                                                    ? state.selectedReturnTicket !=
                                                            null
                                                        ? state.selectedTicket!
                                                                .dn425! +
                                                            state
                                                                .selectedReturnTicket!
                                                                .dn425!
                                                        : state.selectedTicket!
                                                            .dn425
                                                    : 0),
                                            style: ticketPriceStyle),
                                      ),
                                      Text('(Đã bao gồm thuế và phí)',
                                          style: greyText),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          state.selectedReturnTicket == null
                                              ? '1/2'
                                              : '2/2',
                                          style: greyText,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: state.selectedTicket !=
                                                    null &&
                                                state.selectedReturnTicket !=
                                                    null
                                            ? () {}
                                            : null,
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text('Dat ve'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TicketInfo(selectedTicket: state.selectedTicket),
                        TicketInfo(selectedTicket: state.selectedReturnTicket),
                        const Divider(thickness: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tổng giá'),
                              Text(
                                NumberFormat.currency(
                                        locale: "vi_VN", symbol: "₫")
                                    .format(state.selectedTicket != null
                                        ? state.selectedReturnTicket != null
                                            ? state.selectedTicket!.dn425! +
                                                state.selectedReturnTicket!
                                                    .dn425!
                                            : state.selectedTicket!.dn425
                                        : 0),
                                style: ticketPriceStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
