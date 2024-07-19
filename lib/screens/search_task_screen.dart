import 'package:to_do_list/screens/all_tasks_screen.dart';
import 'package:to_do_list/screens/calendar_screen.dart';

import '../index.dart';

class SearchTaskScreen extends StatefulWidget {
  const SearchTaskScreen(
      {super.key, required this.keySearch, required this.indexScreen});
  final int indexScreen;
  final String keySearch;
  @override
  State<SearchTaskScreen> createState() => _SearchTaskScreenState();
}

class _SearchTaskScreenState extends State<SearchTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.keySearch;
    context.read<HomeBloc>().add(SearchTaskEvent(keySearch: widget.keySearch));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Handle the action for the icon button here
                widget.indexScreen == 1
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()))
                    : widget.indexScreen == 2
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CalendarScreen()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AllTasksScreen()));
                // Navigator.pop(context);
              }),
          title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state)=> SearchBarComponent(
              index: 4,
              controller: _controller,
              keySearch: _controller.text,
              onChange: () {},
              placeholder: 'Search for Tasks, Events',
            ),),
          Text('Result',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
              )),
          SizedBox(
            height: kDefaultPadding / 2,
          ),
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            print('okSearch');
            switch (state.postStatus) {
              case PostStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case PostStatus.failure:
                return Center(child: Text("No tasks find"));
              case PostStatus.success:
                {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.listTodayTasks.length,
                        itemBuilder: (context, index) {
                          return ItemTask(
                            task: state.listTodayTasks[index],);
                        }),
                  );
                }
            }
          })
        ]),
      ),
    );
    ;
  }
}
