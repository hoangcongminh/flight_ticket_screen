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
  final int? priceValue;
  final int? flightValue;
  final int? landingValue;
  const SortTicket({
    required this.isReturnTickets,
    this.priceValue,
    this.flightValue,
    this.landingValue,
  });

  @override
  List<Object> get props => [
        isReturnTickets,
      ];
}

class FilterTicket extends TicketEvent {
  final bool isReturnTickets;
  final bool? isVNA;
  final bool? isDepartBefore12;
  final bool? isPriceLessThan5Mil;
  const FilterTicket({
    required this.isReturnTickets,
    this.isVNA,
    this.isDepartBefore12,
    this.isPriceLessThan5Mil,
  });

  @override
  List<Object> get props => [
        isReturnTickets,
      ];
}
