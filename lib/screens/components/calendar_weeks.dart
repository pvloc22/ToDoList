import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/index.dart';

class CalendarWeeks extends StatefulWidget {
  const CalendarWeeks({super.key});

  @override
  State<CalendarWeeks> createState() => _CalendarWeeksState();
}

class _CalendarWeeksState extends State<CalendarWeeks> {
  final CalendarWeekController _controller = CalendarWeekController();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: kTextWhiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), // màu của bóng
              spreadRadius: 5, // phân tán bóng
              blurRadius: 5, // độ mờ của bóng
              offset: Offset(0, 0), // vị trí của bóng
            ),
          ],
        ),
        child: CalendarWeek(
          controller: _controller,
          height: 110,
          showMonth: true,
          minDate: DateTime.now().add(
            Duration(days: -365),
          ),
          maxDate: DateTime.now().add(
            Duration(days: 365),
          ),

          onDatePressed: (DateTime datetime) {
            context.read<HomeBloc>().add(FetchDataTaskOfDayEvent(
                date: "${DateFormat.yMMMd().format(datetime)}"));
          },
          monthViewBuilder: (DateTime time) => Align(
            alignment: FractionalOffset.center,
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMM().format(time),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w600),
                )),
          ),

          /*Custom SATURDAY, SUNDAY*/
          weekendsStyle:
              TextStyle(color: Colors.red, fontWeight: FontWeight.bold),

          /*Custom MONDAY... FRIDAY*/
          dayOfWeekStyle: TextStyle(
              fontSize: 10, color: kTextColorBold, fontWeight: FontWeight.bold),
          // dayShapeBorder: BoxShape.circle,

          /*Custom pressing*/
          pressedDateBackgroundColor: Colors.blue.withOpacity(0.5),
          pressedDateStyle:
              TextStyle(fontWeight: FontWeight.bold, color: kTextWhiteColor),

          /*Custom today*/
          todayBackgroundColor: Colors.lightBlue,
          todayDateStyle:
              TextStyle(color: kTextWhiteColor, fontWeight: FontWeight.bold),
          decorations: [
            DecorationItem(
                decorationAlignment: FractionalOffset.bottomCenter,
                date: DateTime.now(),
                decoration: Container(
                  // margin: EdgeInsets.only(top: 20),
                  child: Icon(
                    Icons.horizontal_rule,
                    color: Colors.blue,
                    // size: ,
                  ),
                )
                // decoration: Icon(
                //   Icons.today,
                //   color: Colors.blue,
                // )
                ),
          ],
        ));
  }
}
