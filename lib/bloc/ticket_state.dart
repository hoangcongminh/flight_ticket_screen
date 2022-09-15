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

  final bool? isVNA;
  final bool? isDepartBefore12;
  final bool? isPriceLessThan5Mil;

  final bool? isVNAReturn;
  final bool? isDepartBefore12Return;
  final bool? isPriceLessThan5MilReturn;

  const TicketLoaded({
    required this.date,
    required this.tickets,
    required this.returnTickets,
    required this.selectedDate,
    this.selectedTicket,
    this.selectedReturnTicket,
    this.isVNA = false,
    this.isDepartBefore12 = false,
    this.isPriceLessThan5Mil = false,
    this.isVNAReturn = false,
    this.isDepartBefore12Return = false,
    this.isPriceLessThan5MilReturn = false,
  });

  @override
  List<Object?> get props => [
        tickets,
        returnTickets,
        selectedDate,
        date,
        selectedTicket,
        selectedReturnTicket,
        isVNA,
        isDepartBefore12,
        isPriceLessThan5Mil,
      ];

  TicketLoaded copyWith({
    Date? date,
    List<TicketItem>? tickets,
    List<TicketItem>? returnTickets,
    TicketItem? selectedTicket,
    TicketItem? selectedReturnTicket,
    int? selectedDate,
    bool? isVNA,
    bool? isDepartBefore12,
    bool? isPriceLessThan5Mil,
    bool? isVNAReturn,
    bool? isDepartBefore12Return,
    bool? isPriceLessThan5MilReturn,
  }) {
    return TicketLoaded(
      date: date ?? this.date,
      tickets: tickets ?? this.tickets,
      returnTickets: returnTickets ?? this.returnTickets,
      selectedTicket: selectedTicket ?? this.selectedTicket,
      selectedReturnTicket: selectedReturnTicket ?? this.selectedReturnTicket,
      selectedDate: selectedDate ?? this.selectedDate,
      isVNA: isVNA ?? this.isVNA,
      isDepartBefore12: isDepartBefore12 ?? this.isDepartBefore12,
      isPriceLessThan5Mil: isPriceLessThan5Mil ?? this.isPriceLessThan5Mil,
      isVNAReturn: isVNAReturn ?? this.isVNAReturn,
      isDepartBefore12Return:
          isDepartBefore12Return ?? this.isDepartBefore12Return,
      isPriceLessThan5MilReturn:
          isPriceLessThan5MilReturn ?? this.isPriceLessThan5MilReturn,
    );
  }
}
