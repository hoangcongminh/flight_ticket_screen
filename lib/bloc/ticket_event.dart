part of 'ticket_bloc.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class FetchTicketEvent extends TicketEvent {
  const FetchTicketEvent();
}

class SelectDateEvent extends TicketEvent {
  final int selectedDate;
  const SelectDateEvent({required this.selectedDate});

  @override
  List<Object> get props => [selectedDate];
}

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
