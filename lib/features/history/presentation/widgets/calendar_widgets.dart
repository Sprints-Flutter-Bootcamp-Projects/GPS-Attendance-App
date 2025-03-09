import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    final meeting = _getMeetingData(index);
    debugPrint('Meeting Start Time: ${meeting.from}');
    return meeting.from;
  }

  @override
  DateTime getEndTime(int index) {
    final meeting = _getMeetingData(index);
    debugPrint('Meeting End Time: ${meeting.to}');
    return meeting.to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class AppCalendar extends StatelessWidget {
  final List<Meeting> source;
  final CalendarController controller;
  const AppCalendar(
      {super.key, required this.source, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      cellBorderColor: Theme.of(context).dividerColor,
      headerStyle: CalendarHeaderStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        textStyle: TextStyle(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      viewHeaderStyle: ViewHeaderStyle(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        dateTextStyle: TextStyle(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        dayTextStyle: TextStyle(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      appointmentTextStyle: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
          fontFamily: 'Inter'),
      view: CalendarView.month,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      todayTextStyle: TextStyle(
        color: Theme.of(context).scaffoldBackgroundColor,
        fontWeight: FontWeight.bold,
      ),
      todayHighlightColor: Theme.of(context).primaryColor,
      monthCellBuilder: (context, details) {
        final DateTime today = DateTime.now();
        final bool isToday = details.date.year == today.year &&
            details.date.month == today.month &&
            details.date.day == today.day;
        // if not in the same month, return diff text color
        return Container(
          decoration: BoxDecoration(
              color: isToday
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle),
          child: Center(
            child: Text(
              details.date.day.toString(),
              style: TextStyle(
                color: isToday
                    ? Theme.of(context).scaffoldBackgroundColor
                    : details.date.month != today.month
                        ? Theme.of(context).dividerColor
                        : Theme.of(context).colorScheme.onSurface,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
      allowViewNavigation: true,
      showNavigationArrow: true,
      allowedViews: const [
        CalendarView.day,
        CalendarView.week,
        CalendarView.month,
        CalendarView.schedule,
      ],
      initialDisplayDate: DateTime.now(),
      controller: controller,
      scheduleViewMonthHeaderBuilder: (context, details) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).primaryColor.withAlpha(15),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Text(
            DateFormat('MMMM, yyyy').format(details.date),
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
          ),
        );
      },
      showCurrentTimeIndicator: true,
      showDatePickerButton: true,
      scheduleViewSettings: ScheduleViewSettings(
          weekHeaderSettings: WeekHeaderSettings(
              textAlign: TextAlign.start,
              weekTextStyle: Theme.of(context).textTheme.headlineMedium),
          monthHeaderSettings: const MonthHeaderSettings(
            height: 60,
          ),
          appointmentTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
          )),
      dataSource: MeetingDataSource(source),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
      ),
      timeSlotViewSettings: TimeSlotViewSettings(
        timeInterval: Duration(minutes: 30),
        timeFormat: 'hh:mm',
        timeIntervalHeight: MediaQuery.of(context).size.height * 0.07,
        timeTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 12,
        ),
      ),
      appointmentBuilder: (context, details) {
        final DateFormat timeFormat = DateFormat('hh:mm a');
        return ListView(
          children: details.appointments.map((appointment) {
            final Meeting meeting = appointment as Meeting;
            final double durationInMinutes =
                meeting.to.difference(meeting.from).inMinutes.toDouble();
            return Container(
              height: (durationInMinutes / 30) *
                  (MediaQuery.of(context).size.height * 0.07),
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: meeting.background,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meeting.eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${timeFormat.format(meeting.from)} - ${timeFormat.format(meeting.to)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
