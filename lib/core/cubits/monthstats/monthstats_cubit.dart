import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/features/history/datatypes/user_month_stats.dart';
import 'package:gps_attendance/services/firestore_service.dart';

part 'monthstats_state.dart';

class MonthStatsCubit extends Cubit<MonthStatsState> {
  FirestoreService firestoreService;

  MonthStatsCubit({required this.firestoreService})
      : super(MonthStatsInitial()) {
    getCurrentMonthStats();
  }

  Future<void> getCurrentMonthStats() async {
    emit(MonthStatsLoading());
    try {
      UserMonthStatsResult userMonthStatsResult =
          await firestoreService.getMonthStatsforUser(
        userId: FirebaseAuth.instance.currentUser!.uid,
        date: DateTime.now(),
      );
      emit(MonthStatsLoaded(userMonthStatsResult: userMonthStatsResult));
    } catch (e) {
      emit(MonthStatsError(errorMessage: e.toString()));
    }
  }
}
