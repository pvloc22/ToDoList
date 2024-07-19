import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_screen.dart';

import '../constant.dart';
import '../screens/all_tasks_screen.dart';
import '../screens/calendar_screen.dart';

class BottomNavigatorBarTodolist extends StatefulWidget{
  final int initIndex;

  const BottomNavigatorBarTodolist({super.key, required this.initIndex});

  @override
  State<BottomNavigatorBarTodolist> createState() => _BottomNavigatorBarTodolistState();
}

class _BottomNavigatorBarTodolistState extends State<BottomNavigatorBarTodolist> {
  late int _selectedIndex;
  @override
  void initState(){
    super.initState();
    _selectedIndex = widget.initIndex;
  }
  void _onItemTapped(int index) {
    if(index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    switch(index){
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CalendarScreen()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AllTasksScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kTextWhiteColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_outlined),
            label: 'All Tasks',
          ),
        ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}