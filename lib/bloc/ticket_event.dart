part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class FetchTicketEvent extends TicketEvent {}

class SelectTicketEvent extends TicketEvent {
  final TicketItem selectedTicket;
  final bool isReturnTicket;
  const SelectTicketEvent({
    required this.selectedTicket,
    required this.isReturnTicket,
  });

  @override
  List<Object> get props => [selectedTicket, isReturnTicket];
}

class SortTicket extends TicketEvent {
  final bool isReturnTickets;
  final int priceValue;
  final int flightValue;
  final int landingValue;
  const SortTicket({
    required this.isReturnTickets,
    required this.priceValue,
    required this.flightValue,
    required this.landingValue,
  });

  @override
  List<Object> get props => [priceValue, flightValue, landingValue];
}
