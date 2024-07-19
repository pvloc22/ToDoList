import 'package:to_do_list/index.dart';

class SearchBarComponent extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final String keySearch;
  final int index;
  final VoidCallback onChange;

  const SearchBarComponent(
      {super.key,
      required this.controller,
      required this.placeholder,
      required this.onChange,
      required this.keySearch,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 1.5),
      color: kButtonColor,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          onChange();
        },
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: IconButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/search_task_screen') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchTaskScreen(
                              indexScreen: index,
                              keySearch: controller.text,
                            ),
                        settings: const RouteSettings(
                            name: '/search_task_screen')));
                // context.read<HomeBloc>().add(SearchTaskEvent(keySearch: keySearch));
              }
              else{
                context.read<HomeBloc>().add(SearchTaskEvent(keySearch: controller.text));
              }
            },
            icon: Icon(Icons.search,
                color: Theme.of(context).colorScheme.onSurface),
          ),
          hintText: placeholder,
          hintStyle: TextStyle(
              fontSize: 15, color: Theme.of(context).colorScheme.onSurface),
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
      ),
    );
  }
}
