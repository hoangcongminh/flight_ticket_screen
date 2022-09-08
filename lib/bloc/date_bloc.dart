import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket/utils/datetime_extension.dart';

import '../model/date.dart';

part 'date_event.dart';
part 'date_state.dart';

class DateBloc extends Bloc<DateEvent, DateState> {
  DateBloc() : super(const DateState()) {
    on<DateEvent>((event, emit) {});
    on<FetchDateEvent>(_fetchDates);
    on<SelectDepartDateEvent>(_selectDate);
    on<SelectedReturnDate>(_selectReturnDate);
  }

  Future<void> _fetchDates(
      FetchDateEvent event, Emitter<DateState> emit) async {
    if (state.status == DateStatus.initial) {
      var jsonDate = await rootBundle.loadString('assets/data/date.json');
      final Date date = Date.fromJson(json.decode(jsonDate));
      final currentDate = date.data!
          .where((element) => element.departDate!.isSameDate(DateTime.now()));
      dates.addAll(date.data!);
      return emit(
        state.copyWith(
          status: DateStatus.success,
          date: dates,
          hasReachedMax: false,
          selectedDepartDate: currentDate.first.departDate!,
          selectedReturnDate: currentDate.first.departDate!,
          currentDate: currentDate.first.departDate!,
          isScroll: true,
        ),
      );
    }
    final List<DateItem> newList = [];
    final lastDate = state.date!.last;
    await Future.delayed(const Duration(seconds: 1));
    final fetchNums = event.fetchNums ?? 7;
    for (int i = 1; i <= fetchNums; i++) {
      final randomPrice = 100000 + Random().nextInt(1000000 - 100000);
      newList.add(lastDate.copyWith(
        departDate: lastDate.departDate!.add(Duration(days: i)),
        totalPrice: randomPrice,
      ));
    }
    emit(state.copyWith(
      date: List.of(state.date!)..addAll(newList),
      isScroll: false,
    ));
  }

  Future<void> _selectDate(
      SelectDepartDateEvent event, Emitter<DateState> emit) async {
    emit(state.copyWith(
      selectedDepartDate: event.selectedDepartDate,
      isScroll: true,
    ));
  }

  Future<void> _selectReturnDate(
      SelectedReturnDate event, Emitter<DateState> emit) async {
    emit(state.copyWith(
      selectedReturnDate: event.selectedReturnDate,
      isScroll: true,
    ));
  }

  final List<DateItem> dates = [];
}
