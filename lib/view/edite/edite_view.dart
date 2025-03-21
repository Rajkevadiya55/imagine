import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:imagine/cubit/create_task/create_task_cubit.dart';
import 'package:imagine/cubit/dropdown/dropdown_cubit.dart';
import 'package:imagine/model/task_list/task_list_res_model.dart';
import 'package:imagine/router/app_router.dart';
import 'package:imagine/widget/app_easy_loading.dart';
import 'package:imagine/widget/common_text.dart';
import 'package:intl/intl.dart';

import '../../helper/helper.dart';

class EditeView extends StatefulWidget {
  //final Map<String, dynamic> data;
  Data data;

  EditeView({super.key, required this.data});

  @override
  State<EditeView> createState() => _EditeViewState();
}

class _EditeViewState extends State<EditeView> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  TextEditingController deliveryDateCon = TextEditingController();
  TextEditingController descCon = TextEditingController();
  TextEditingController noteCon = TextEditingController();
  TextEditingController jobNoCon = TextEditingController();
  TextEditingController billNoCon = TextEditingController();
  TextEditingController billAmountCon = TextEditingController();
  TextEditingController uploadCon = TextEditingController();
  String _selectedPriority = 'Medium';
  String? _selectedStatus; // Default value for the dropdown
  String? _selectedUsername; // Default value for the dropdown
  String? _selectedUserId; // Default value for the dropdown

  var imagePath;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.data.status;
    fetchAllPartyName();
    fetchControllerData();
  }

  fetchAllPartyName() {
    context.read<DropdownCubit>().fetchPartyName();
  }

  fetchControllerData() {
    print("widget.data.jobNumber${widget.data.jobNumber}");
    nameCon = TextEditingController(text: widget.data.partyName);
    descCon = TextEditingController(text: widget.data.description);
    dateCon = TextEditingController(text: widget.data.taskDate);
    deliveryDateCon = TextEditingController(text: widget.data.deliveryDate);
    noteCon = TextEditingController(text: widget.data.note);
    jobNoCon = TextEditingController(text: widget.data.jobNumber);
    billNoCon = TextEditingController(text: widget.data.billNo);
    billAmountCon = TextEditingController(text: widget.data.billAmount);
    uploadCon = TextEditingController(text: widget.data.taskFilename);
    _selectedUsername = widget.data.assignedTo;
    _selectedUserId = widget.data.assignTo;
  }

  Widget _listener() {
    final state = context.watch<DropdownCubit>().state;
    if (state is DropdownLoading) {
      return _autoSearchField(partyName: []);
    } else if (state is DropdownError) {
      return _autoSearchField(partyName: []);
    } else if (state is DropdownSuccess) {
      return _autoSearchField(partyName: state.data ?? []);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _listenerDrop() {
    final state = context.watch<DropdownCubit>().state;
    if (state is DropdownLoading) {
      return Container(
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedUsername,
            isExpanded: true,
            items: [],
            onChanged: (String? value) {},
          ),
        ),
      );
    } else if (state is DropdownError) {
      return _autoSearchField(partyName: []);
    } else if (state is DropdownSuccess) {
      return Container(
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedUserId,
            isExpanded: true,
            hint: Text(
              _selectedUsername.toString(),
              style: TextStyle(color: Colors.black),
            ),
            items: state.users!.map((status) {
              return DropdownMenuItem<String>(
                value: status.id,
                child: Text(
                  status.fullName.toString(),
                  style: TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (value) {
              print('valuevaluevalue$value');
              setState(() {
                _selectedUsername = value;
                _selectedUserId = value;
              });
            },
            // onChanged: (value) {
            //   setState(() {
            //     _selectedStatus = value!;
            //   });
            // },
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  List<String> getFilteredStateList(
      {required String query, required List<String> partyName}) {
    List<String> matches = [];
    matches.addAll(partyName);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Widget _autoSearchField({required List<String> partyName}) {
    return TypeAheadField(
      controller: nameCon,
      builder: (context, controller, focusNode) => Container(
        child: TextField(
            cursorColor: Colors.black,
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              hintText: 'Party Name',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.black),
              ),
            )),
      ),
      decorationBuilder: (context, child) => DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
        ),
        child: child,
      ),
      itemBuilder: (context, String suggestion) {
        ///list item builder
        return CupertinoListTile(
          title: CustomText(text: suggestion, fontSize: 16),
        );
      },
      suggestionsCallback: (value) {
        /// returning filtered list
        return getFilteredStateList(query: value, partyName: partyName);
      },
      onSelected: (String value) {
        setState(() {
          nameCon = TextEditingController(text: value);
          nameCon.text = value;
          // countryCon.text = value;
          // findCountryIdByName(value);
        });
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Earliest selectable date.
      lastDate: DateTime(2100), // Latest selectable date.
    );

    if (selectedDate != null) {
      setState(() {
        // Format the date and set it to the TextField controller.
        dateCon.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectDeliveryDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Earliest selectable date.
      lastDate: DateTime(2100), // Latest selectable date.
    );

    if (selectedDate != null) {
      setState(() {
        // Format the date and set it to the deliveryDateCon controller.
        deliveryDateCon.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> statuses = [
      'Pending',
      'In Process',
      'Done',
      'Cancelled',
      'Awaiting'
    ];

    // Ensure the default value is valid
    if (!statuses.contains(_selectedStatus)) {
      _selectedStatus = null; // Set to null if invalid
    }
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Edit Task"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            _listener(),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateCon,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Task date',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: deliveryDateCon,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    onTap: () {
                      _selectDeliveryDate(context); // Open date picker
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Delivery date',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: descCon,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: 'Task description',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: noteCon,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: 'Note',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: jobNoCon,
                    keyboardType: TextInputType.number,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Job no',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: TextField(
                    controller: billNoCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Bill no ',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: TextField(
                    controller: billAmountCon,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Bill amount',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null && result.files.isNotEmpty) {
                    String fileName = result.files.single.name;
                    setState(() {
                      uploadCon.text = fileName;
                      imagePath = result.files.single.path!;
                    });
                  } else {
                    setState(() {
                      uploadCon.text = '';
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        uploadCon.text.isEmpty ? 'Upload File' : uploadCon.text,
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.upload, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 13,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Priority *",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'Medium',
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    Text(
                      'Medium',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Radio<String>(
                      value: 'High',
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    Text(
                      'High',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Low',
                      groupValue: _selectedPriority,
                      onChanged: (value) {
                        setState(() {
                          _selectedPriority = value!;
                        });
                      },
                    ),
                    Text(
                      'Low',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                userRole == 'admin'
                    ? Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status *",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 42,
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedStatus,
                                  isExpanded: true,
                                  items: statuses.map((status) {
                                    return DropdownMenuItem<String>(
                                      value: status,
                                      child: Text(status,
                                          style:
                                              TextStyle(color: Colors.black)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedStatus = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(width: 10),

                // Spacing between the two dropdowns
                if (_selectedUsername != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Other Assign *",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        _listenerDrop()
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            BlocListener<CreateTaskCubit, CreateTaskState>(
              listener: (context, state) {
                if (state is CreateTaskLoading) {
                  easyLoadingShowProgress(status: "Please Wait...");
                } else if (state is CreateTaskSuccess) {
                  easyLoadingShowSuccess(state.message);
                  AppRouter.navigatorKey.currentState
                      ?.pushNamed(AppRouter.dashboard);
                } else if (state is CreateTaskError) {
                  easyLoadingShowError(state.message);
                }
              },
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  print("nameCon ${nameCon.text}");
                  print("dateCon ${dateCon.text}");
                  print("descCon ${descCon.text}");
                  print("_selectedPriority ${_selectedPriority}");
                  print("noteCon ${noteCon.text}");
                  print("billNoCon ${billNoCon.text}");
                  print("jobNoCon ${jobNoCon.text}");
                  print("billAmountCon ${billAmountCon.text}");
                  print("deliveryDateCon ${deliveryDateCon.text}");
                  print("uploadCon ${uploadCon.text}");
                  print("id ${widget.data.id}");
                  print("statusss ${widget.data.status}");
                  print("imagepath ${imagePath}");
                  print("_selectedStatus ${_selectedStatus}");
                  print("userIduserId ${widget.data.userId}");
                  context.read<CreateTaskCubit>().createTaskCubit(
                      partyName: nameCon.text,
                      taskDate: dateCon.text,
                      description: descCon.text,
                      priority: _selectedPriority,
                      note: noteCon.text,
                      billNo: billNoCon.text,
                      billAmount: billAmountCon.text,
                      deliveryDate: deliveryDateCon.text,
                      status: _selectedStatus ?? '',
                      taskFile: imagePath ?? '',
                      id: widget.data.id,
                      assignTo: _selectedUserId ?? '',
                      jobNo: jobNoCon.text,
                      isCreate: false);
                },
                child: Container(
                  height: 45,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Center(
                    child: const Text(
                      textAlign: TextAlign.center,
                      'Update',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
