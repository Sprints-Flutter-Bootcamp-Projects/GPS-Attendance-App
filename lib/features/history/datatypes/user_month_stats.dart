class UserMonthStatsResult {
  final int daysPresent;
  final Duration totalHours;
  final Duration totalOvertime;

  UserMonthStatsResult({
    required this.daysPresent,
    required this.totalHours,
    required this.totalOvertime,
  });
}
