import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/index.dart';

class ItemTask extends StatefulWidget {
  const ItemTask({super.key, required this.task});

  final Task task;

  @override
  State<ItemTask> createState() => _ItemTaskState();
}

class _ItemTaskState extends State<ItemTask> {
  @override
  Widget build(BuildContext context) {
    String colorStr = widget.task.color!;
    int value = int.parse(colorStr, radix: 16);

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return SlidableAction(
              onPressed: (context) {
                context
                    .read<HomeBloc>()
                    .add(RemoveTaskEvent(task: widget.task));
              },
              icon: Icons.delete_forever,
              foregroundColor: Colors.red,
              backgroundColor: kTextWhiteColor,
              borderRadius: BorderRadius.circular(12),
            );
          })
        ],
      ),
      child: GestureDetector(
        onTap: () {
          if (!widget.task.isCompleted!) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddTaskScreen(isAction: false, task: widget.task)));
          }
        },
        child: Card(
          child: Container(
            padding: const EdgeInsets.only(
                top: kDefaultPadding / 2,
                bottom: kDefaultPadding / 2,
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: kTextWhiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        margin:
                            const EdgeInsets.only(right: kDefaultPadding / 2),
                        child:Checkbox(
                          value: widget.task.isCompleted,
                          // onChanged: onChanged,
                          activeColor: widget.task.isCompleted!
                              ? kTextLightColor
                              : Colors.black,
                          onChanged: (bool? value) {
                            setState(() {
                              widget.task.isCompleted = value ??
                                  false; // Cập nhật trạng thái của checkbox khi được thay đổi
                              context.read<HomeBloc>().add(
                                  CompletedTaskEvent(task: widget.task));
                            });
                          },
                          shape: const CircleBorder(),
                        )
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.task.title}',
                              style: TextStyle(
                                  color: widget.task.isCompleted!
                                      ? kTextLightColor
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${widget.task.shortDescription}',
                              style: TextStyle(
                                  color: widget.task.isCompleted!
                                      ? kTextLightColor
                                      : kTextColorDescription,
                                  fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.task.isCompleted!
                                  ? kTextLightColor
                                  : Color(value)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '${widget.task.timeCreated}',
                        style: TextStyle(
                            color: widget.task.isCompleted!
                                ? kTextLightColor
                                : Color(value),
                            fontSize: 10),
                      ),
                    ),
                    Text(
                      '${widget.task.dateCreated}',
                      style: TextStyle(
                          color: widget.task.isCompleted!
                              ? kTextLightColor
                              : Colors.blue,
                          fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
