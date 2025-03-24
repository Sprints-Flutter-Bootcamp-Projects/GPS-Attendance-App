import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/features/attendance/datatypes/geofence_result.dart';
import 'package:gps_attendance/widgets/ui_components/buttons/button.dart';
import 'package:mocktail/mocktail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_attendance/features/attendance/presentation/screens/attendance_page.dart';
import 'package:gps_attendance/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:gps_attendance/services/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mocks
class MockLocationService extends Mock implements LocationService {}

class MockAttendanceBloc extends Mock implements AttendanceBloc {
  @override
  Future<void> close() async => super.noSuchMethod(
        Invocation.method(#close, []),
      );
}

// Fake Events
class FakeCheckIn extends Fake implements CheckIn {}

class FakeCheckOut extends Fake implements CheckOut {}

class FakeInitializeWorkZone extends Fake implements InitializeWorkZone {}

final getIt = GetIt.instance;

void main() {
  late MockLocationService mockLocationService;
  late MockAttendanceBloc mockAttendanceBloc;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await initializeDependencies();

    // Register all fake events
    registerFallbackValue(FakeCheckIn());
    registerFallbackValue(FakeCheckOut());
    registerFallbackValue(FakeInitializeWorkZone());
  });

  setUp(() async {
    await getIt.reset();

    final prefs = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(prefs);

    mockLocationService = MockLocationService();
    mockAttendanceBloc = MockAttendanceBloc();

    // Setup common mocks
    when(() => mockAttendanceBloc.close()).thenAnswer((_) async {});
    when(() => mockAttendanceBloc.add(any<InitializeWorkZone>()))
        .thenReturn(null);
    when(() => mockAttendanceBloc.state).thenReturn(AttendanceInitial());
    when(() => mockAttendanceBloc.stream).thenAnswer((_) => Stream.empty());
    when(() => mockAttendanceBloc.workZone).thenReturn(null);

    getIt.registerSingleton<LocationService>(mockLocationService);
    getIt.registerSingleton<AttendanceBloc>(mockAttendanceBloc);
  });

  tearDown(() {
    resetMocktailState();
  });

  group('Attendance Page Tests', () {
    testWidgets('Successful check-in flow', (tester) async {
      when(() => mockLocationService.isUserWithinGeofence())
          .thenAnswer((_) async => GeofenceResult(
                isWithinGeofence: true,
                userLatLng: const LatLng(37.4219999, -122.0840575),
              ));

      when(() => mockLocationService.checkIn()).thenAnswer((_) async => true);

      whenListen(
        mockAttendanceBloc,
        Stream.fromIterable([
          AttendanceCheckInLoading(),
          AttendanceEmployeeIsInArea(
            employeeLocation: const LatLng(37.4219999, -122.0840575),
            hasCheckedIn: true,
          ),
        ]),
        initialState: AttendanceInitial(),
      );

      await tester.binding.setSurfaceSize(const Size(1440, 2560));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AttendancePage(),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find and verify button
      final buttonFinder = find.byType(TrackSyncButton).first;
      await tester.ensureVisible(buttonFinder);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder, warnIfMissed: false);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      verify(() => mockAttendanceBloc.add(any<CheckIn>())).called(1);
      expect(find.text('You Have Checked In Successfully!'), findsOneWidget);
    });

    testWidgets('Check-in outside workzone shows error', (tester) async {
      when(() => mockLocationService.isUserWithinGeofence())
          .thenAnswer((_) async => GeofenceResult(
                isWithinGeofence: false,
                userLatLng: const LatLng(37.4219999, -122.0840575),
              ));

      whenListen(
        mockAttendanceBloc,
        Stream.fromIterable([
          AttendanceCheckInLoading(),
          AttendanceEmployeeIsNotInArea(
            employeeLocation: const LatLng(37.4219999, -122.0840575),
          ),
        ]),
        initialState: AttendanceInitial(),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: AttendancePage()),
      ));
      await tester.pumpAndSettle();

      await tester.tap(find
          .descendant(
            of: find.byType(TrackSyncButton),
            matching: find.text('Check In'),
          )
          .first);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('You Can\'t Check in or out Outside Work Zone!'),
          findsOneWidget);
    });

    testWidgets('Shows loading state during check-in', (tester) async {
      whenListen(
        mockAttendanceBloc,
        Stream.value(AttendanceCheckInLoading()),
        initialState: AttendanceInitial(),
      );

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: AttendancePage()),
      ));

      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
