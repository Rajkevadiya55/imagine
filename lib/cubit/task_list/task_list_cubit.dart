import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/model/dropdown/dropdown_res_model.dart';
import 'package:imagine/model/task_list/task_list_req_model.dart';
import 'package:imagine/model/task_list/task_list_res_model.dart';
import 'package:imagine/repositories/repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final Repository authRepository;
  String searchValue = "";
  String startDate = "";
  String endDate = "";
  final int count = 10; // Number of items per page
  late PagingController<int, Data> pagingController; // Make it re-creatable
  List<String> currentStatues = [];
  List<Users> users = [];

  TaskListCubit(this.authRepository) : super(TaskListInitial()) {
    _initPagingController(); // Initialize PagingController
  }

  /// Initialize the PagingController with fresh settings
  void _initPagingController() {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, statuses: currentStatues);
    });
  }

  /// Initialize the Cubit for a specific status
  void init(
      {required String status,
      List<String>? selectedStatus,
      bool isFilter = false}) {
    // Reset state if the status changes
    if (isFilter) {
      currentStatues = selectedStatus ?? [];
      pagingController.dispose();
      _initPagingController();
    } else {
      currentAssign = [];
      currentStatues = [status];
      pagingController.dispose();
      _initPagingController();
    }

    startDate = "";
    endDate = "";
    searchValue = "";

    // Clear the item list to avoid stale data
    pagingController.itemList?.clear();
    pagingController.refresh();
  }

  void setSearch(String value) {
    searchValue = value; // Update search value
    pagingController.refresh(); // Refresh the task list
  }

  /// Set date filters and refresh the task list
  void setFilters({
    required String startDate,
    required String endDate,
  }) {
    this.startDate = startDate;
    this.endDate = endDate;
    pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey, {required List<String> statuses}) async {
    try {
      final start = (pageKey - 1) * count;
      log("currentAssign===================${currentAssign}"); // Calculate the start index for pagination
      final requestModel = TaskListReqModel(
        userId: userId,
        statuses: statuses,
        assignedTo: currentAssign,
        search: Search(value: searchValue),
        startDate: startDate,
        endDate: endDate,
        length: count,
        start: start,
      );

      final data = await authRepository.taskListRepo(requestModel);
      final items = data.data ?? [];
      if (items.isEmpty || items.length < count) {
        pagingController.appendLastPage(items);
      } else {
        pagingController.appendPage(items, pageKey + 1);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose(); // Dispose of the paging controller
    return super.close();
  }
}
