import 'package:flutter/material.dart';

import '../constant.dart';

class AppbarCalendar extends StatefulWidget implements PreferredSizeWidget {
  final void Function(String) onPressed;

  const AppbarCalendar({super.key, required this.onPressed});

  @override
  State<AppbarCalendar> createState() => _AppbarCalendarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarCalendarState extends State<AppbarCalendar> {
  String? _selectedValue = 'Week';

void dropDownCallBack(String? selectedValue){
  if(selectedValue is String){
    setState(() {
      _selectedValue = selectedValue;
      widget.onPressed(_selectedValue!);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Calendar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),


          DropdownButton(
              value: _selectedValue,
              dropdownColor: kTextWhiteColor,
              // padding: EdgeInsets.all(kDefaultPadding),
              underline:  Container(),
              iconSize: 40,
              items: const [
                DropdownMenuItem<String>(
                  child: Text('Week', style: TextStyle(fontWeight: FontWeight.bold),),
                  value: 'Week',
                ),
                DropdownMenuItem<String>(
                  child: Text('Month', style: TextStyle(fontWeight: FontWeight.bold)),
                  value: 'Month',
                ),
              ],
              onChanged: dropDownCallBack,
          )
        ],
      ),
      backgroundColor: kTextWhiteColor,
      automaticallyImplyLeading: false,
    );
    ;
  }
}
