import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:imagine/common/color_constant/color_constant.dart';
import 'package:imagine/common/image_constant/image_constant.dart';
import 'package:imagine/cubit/delete_task/delete_task_cubit.dart';
import 'package:imagine/cubit/dropdown/dropdown_cubit.dart';
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

class HomeView extends StatefulWidget {
  // String id;

  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  TextEditingController search = TextEditingController();
  // List<String> selectedItem = [];
  List<String> selectedItems = [];

  List<String> listStatus = [
    'Select All',
    'Awaiting',
    // 'In Process',
    'Pending',
    'Done',
    'Cancelled',
    // 'On Hold',
  ];

  List<String> assignList = [];

  @override
  void initState() {
    super.initState();
    fetchAllPartyName();
    getTaskPending();
  }

  fetchAllPartyName() {
    context.read<DropdownCubit>().fetchPartyName();
  }

  getTaskPending() {
    List<String> selectedItem = [
      // "In Process",
      "Awaiting",
      "Pending",
      "Cancelled",
      // "On Hold"
    ];
    context
        .read<TaskListCubit>()
        .init(selectedStatus: selectedItem, status: '', isFilter: true);
  }

  Widget _listener() {
    return Container(
      decoration: const BoxDecoration(
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 15, left: 15),
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
                              print("userName$userName");
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
                                              title: const Text('Delete Task'),
                                              content: const Text(
                                                  'Are you sure you want to delete this task?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(
                                                          dialogContext)
                                                      .pop(false),
                                                  child: const Text('Cancel'),
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
                                                    child: const Text('Delete'),
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
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      // decoration: BoxDecoration(
                                      //   shape: BoxShape.rectangle,
                                      //     borderRadius: BorderRadius.all(Radius.circular(5)),
                                      //     border:
                                      //         Border.all(color: Colors.grey)),
                                      child: const Icon(
                                        color: Colors.black45,
                                        Icons.delete,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          IconButton(
                              onPressed: () {
                                AppRouter.navigatorKey.currentState?.pushNamed(
                                    AppRouter.editeView,
                                    arguments: item);
                              },
                              icon: Container(
                                padding: const EdgeInsets.all(3),
                                // decoration: BoxDecoration(
                                //     shape: BoxShape.rectangle,
                                //     borderRadius: BorderRadius.all(Radius.circular(5)),
                                //     border:
                                //     Border.all(color: Colors.grey)),
                                child: const Icon(
                                  color: Colors.black54,
                                  Icons.edit,
                                  size: 20,
                                ),
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
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          CustomText(text: 'Assign : ${item.assignedTo}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              CustomText(
                                text: item.taskDate!,
                                fontSize: 12,
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              log('123454${id}');
                              log('123454${item.userId}');
                              log('assignTo${item.assignTo}');

                              if (userRole == 'user') {
                                if ((item.assignTo == null &&
                                        id == item.userId) ||
                                    (item.assignTo != null &&
                                        id == item.assignTo)) {
                                  final result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) =>
                                                TaskStatusCubit(
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
                                            title: const Text('Confirm Action'),
                                            content: const Text(
                                                'Are you sure you want to mark this task as done?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // Close the dialog
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              BlocListener<TaskStatusCubit,
                                                  TaskStatusState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is TaskStatusLoading) {
                                                    easyLoadingShowProgress(
                                                        status:
                                                            "Please Wait...");
                                                  } else if (state
                                                      is TaskStatusSuccess) {
                                                    Navigator.pop(
                                                        context, true);
                                                  } else if (state
                                                      is TaskStatusError) {
                                                    easyLoadingShowError(
                                                        'error');
                                                  }
                                                },
                                                child: TextButton(
                                                  onPressed: () {
                                                    log("item.status=====${item.id}");
                                                    context
                                                        .read<TaskStatusCubit>()
                                                        .taskStatusCubit(
                                                          userId: userId!,
                                                          taskIds: item.id
                                                              .toString(),
                                                          status: item.status! ==
                                                                  "Awaiting"
                                                              ? "Pending"
                                                              : item.status! ==
                                                                      "Pending"
                                                                  ? "Done" : "Cancelled",
                                                                  // : item.status! ==
                                                                  //         "In Process"
                                                                  //     ? 'Done'
                                                                  //     : 'Cancelled',
                                                          item: item,
                                                          context: context,
                                                        );
                                                  },
                                                  child: const Text('OK'),
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
                                } else {
                                  easyLoadingShowError(
                                      'This action is restricted. Only the admin has the permission to make changes.');
                                }
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
                                          title: const Text('Confirm Action'),
                                          content: const Text(
                                              'Are you sure you want to mark this task as done?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                // Close the dialog
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel'),
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
                                                  log("item.status=====${item.id}");
                                                  context
                                                      .read<TaskStatusCubit>()
                                                      .taskStatusCubit(
                                                        userId: userId!,
                                                        taskIds:
                                                            item.id.toString(),
                                                        status: item.status! ==
                                                                "Awaiting"
                                                            ? "Pending"
                                                            : item.status! ==
                                                                    "Pending"
                                                                ? "Done"
                                                                :'Cancelled',
                                                    // : item.status! ==
                                                    //         "In Process"
                                                    //     ? 'Done'
                                                    //     : 'Cancelled',
                                                        item: item,
                                                        context: context,
                                                      );
                                                },
                                                child: const Text('OK'),
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
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                item.status!,
                                style: const TextStyle(
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
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              icon: const Icon(Icons.logout),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
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
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select None Status',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: listStatus.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: StatefulBuilder(builder: (buildContext,
                                  void Function(void Function())
                                      setStateDropdown) {
                                bool isSelected = context
                                    .read<TaskListCubit>()
                                    .currentStatues
                                    .contains(item);

                                return InkWell(
                                  onTap: () {
                                    if (item == "Select All") {
                                      if (context
                                          .read<TaskListCubit>()
                                          .currentStatues
                                          .contains(item)) {
                                        context
                                            .read<TaskListCubit>()
                                            .currentStatues
                                            .remove("Select All");
                                      } else {
                                        context
                                            .read<TaskListCubit>()
                                            .currentStatues = [
                                          'Select All',
                                          'Awaiting',
                                          // 'In Process',
                                          'Pending',
                                          'Done',
                                          'Cancelled',
                                          // 'On Hold',
                                        ];
                                      }
                                      Navigator.pop(context);
                                    } else {
                                      if (isSelected) {
                                        context
                                            .read<TaskListCubit>()
                                            .currentStatues
                                            .remove(item);
                                      } else {
                                        context
                                            .read<TaskListCubit>()
                                            .currentStatues
                                            .add(item);
                                      }
                                    }
                                    setStateDropdown(() {});
                                    setState(() {});
                                    context
                                        .read<TaskListCubit>()
                                        .pagingController
                                        .refresh();
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          isSelected
                                              ? Icons.check_box_outlined
                                              : Icons.check_box_outline_blank,
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          }).toList(),
                          value: context
                                  .read<TaskListCubit>()
                                  .currentStatues
                                  .isEmpty
                              ? null
                              : context
                                  .read<TaskListCubit>()
                                  .currentStatues
                                  .last,
                          onChanged: (_) {},
                          selectedItemBuilder: (context) {
                            return listStatus.map((item) {
                              return Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  context
                                      .read<TaskListCubit>()
                                      .currentStatues
                                      .join(', '),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              );
                            }).toList();
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(left: 16, right: 8),
                            height: 40,
                            width: 140,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  userRole == 'admin'
                      ? Expanded(
                          child: _listenerDrop(),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: _listener())
            ],
          ),
        ));
  }

  Widget _listenerDrop() {
    final state = context.watch<DropdownCubit>().state;
    if (state is DropdownLoading) {
      return Container(
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: null,
            isExpanded: true,
            hint: Text(
              'Select None User',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: [],
            onChanged: (String? value) {},
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(left: 16, right: 8),
              height: 40,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );
    } else if (state is DropdownError) {
      return Center(
        child: Text(state.message),
      );
    } else if (state is DropdownSuccess) {
      return DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              assignName.isNotEmpty
                  ? assignName.join(', ')
                  : 'Select None User',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).hintColor,
                  overflow: TextOverflow.ellipsis),
            ),
            items: state.users!.map((status) {
              return DropdownMenuItem(
                value: status.fullName,
                child: StatefulBuilder(
                  builder: (buildContext,
                      void Function(void Function()) setStateDropdown) {
                    bool isSelected =
                        currentAssign.contains(int.parse(status.id.toString()));

                    return InkWell(
                      onTap: () {
                        if (isSelected) {
                          currentAssign.remove(int.parse(status.id.toString()));
                          assignName.remove(status.fullName);
                        } else {
                          currentAssign.add(int.parse(status.id.toString()));
                          assignName.add(status.fullName ?? "");
                        }
                        setStateDropdown(() {});
                        setState(() {});
                        context
                            .read<TaskListCubit>()
                            .pagingController
                            .refresh();
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(
                              isSelected
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                status.fullName ?? '',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            onChanged: (_) {},
            // selectedItemBuilder: (context) {
            //   return [
            //     Container(
            //       alignment: AlignmentDirectional.center,
            //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //       child: Text(
            //         assignName.isNotEmpty
            //             ? assignName.join(', ')
            //             : 'Select None User',
            //         style: const TextStyle(
            //           fontSize: 14,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         maxLines: 1,
            //       ),
            //     ),
            //   ];
            // },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(left: 16, right: 8),
              height: 40,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
