// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine/data/hydrated_storage/create_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/delete_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/edit_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_id_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_role_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/view_all_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/view_task_hydrated_storage_cubit.dart';
import 'package:imagine/router/app_router.dart';

import 'package:imagine/widget/common_text.dart';
import 'package:imagine/widget/container.dart';
import 'package:imagine/widget/text.dart';

class LogoutDialogBox extends StatelessWidget {
  const LogoutDialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContainerWidget(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                CommonText(
                  text: 'Logout?',
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                CommonText(
                  text: 'Are you sure you want to logout?',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)),
                          child: Center(
                            child: CustomText(
                              text: 'Cancle',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context
                              .read<UserIdHydratedStorageCubit>()
                              .clearData();

                          context
                              .read<UserRoleHydratedStorageCubit>()
                              .clearData();

                          context.read<UserIdHydratedStorageCubit>().clear();

                          context.read<UserRoleHydratedStorageCubit>().clear();
                          Navigator.pop(context);

                          AppRouter.navigatorKey.currentState
                              ?.pushNamedAndRemoveUntil(
                            AppRouter.login,
                            (route) => false,
                          );
                        },
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)),
                          child: Center(
                            child: CustomText(
                              text: 'LOGOUT',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
