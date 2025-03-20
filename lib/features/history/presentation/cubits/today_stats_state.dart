part of 'today_stats_cubit.dart';

abstract class TodayStatsState extends Equatable {
  const TodayStatsState();

  @override
  List<Object> get props => [];
}

class TodayStatsInitial extends TodayStatsState {}

class TodayStatsLoading extends TodayStatsState {}

class TodayStatsLoaded extends TodayStatsState {
  final String totalHours;
  final String overtime;
  final bool isRegular;

  const TodayStatsLoaded(
      {required this.totalHours,
      required this.overtime,
      required this.isRegular});
}

class TodayStatsError extends TodayStatsState {
  final String errorMessage;

  const TodayStatsError({required this.errorMessage});
}
