part of 'monthstats_cubit.dart';

abstract class MonthStatsState extends Equatable {
  const MonthStatsState();

  @override
  List<Object> get props => [];
}

class MonthStatsInitial extends MonthStatsState {}

class MonthStatsLoading extends MonthStatsState {}

class MonthStatsLoaded extends MonthStatsState {
  final UserMonthStatsResult userMonthStatsResult;

  const MonthStatsLoaded({required this.userMonthStatsResult});
}

class MonthStatsError extends MonthStatsState {
  final String errorMessage;

  const MonthStatsError({required this.errorMessage});
}
