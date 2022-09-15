part of 'date_bloc.dart';

abstract class DateEvent extends Equatable {
  const DateEvent();

  @override
  List<Object?> get props => [];
}

class FetchDateEvent extends DateEvent {
  final int? fetchNums;

  const FetchDateEvent([this.fetchNums]);
  @override
  List<Object?> get props => [fetchNums];
}

class SelectDepartDateEvent extends DateEvent {
  final DateTime selectedDepartDate;
  const SelectDepartDateEvent({required this.selectedDepartDate});

  @override
  List<Object> get props => [selectedDepartDate];
}

class SelectedReturnDate extends DateEvent {
  final DateTime selectedReturnDate;
  const SelectedReturnDate({required this.selectedReturnDate});

  @override
  List<Object> get props => [selectedReturnDate];
}
