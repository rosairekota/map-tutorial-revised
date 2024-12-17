import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_tutorial_template/application/app_life_cycle/app_life_cycle_cubit.dart';
import 'package:map_tutorial_template/application/location/location_cubit.dart';
import 'package:map_tutorial_template/application/permission/permission_cubit.dart';
import 'package:map_tutorial_template/injection.dart';
import 'package:map_tutorial_template/presentation/map/map_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<PermissionCubit>()..initialize(),
        ),
        BlocProvider(
          create: (context) => getIt<ApplicationLifeCycleCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<LocationCubit>()..initialize(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Map Tutorial Template',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MapPage(),
      ),
    );
  }
}
