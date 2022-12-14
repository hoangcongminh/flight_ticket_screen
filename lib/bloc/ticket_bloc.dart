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
    on<SelectTicketEvent>(_selectTicket);
    on<SortTicket>(_sortTicket);
    on<FilterTicket>(_filterTicket);
  }

  FutureOr<void> _fetchTickets(
      FetchTicketEvent event, Emitter<TicketState> emit) async {
    emit(TicketLoading());
    var jsonTicket = await rootBundle.loadString('assets/data/json_2.json');
    var jsonDate = await rootBundle.loadString('assets/data/date.json');

    tickets.addAll(Ticket.fromJson(jsonDecode(jsonTicket))
        .data!
        .where((element) => element.dn404 == 0)
        .toList());
    returnTickets.addAll(Ticket.fromJson(jsonDecode(jsonTicket))
        .data!
        .where((element) => element.dn404 == 1)
        .toList());

    emit(TicketLoaded(
      selectedDate: 0,
      date: Date.fromJson(jsonDecode(jsonDate)),
      tickets: tickets,
      returnTickets: returnTickets,
    ));
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

  Future<void> _sortTicket(SortTicket event, Emitter<TicketState> emit) async {
    if (state is TicketLoaded) {
      final state = this.state as TicketLoaded;
      emit(TicketLoading());

      await Future.delayed(const Duration(seconds: 1));
      final tickets =
          event.isReturnTickets ? state.returnTickets : state.tickets;
      if (event.priceValue == 1) {
        tickets.sort((b, a) => a.dn425!.compareTo(b.dn425!));
      } else if (event.priceValue == 2) {
        tickets.sort((a, b) => a.dn425!.compareTo(b.dn425!));
      }
      if (event.flightValue == 1) {
        tickets.sort((b, a) =>
            a.fd100!.first.dd106![1].compareTo(b.fd100!.first.dd106![1]));
      } else if (event.flightValue == 2) {
        tickets.sort((a, b) =>
            a.fd100!.first.dd106![1].compareTo(b.fd100!.first.dd106![1]));
      }
      if (event.landingValue == 1) {
        tickets.sort((b, a) =>
            a.fd100!.first.dd106![1].compareTo(b.fd100!.first.dd107![1]));
      } else if (event.landingValue == 2) {
        tickets.sort((a, b) =>
            a.fd100!.first.dd106![1].compareTo(b.fd100!.first.dd107![1]));
      }
      event.isReturnTickets
          ? emit(
              state.copyWith(
                returnTickets: List.of(tickets),
              ),
            )
          : emit(
              state.copyWith(
                tickets: List.of(tickets),
              ),
            );
    }
  }

  Future<void> _filterTicket(
      FilterTicket event, Emitter<TicketState> emit) async {
    if (state is TicketLoaded) {
      final state = this.state as TicketLoaded;
      emit(TicketLoading());
      await Future.delayed(const Duration(seconds: 1));

      List<TicketItem> filteredTickets =
          event.isReturnTickets ? returnTickets : tickets;

      if (event.isVNA ?? false) {
        filteredTickets =
            filteredTickets.where((element) => element.dv402 == "VN").toList();
      }
      if (event.isDepartBefore12 ?? false) {
        filteredTickets = filteredTickets
            .where((element) =>
                int.parse(element.fd100!.first.dd106![1].split(":")[0]) < 12)
            .toList();
      }
      if (event.isPriceLessThan5Mil ?? false) {
        filteredTickets = filteredTickets
            .where((element) => element.dn425! < 5000000)
            .toList();
      }

      event.isReturnTickets
          ? emit(state.copyWith(
              returnTickets: List.of(filteredTickets),
              isVNAReturn: event.isVNA,
              isDepartBefore12Return: event.isDepartBefore12,
              isPriceLessThan5MilReturn: event.isPriceLessThan5Mil,
            ))
          : emit(state.copyWith(
              tickets: List.of(filteredTickets),
              isVNA: event.isVNA,
              isDepartBefore12: event.isDepartBefore12,
              isPriceLessThan5Mil: event.isPriceLessThan5Mil,
            ));
    }
  }

  final List<TicketItem> tickets = [];
  final List<TicketItem> returnTickets = [];
}
