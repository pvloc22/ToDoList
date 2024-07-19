import 'package:intl/intl.dart';

import 'package:to_do_list/index.dart';

class CalendarMonths extends StatefulWidget {
  const CalendarMonths({super.key});

  @override
  State<CalendarMonths> createState() => _CalendarMonthsState();
}

class _CalendarMonthsState extends State<CalendarMonths> {
  DateTime _today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _today = day;
      context.read<HomeBloc>().add(
          FetchDataTaskOfDayEvent(date: "${DateFormat.yMMMd().format(day)}"));
    });
  }

  void initState() {
    context.read<HomeBloc>().add(
        FetchDataTaskOfDayEvent(date: "${DateFormat.yMMMd().format(_today)}"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      // width: 300,
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kTextWhiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // màu của bóng
            spreadRadius: 5, // phân tán bóng
            blurRadius: 7, // độ mờ của bóng
            offset: Offset(0, 3), // vị trí của bóng
          ),
        ],
      ),
      child: TableCalendar(
        locale: 'en_US',
        rowHeight: 40,
        focusedDay: _today,
        firstDay: DateTime.utc(2020, 8, 4),
        lastDay: DateTime.utc(2030, 8, 4),
        headerStyle:
            HeaderStyle(formatButtonVisible: false, titleCentered: true),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(day, _today),
        onDaySelected: _onDaySelected,
      ),
    );
  }
}
