import 'dart:io';
import 'dart:ui';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:imagine/data/hydrated_storage/create_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/delete_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/edit_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/full_name_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/id_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_id_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_name_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_role_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/view_all_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/view_task_hydrated_storage_cubit.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/router/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

bool status = false;

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = context.read<UserIdHydratedStorageCubit>().state != null;
    userId = context.read<UserIdHydratedStorageCubit>().state ?? "";
    id = context.read<IdHydratedStorageCubit>().state ?? "";
    fullName = context.read<FullNameHydratedStorageCubit>().state ?? "";
    userName = context.read<UserNameHydratedStorageCubit>().state ?? "";
    deleteTasks = context.read<DeleteTaskHydratedStorageCubit>().state ?? true;
    createTasks = context.read<CreateTaskHydratedStorageCubit>().state ?? true;
    viewTasks = context.read<ViewTaskHydratedStorageCubit>().state ?? true;
    editTasks = context.read<EditTaskHydratedStorageCubit>().state ?? true;
    viewAllTasks = context.read<ViewAllTaskHydratedStorageCubit>().state ?? true;
    userRole = context.read<UserRoleHydratedStorageCubit>().state ?? "";



    return kReleaseMode
        ? _releaseWidget(context, isLoggedIn)
        : _debugWidget(context, isLoggedIn);
  }
}

/// release mode material app.
_releaseWidget(
  BuildContext context,
  bool isLoggedIn,
) =>
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppRouter.navigatorKey,
      initialRoute: isLoggedIn ? AppRouter.dashboard : AppRouter.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      scrollBehavior: const ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.trackpad,
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      builder: (context, child) {
        var responsiveChild = _responsiveWrapperWidget(context, child!);
        return EasyLoading.init()(context, responsiveChild);
      },
    );

/// debug mode material app.
_debugWidget(
  BuildContext context,
  bool isLoggedIn,
) =>
    BlocOverrides.runZoned(
      () => DevicePreview(
        enabled: false,
        builder: (context) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          navigatorKey: AppRouter.navigatorKey,
          initialRoute: isLoggedIn ? AppRouter.dashboard : AppRouter.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          scrollBehavior: const ScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.trackpad,
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          useInheritedMediaQuery: true,
          builder: (context, child) {
            var responsiveChild = _responsiveWrapperWidget(context, child!);
            var dchild = DevicePreview.appBuilder(context, responsiveChild);
            return EasyLoading.init()(context, dchild);
          },
        ), // Wrap your app
      ),
      // blocObserver: AppBlocObserver()
    );

/// used to make responsive. set breakpoint here.
_responsiveWrapperWidget(BuildContext context, Widget child) {
  return ResponsiveWrapper.builder(
    ClampingScrollWrapper.builder(context, child),
    breakpoints: Platform.isWindows || Platform.isMacOS
        ? [
            ResponsiveBreakpoint.resize(600, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(1100, name: DESKTOP),
            // ResponsiveBreakpoint.resize(1025, name: DESKTOP),
            // ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ]
        : MediaQuery.of(context).orientation == Orientation.landscape
            ? [
                ResponsiveBreakpoint.autoScale(850, name: TABLET),
              ]
            : [
                ResponsiveBreakpoint.autoScale(360, name: MOBILE),
                ResponsiveBreakpoint.autoScale(500, name: TABLET),
                //ResponsiveBreakpoint.resize(835, name: DESKTOP),
                //  ResponsiveBreakpoint.autoScale(835, name: TABLET),
              ],
  );
}
