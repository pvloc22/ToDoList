import 'dart:async';

import 'package:to_do_list/index.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  late bool isAction;
  final Task? task;

  AddTaskScreen({super.key, required this.isAction, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleTask = TextEditingController();
  late TextEditingController _shortDescriptionTask = TextEditingController();
  late TextEditingController _descriptionTask = TextEditingController();

  List<String> listRepeat = <String>['None', 'Daily', 'Weekly', 'Monthly'];

  List<String> listReminder = <String>['15 min', '30 min', '45 min', '1 day'];

  late String dropdownValue = widget.task?.reminder?? listReminder.first;
  late String colortask = widget.task?.color ?? Colors.red.toString().split('(0x')[1].split(')')[0];

  String _selectedOption = 'None';
  TimeOfDay _selectedTime = new TimeOfDay.now();
  late DateTime? _setDueDate;
  late int _currentValue;
  late int _selectedIndex;
  String dateChooseFromUser = "";
  late DateTime _selectedDate = DateTime.now();

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      initialDate: DateTime.now(),

      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
      // initialDate: DateTime.now(),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      dateChooseFromUser = DateTime.now().toString();
    }
  }

  _getTimeFromUser() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: _selectedTime,
    );
    if (timeOfDay != null) {
      setState(() {
        _selectedTime = timeOfDay;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: const TimeOfDay(hour: 9, minute: 0));
  }

  String titleAppBar = "Add Task";
  String titleButtonAppBar = "";
  bool checkActionButton = false;
  bool isAddTask = false;
  bool isDetailsTask = false;
  bool isEditTask = false;

  @override
  void initState() {
    // print(widget.task!.dateCreated);
    // _selectedDate = DateFormat.yMMMd().parse(widget.task!.dateCreated != null? widget.task!.dateCreated: '');
    _selectedIndex = listRepeat.indexOf(widget.task!.repeatTask ?? 'None');
    _currentValue = 0;
    if (widget.isAction) {
      isAddTask = true;
    } else {
      isDetailsTask = true;
    }
    !widget.isAction
        ? _titleTask.text = widget.task!.title.toString()
        : _titleTask.text = "";
    !widget.isAction
        ? _shortDescriptionTask.text = widget.task!.shortDescription.toString()
        : _shortDescriptionTask.text = "";
    !widget.isAction
        ? _descriptionTask.text = widget.task!.longDescription.toString()
        : _descriptionTask.text = "";
    widget.isAction ? checkActionButton = true : checkActionButton = false;

    super.initState();
  }

  String? validateTitle(String value) {
    if (value.isEmpty) {
      return "*Please input a title";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            isAddTask
                ? "Add Task"
                : isDetailsTask
                    ? "Detail Task"
                    : "Edit Task",
            style: const TextStyle(
                fontWeight: FontWeight.w900, fontFamily: kDefaultFontFamily),
          )),
          elevation: 2.0,
          backgroundColor: Colors.white,
          shadowColor: kButtonBottomColor.withOpacity(0.5),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle the action for the icon button here
              print('Settings icon pressed');
              Navigator.pop(context);
            },
          ),
          actions: [
            isAddTask
                ? const SizedBox(
                    width: kDefaultPadding * 3,
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        //Edit task
                        if (isDetailsTask) {
                          isDetailsTask = false;
                          checkActionButton = true;
                          widget.isAction = true;
                        } else {
                          checkActionButton = false;
                          widget.isAction = false;
                          // check information empty
                          int? id = widget.task!.id;
                          Task newTask = Task(
                              id: id,
                              title: _titleTask.text,
                              shortDescription: _shortDescriptionTask.text,
                              dateCreated:
                                  DateFormat.yMMMd().format(_selectedDate),
                              timeCreated:
                                  "${_selectedTime.hour.toString().padLeft(2, '0')}: ${_selectedTime.minute.toString().padLeft(2, '0')} ",
                              longDescription: _descriptionTask.text,
                              repeatTask: listRepeat[_selectedIndex],
                              reminder: dropdownValue,
                              color: colortask,
                              isCompleted: false);
                          context.read<HomeBloc>().add(UpdateTaskEvent(task: newTask));
                          Navigator.pop(context);
                        }
                      });
                    },
                    child: Text(
                      checkActionButton ? 'Save' : 'Edit',
                      style: const TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  )
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: IgnorePointer(
              ignoring: widget.isAction ? false : true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTextColorRegular),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  TextField(
                    controller: _titleTask,
                    onChanged: (value) {
                      _titleTask.text = value;
                    },
                    decoration: InputDecoration(
                        errorText: validateTitle(_titleTask.text),
                        errorStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kBorderButtonColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kBorderButtonColor,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kBorderButtonColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kBorderButtonColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Add title task',
                        filled: true,
                        fillColor: kButtonColor),
                    cursorColor: kPrimaryColor,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  const Text(
                    "Short Description",
                    style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTextColorRegular),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  TextField(
                    controller: _shortDescriptionTask,
                    onChanged: (value) {
                      _shortDescriptionTask.text = value;
                    },
                    decoration: InputDecoration(
                        errorText: validateTitle(_shortDescriptionTask.text),
                        errorStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kBorderButtonColor,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: kBorderButtonColor,
                            )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kBorderButtonColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kBorderButtonColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Add title task',
                        filled: true,
                        fillColor: kButtonColor),
                    cursorColor: kPrimaryColor,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  const Text(
                    'Color',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                    child: Row(
                      children: [
                        MaterialColorPicker(
                          onColorChange: (Color color) {
                            // Handle color changes
                          },
                          onMainColorChange: (value) {
                            String valueString = value.toString();
                            colortask = valueString.split('(0x')[1].split(')')[0];
                            print(colortask);
                          },
                          circleSize: 25,
                          allowShades: false,
                          spacing: 5,
                          elevation: 1,
                          selectedColor: widget.task!.color != null? Color(int.parse(widget.task!.color!, radix: 16)) : Colors.red,
                          colors: const [
                            Colors.red,
                            Colors.cyan,
                            Colors.blue,
                            Colors.yellow,
                            Colors.orange,
                            Colors.green,
                            Colors.purple
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  const Text(
                    'Date',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _getDateFromUser();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.orange,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.02,
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      _getTimeFromUser();
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.02,
                        ),
                        Text(
                          "${_selectedTime.hour.toString().padLeft(2, '0')}: ${_selectedTime.minute.toString().padLeft(2, '0')} ",
                          style: const TextStyle(
                              fontFamily: kDefaultFontFamily,
                              fontWeight: FontWeight.w600,
                              color: kTextColorDescription),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  const Text(
                    'Repeat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                    child: Row(
                      children: [
                        Wrap(
                          children: List<Widget>.generate(4, (int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _selectedIndex == index
                                        ? const Icon(
                                            Icons.circle_rounded,
                                            color: kPrimaryColor,
                                          )
                                        : const Icon(
                                            Icons.circle_outlined,
                                            color: kPrimaryColor,
                                          ),
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.02,
                                    ),
                                    Text(
                                      listRepeat[index],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  const Text(
                    "Reminder",
                    style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTextColorRegular),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: DropdownMenu(
                      width: MediaQuery.sizeOf(context).width * 0.94,
                      initialSelection: widget.task!.reminder ?? listReminder.first,
                      onSelected: (value) {
                        setState(() {
                          dropdownValue = value!;
                          print("dropdownValue ${dropdownValue}");
                        });
                      },
                      dropdownMenuEntries: listReminder
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  const Text(
                    "Note",
                    style: TextStyle(
                        fontFamily: kDefaultFontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kTextColorRegular),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.01,
                  ),
                  TextFormField(
                    controller: _descriptionTask,
                    onChanged: (value) {
                      // onChange();
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: kButtonColor,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: kBorderButtonColor,
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kBorderButtonColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    minLines: 5,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                  !isAddTask
                      ? const SizedBox()
                      : Container(
                          // margin: EdgeInsets.only(top: kDefaultPadding),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              //To build object structure of task
                              int id = new DateTime.now().millisecondsSinceEpoch;
                              Task newTask = new Task(
                                  id: id,
                                  title: _titleTask.text,
                                  shortDescription: _shortDescriptionTask.text,
                                  dateCreated:
                                  DateFormat.yMMMd().format(_selectedDate),
                                  timeCreated:
                                  "${_selectedTime.hour.toString().padLeft(2, '0')}: ${_selectedTime.minute.toString().padLeft(2, '0')} ",
                                  longDescription: _descriptionTask.text,
                                  repeatTask: listRepeat[_selectedIndex],
                                  reminder: dropdownValue,
                                  color: colortask,
                                  isCompleted: false);

                              context.read<HomeBloc>().add(AddTaskEvent(task: newTask));
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 15),
                              backgroundColor: kBorderButtonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              'CREATE TASK',
                              style: TextStyle(
                                  color: kTextWhiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
