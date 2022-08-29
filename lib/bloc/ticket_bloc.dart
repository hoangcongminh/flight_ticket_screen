import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket/model/ticket.dart';

import '../model/date.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<TicketEvent>((event, emit) {});
    on<FetchTicketEvent>(_fetchTickets);
    on<SelectDateEvent>(_selectDate);
    on<SelectTicketEvent>(_selectTicket);
  }

  FutureOr<void> _fetchTickets(
      FetchTicketEvent event, Emitter<TicketState> emit) async {
    emit(TicketLoading());
    var jsonTicket =
        await rootBundle.loadString('assets/data/ticket_route_chip.json');
    var jsonDate = await rootBundle.loadString('assets/data/date.json');

    emit(TicketLoaded(
      selectedDate: 0,
      date: Date.fromJson(jsonDecode(jsonDate)),
      tickets: Ticket.fromJson(jsonDecode(jsonTicket))
          .data!
          .where((element) => element.dn404 == 0)
          .toList(),
      returnTickets: Ticket.fromJson(jsonDecode(jsonTicket))
          .data!
          .where((element) => element.dn404 == 1)
          .toList(),
    ));
  }

  FutureOr<void> _selectDate(SelectDateEvent event, Emitter<TicketState> emit) {
    if (state is TicketLoaded) {
      final state = this.state as TicketLoaded;

      emit(state.copyWith(selectedDate: event.selectedDate));
    }
  }

  Future<void> _selectTicket(
      SelectTicketEvent event, Emitter<TicketState> emit) async {
    if (state is TicketLoaded) {
      final state = this.state as TicketLoaded;
      if (event.isReturnTicket) {
        emit(state.copyWith(
          selectedReturnTicket: event.selectedTicket,
        ));
      } else {
        emit(state.copyWith(
          selectedTicket: event.selectedTicket,
        ));
      }
    }
  }
}
