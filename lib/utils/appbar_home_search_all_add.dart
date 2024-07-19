import 'package:flutter/material.dart';
import 'package:to_do_list/model/task_model.dart';

import '../constant.dart';
import '../screens/add_task_screen.dart';

class AppbarHomeSearchAllAddTask extends StatelessWidget
    implements PreferredSizeWidget {
  final bool canBack;
  final String title;
  final bool? isEdit;


  const AppbarHomeSearchAllAddTask(
      {super.key, required this.canBack, required this.title, this.isEdit});

  // final

  @override
  Widget build(BuildContext context) {

    return AppBar(
      leading: canBack?IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          // Handle the action for the icon button here
          print('Settings icon pressed');
          Navigator.pop(context);
        }
      ):null,
      title: Row(
        mainAxisAlignment:
            canBack ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),

          isEdit == null
              ? const SizedBox.shrink()
              : isEdit!
                  ? Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                border: Border.all(color: kBorderButtonColor),
                shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AddTaskScreen(
                          isAction: true,
                          task: Task(),
                        )));
              },
              icon: const Icon(
                Icons.add,
                color: kBorderButtonColor,
              ),
              iconSize: 12,
            ),
          )
                  : Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 12,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
        ],
      ),
      backgroundColor: kTextWhiteColor,
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
