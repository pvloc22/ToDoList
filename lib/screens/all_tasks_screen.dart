import 'package:to_do_list/index.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  final TextEditingController _controller = TextEditingController();
  void initState() {
    // Loading data from file
    context.read<HomeBloc>().add(LoadDataTask());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarHomeSearchAllAddTask(
        canBack: false,
        title: 'All Tasks',
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarComponent(
              index: 3,
              controller: _controller,
              keySearch: _controller.text,
              onChange: () {},
              placeholder: 'Search for Tasks, Events',
            ),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Results",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: kPrimaryColor),
                ),
                Container(
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
                              builder: (context) => AddTaskScreen(
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
              ],
            ),
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.listTodayTasks.length,
                    itemBuilder: (context, index) {
                      print('okAll');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemTask(task: state.listTodayTasks[index],),
                        ],
                      );
                    }),
              );
            })
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigatorBarTodolist(
        initIndex: 2,
      ),
    );
  }
}
