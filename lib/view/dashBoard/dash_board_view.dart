import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine/common/image_constant/image_constant.dart';
import 'package:imagine/cubit/create_task/create_task_cubit.dart';
import 'package:imagine/cubit/delete_task/delete_task_cubit.dart';
import 'package:imagine/cubit/dropdown/dropdown_cubit.dart';
import 'package:imagine/cubit/task_list/task_list_cubit.dart';
import 'package:imagine/cubit/task_status/task_status_cubit.dart';
import 'package:imagine/repositories/repository.dart';
import 'package:imagine/view/accept/accept_task.dart';
import 'package:imagine/view/complete/complete_task.dart';
import 'package:imagine/view/create/create_task.dart';
import 'package:imagine/view/home/home_view.dart';

class DashBoardView extends StatefulWidget {
  // String id;
  DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskListCubit(
              context.read<Repository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TaskStatusCubit(
              context.read<Repository>(),
            ),
          ),
          BlocProvider(
            create: (context) => DeleteTaskCubit(
              context.read<Repository>(),
            ),
          ),
          BlocProvider(
            create: (context) => DropdownCubit(context.read<Repository>()),
          ),
        ],
        child: HomeView(
            // id: widget.id
            )),
    // MultiBlocProvider(providers: [
    //   BlocProvider(
    //     create: (context) => TaskListCubit(
    //       context.read<Repository>(),
    //     ),
    //   ),
    //   BlocProvider(
    //     create: (context) => TaskStatusCubit(
    //       context.read<Repository>(),
    //     ),
    //
    //   ),
    //   BlocProvider(
    //     create: (context) => DeleteTaskCubit(
    //       context.read<Repository>(),
    //     ),
    //   ),
    // ], child: const InProcess()),
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => TaskListCubit(
          context.read<Repository>(),
        ),
      ),
      BlocProvider(
        create: (context) => TaskStatusCubit(
          context.read<Repository>(),
        ),
      ),
      BlocProvider(
        create: (context) => DeleteTaskCubit(
          context.read<Repository>(),
        ),
      ),
    ], child: const AcceptTask()),
    MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => TaskListCubit(
          context.read<Repository>(),
        ),
      ),
      BlocProvider(
        create: (context) => TaskStatusCubit(
          context.read<Repository>(),
        ),
      ),
      BlocProvider(
        create: (context) => DeleteTaskCubit(
          context.read<Repository>(),
        ),
      ),
    ], child: const CompleteTask()),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DropdownCubit(context.read<Repository>()),
        ),
        BlocProvider(
          create: (context) => CreateTaskCubit(context.read<Repository>()),
        ),
      ],
      child: CreateTask(),
    ),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': AppIcons.home, 'label': 'Home'},
    // {'icon': AppIcons.process, 'label': 'In Progress'},
    {'icon': AppIcons.accept, 'label': 'Awaiting'},
    {'icon': AppIcons.complate, 'label': 'Complete'},
  ];
  final List<String> end = <String>['ed', 'af', 'gk', 'tv'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Prevent FAB from moving
      body: _pages[_selectedIndex],
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          DropdownCubit(context.read<Repository>()),
                    ),
                    BlocProvider(
                      create: (context) =>
                          CreateTaskCubit(context.read<Repository>()),
                    ),
                  ],
                  child: CreateTask(),
                ),
              ),
            );

            // setState(() {
            //   _selectedIndex = 2;
            // });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: _navItems.length,
        tabBuilder: (int index, bool isActive) {
          final item = _navItems[index];
          final color = isActive ? Colors.blue : Colors.grey;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                item['icon'],
                color: color,
                height: 25,
              ),
              const SizedBox(height: 4),
              Text(
                item['label'],
                style: TextStyle(color: color, fontSize: 12),
              ),
            ],
          );
        },
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.none,
        // No gap to align items centrally
        notchSmoothness: NotchSmoothness.softEdge,

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
