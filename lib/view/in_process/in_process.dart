import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine/common/color_constant/color_constant.dart';
import 'package:imagine/common/image_constant/image_constant.dart';
import 'package:imagine/cubit/delete_task/delete_task_cubit.dart';
import 'package:imagine/cubit/task_list/task_list_cubit.dart';
import 'package:imagine/cubit/task_status/task_status_cubit.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/model/task_list/task_list_res_model.dart';
import 'package:imagine/repositories/repository.dart';
import 'package:imagine/router/app_router.dart';
import 'package:imagine/widget/app_easy_loading.dart';
import 'package:imagine/widget/common_text.dart';
import 'package:imagine/widget/fancy_loader.dart';
import 'package:imagine/widget/log_out_dialog.dart';
import 'package:imagine/widget/text_fom_field.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class InProcess extends StatefulWidget {
  const InProcess({super.key});

  @override
  State<InProcess> createState() => _InProcessState();
}

class _InProcessState extends State<InProcess> {
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTaskPending();
  }

  getTaskPending() {
    context.read<TaskListCubit>().init(status: 'In Process');
  }

  Future<void> _selectStartDate() async {
    // Get the current date
    DateTime now = DateTime.now();
    DateTime previousMonth = DateTime(now.year, now.month, now.day);

    // Pick start date
    DateTime? startDate = await showDatePicker(
      context: context,
      initialDate: previousMonth,
      firstDate: DateTime(now.year - 10),
      lastDate: previousMonth,
    );

    if (startDate != null) {
      setState(() {
        _startDate.text = DateFormat('dd-MM-yyyy').format(startDate);
      });
    }
  }

  Future<void> _selectEndDate() async {
    if (_startDate.text.isEmpty) {
      return;
    }

    // Convert _startDate to DateTime
    List<String> startDateParts = _startDate.text.split('-');
    DateTime startDate = DateTime(
      int.parse(startDateParts[2]), // Year
      int.parse(startDateParts[1]), // Month
      int.parse(startDateParts[0]), // Day
    );

    // Pick end date
    DateTime? endDate = await showDatePicker(
      context: context,
      initialDate: startDate.add(Duration(days: 1)),
      firstDate: startDate,
      lastDate: startDate.add(Duration(days: 30)),
    );

    if (endDate != null) {
      setState(() {
        // Format the selected date as 'dd-MM-yyyy'
        _endDate.text = DateFormat('dd-MM-yyyy').format(endDate);
      });
    }
  }

  Widget _listener() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(84, 74, 113, 0.10),
            offset: Offset(-50, 30),
            blurRadius: 50,
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: PagedListView.separated(
        pagingController: context.read<TaskListCubit>().pagingController,
        builderDelegate: PagedChildBuilderDelegate<Data>(
          noItemsFoundIndicatorBuilder: (context) => const Center(
              child: CustomText(
            text: 'Data Not Found!...',
          )),
          firstPageProgressIndicatorBuilder: (context) =>
              const Center(child: FadingCircleLoader()),
          newPageProgressIndicatorBuilder: (context) => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
          firstPageErrorIndicatorBuilder: (context) => const Center(
            child: CustomText(
              text: "Something went wrong!",
            ),
          ),
          itemBuilder: (context, item, index) {
            log("item Counttt${item.note.toString()}");

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  padding: EdgeInsets.only(bottom: 15, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              maxLine: 2,
                              text: item.description!,
                              textOverflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          BlocListener<DeleteTaskCubit, DeleteTaskState>(
                            listener: (context, state) {
                              if (state is DeleteTaskLoading) {
                                easyLoadingShowProgress(
                                    status: "Please Wait...");
                              } else if (state is DeleteTaskSuccess) {
                                easyLoadingShowSuccess(state.message);
                              } else if (state is DeleteTaskError) {
                                easyLoadingShowError(state.message);
                              }
                            },
                            child: userName == '9099200965'
                                ? InkWell(
                                    onTap: () async {
                                      final result = await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return MultiBlocProvider(
                                            providers: [
                                              BlocProvider.value(
                                                value: context.read<
                                                    DeleteTaskCubit>(), // Pass the existing instance
                                              ),
                                            ],
                                            child: AlertDialog(
                                              title: Text('Delete Task'),
                                              content: Text('Are you sure you want to delete this task?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                          dialogContext)
                                                      .pop(false),
                                                  child: Text('Cancel'),
                                                ),
                                                BlocListener<DeleteTaskCubit,
                                                    DeleteTaskState>(
                                                  listener: (context, state) {
                                                    if (state
                                                        is DeleteTaskLoading) {
                                                      easyLoadingShowProgress(
                                                          status:
                                                              "Please Wait...");
                                                    } else if (state
                                                        is DeleteTaskSuccess) {
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop(true);
                                                      easyLoadingShowSuccess(
                                                          state.message);
                                                    } else if (state
                                                        is DeleteTaskError) {
                                                      easyLoadingShowError(
                                                          state.message);
                                                    }
                                                  },
                                                  child: TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              DeleteTaskCubit>()
                                                          .deleteTaskCubite(
                                                            user_id: userId
                                                                .toString(),
                                                            task_id: item.id
                                                                .toString(),
                                                          );
                                                    },
                                                    child: Text('Delete'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );

                                      if (result == true) {
                                        // Remove item from the list and refresh UI
                                        context
                                            .read<TaskListCubit>()
                                            .pagingController
                                            .itemList
                                            ?.remove(item);
                                        context
                                            .read<TaskListCubit>()
                                            .pagingController
                                            .refresh();
                                      }
                                    },
                                    child: Icon(
                                      color:Colors.black54,
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                          IconButton(
                              onPressed: () {
                                AppRouter.navigatorKey.currentState?.pushNamed(
                                    AppRouter.editeView,
                                    arguments: item);
                              },
                              icon: Icon(
                                color:Colors.black54,
                                Icons.edit,
                                size: 20,
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: item.partyName!,
                              fontSize: 16,
                              maxLine: 1,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple.shade100,
                              radius: 16,
                              child: Text(
                                item.billNo!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        children: [
                          CustomText(text: 'Assign : ${item.assignedTo}'),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                size: 20,
                              ),
                              SizedBox(width: 6),
                              CustomText(
                                text: item.taskDate!,
                                fontSize: 12,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              if (userRole == 'user') {
                                easyLoadingShowError(
                                    'This action is restricted. Only the admin has the permission to make changes.');
                              } else {
                                final result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => TaskStatusCubit(
                                            context.read<Repository>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => TaskListCubit(
                                            context.read<Repository>(),
                                          ),
                                        ),
                                      ],
                                      child: Builder(builder: (context) {
                                        return AlertDialog(
                                          title: Text('Confirm Action'),
                                          content: Text(
                                              'Are you sure you want to mark this task as done?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                // Close the dialog
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            BlocListener<TaskStatusCubit,
                                                TaskStatusState>(
                                              listener: (context, state) {
                                                if (state
                                                    is TaskStatusLoading) {
                                                  easyLoadingShowProgress(
                                                      status: "Please Wait...");
                                                } else if (state
                                                    is TaskStatusSuccess) {
                                                  Navigator.pop(context, true);
                                                } else if (state
                                                    is TaskStatusError) {
                                                  easyLoadingShowError('error');
                                                }
                                              },
                                              child: TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<TaskStatusCubit>()
                                                      .taskStatusCubit(
                                                        userId: userId!,
                                                        taskIds:
                                                            item.id.toString(),
                                                        status: 'Done',
                                                        item: item,
                                                        context: context,
                                                      );
                                                },
                                                child: Text('OK'),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    );
                                  },
                                );
                                print('result $result');
                                if (result == true) {
                                  context
                                      .read<TaskListCubit>()
                                      .pagingController
                                      .itemList
                                      ?.remove(item);
                                  context
                                      .read<TaskListCubit>()
                                      .pagingController
                                      .refresh();
                                  easyLoadingShowSuccess('success');
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 3.0),
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                item.status!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) {
          return SizedBox.shrink();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('deleteTasks$deleteTasks');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: Padding(
            padding: const EdgeInsets.only(right: 7),
            child: ClipOval(
              child: IconButton(
                icon: Image.asset(
                  AppIcons.app_logo,
                  height: 40,
                  width: 40,
                ),
                onPressed: () {},
              ),
            ),
          ),
          title: Text(fullName.toString()),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const LogoutDialogBox();
                  },
                );
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(84, 74, 113, 0.10), // Shadow color
                offset: Offset(-50, 30), // Horizontal and vertical offset
                blurRadius: 50, // Blur radius
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                color: Colors.transparent,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: CustomTextField(
                          controller: _startDate,
                          onTap: () {
                            _selectStartDate();
                          },
                          fillColor: Colors.white,
                          hintText: 'From Date',
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: CustomTextField(
                          controller: _endDate,
                          hintText: 'To Date',
                          fillColor: Colors.white,
                          readOnly: true,
                          onTap: () {
                            _selectEndDate();
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      height: 45,
                      child: Card(
                          color: Colors.blue,
                          child: IconButton(
                              onPressed: () {
                                print('printt ${_startDate.text}');
                                print('printtEnd ${_endDate.text}');
                                context.read<TaskListCubit>().setFilters(
                                      startDate: _startDate.text.toString(),
                                      endDate: _endDate.text.toString(),
                                    );
                              },
                              icon: Icon(
                                Icons.search,
                                size: 20,
                              ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: search,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    // Adjust vertical padding
                    hintText: "Search..",
                    hintStyle:
                        TextStyle(color: AppColors.greyA6AEBF, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: SizedBox.shrink(), // Added trailing widget
                  ),
                  onChanged: (value) {
                    context
                        .read<TaskListCubit>()
                        .setSearch(value); // Update search
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(child: _listener())
            ],
          ),
        ));
  }
}
