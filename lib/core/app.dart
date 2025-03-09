import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/themes/theme_bloc/theme_bloc.dart';
import 'package:gps_attendance/features/history/presentation/pages/history_page.dart';

import 'package:gps_attendance/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => sl()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        final themeBloc = BlocProvider.of<ThemeBloc>(context);
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeBloc.themeData,
          themeMode: ThemeMode.system,
          initialRoute: HistoryPage.routeName,
          routes: {
            HistoryPage.routeName: (context) => HistoryPage(),
          },
        );
      }),
    );
  }
}
