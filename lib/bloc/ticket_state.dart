part of 'ticket_bloc.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object?> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final Date date;
  final List<TicketItem> tickets;
  final List<TicketItem> returnTickets;
  final TicketItem? selectedTicket;
  final TicketItem? selectedReturnTicket;
  final int selectedDate;

  const TicketLoaded({
    required this.date,
    required this.tickets,
    required this.returnTickets,
    required this.selectedDate,
    this.selectedTicket,
    this.selectedReturnTicket,
  });

  @override
  List<Object?> get props => [
        tickets,
        returnTickets,
        selectedDate,
        date,
        selectedTicket,
        selectedReturnTicket,
      ];

  TicketLoaded copyWith({
    Date? date,
    List<TicketItem>? tickets,
    List<TicketItem>? returnTickets,
    TicketItem? selectedTicket,
    TicketItem? selectedReturnTicket,
    int? selectedDate,
  }) {
    return TicketLoaded(
      date: date ?? this.date,
      tickets: tickets ?? this.tickets,
      returnTickets: returnTickets ?? this.returnTickets,
      selectedTicket: selectedTicket ?? this.selectedTicket,
      selectedReturnTicket: selectedReturnTicket ?? this.selectedReturnTicket,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
