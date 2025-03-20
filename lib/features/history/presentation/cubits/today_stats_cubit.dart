import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/services/firestore_service.dart';

part 'today_stats_state.dart';

class TodayStatsCubit extends Cubit<TodayStatsState> {
  FirestoreService firestoreService;
  TodayStatsCubit({required this.firestoreService})
      : super(TodayStatsInitial()) {
    getTodayStats();
  }

  void getTodayStats() async {
    try {
      final stats = await firestoreService.getTodayStats();
      if (stats.overTime > Duration.zero) {
        emit(TodayStatsLoaded(
            totalHours: _hoursFormat(stats.totalHours),
            overtime: _hoursFormat(stats.overTime),
            isRegular: true));
      } else {
        emit(TodayStatsLoaded(
            totalHours: _hoursFormat(stats.totalHours),
            overtime: _hoursFormat(stats.overTime),
            isRegular: false));
      }
    } catch (e) {
      emit(TodayStatsError(errorMessage: e.toString()));
    }
  }

  _hoursFormat(Duration time) {
    return '${time.inHours}H ${time.inMinutes.remainder(60)}M';
  }
}
