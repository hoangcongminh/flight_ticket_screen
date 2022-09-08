part of 'date_bloc.dart';

enum DateStatus { initial, success, loading, failure }

class DateState extends Equatable {
  final DateStatus? status;
  final List<DateItem>? date;
  final DateTime? selectedDepartDate;
  final DateTime? selectedReturnDate;
  final DateTime? currentDate;
  final bool? isScroll;
  const DateState({
    this.status = DateStatus.initial,
    this.date,
    this.selectedDepartDate,
    this.selectedReturnDate,
    this.currentDate,
    this.isScroll,
  });

  @override
  List<Object?> get props => [
        status,
        date,
        selectedDepartDate,
        selectedReturnDate,
        currentDate,
      ];

  DateState copyWith({
    DateStatus? status,
    List<DateItem>? date,
    bool? hasReachedMax,
    DateTime? selectedDepartDate,
    DateTime? selectedReturnDate,
    DateTime? currentDate,
    bool? isScroll,
  }) {
    return DateState(
      status: status ?? this.status,
      date: date ?? this.date,
      selectedDepartDate: selectedDepartDate ?? this.selectedDepartDate,
      selectedReturnDate: selectedReturnDate ?? this.selectedReturnDate,
      currentDate: currentDate ?? this.currentDate,
      isScroll: isScroll ?? this.isScroll,
    );
  }
}
