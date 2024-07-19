import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list/constant.dart';
import 'package:to_do_list/model/task_model.dart';

class ItemTaskToDo extends StatelessWidget {
  const ItemTaskToDo({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding - 5,
          bottom: kDefaultPadding - 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                // Icons.check_circle_rounded,
                Icons.circle_outlined,
                color: kCircleButtonColor,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Goofle projectprojectproject...",
                      style: TextStyle(
                          fontFamily: kDefaultFontFamily,
                          color: kTextColorBold,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(color: kTextColorDescription),
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                decoration: BoxDecoration(
                  border: Border.all(color: kTextColorRegular),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '10:00 AM',
                  style: GoogleFonts.getFont(
                    kDefaultFontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 1.2,
                    letterSpacing: -0.2,
                    color: Color(0xFFB8BABC),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '20/05/2024',
                style: TextStyle(color: kPrimaryColor, fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
