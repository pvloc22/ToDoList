import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/index.dart';
import 'package:to_do_list/screens/all_tasks_screen.dart';
import 'package:to_do_list/screens/calendar_screen.dart';

void main() async {
  // Đảm bảo rằng tất cả dữ liệu đã được tạo hết
  WidgetsFlutterBinding.ensureInitialized();
  // Tạo biến với mục tiêu kiểm tra ứng đụng đã đăng nhập lần đầu chưa
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  // Build app
  runApp(MyApp(
    onboarding: onboarding,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onboarding});
  final bool onboarding;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.getFont(kDefaultFontFamily).fontFamily,
          scaffoldBackgroundColor: kBackgroundColor,
          useMaterial3: true,
        ),
        initialRoute: !onboarding ? '/start' : '/home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/start':
              return MaterialPageRoute(
                  builder: (context) => const BeginScreen());
            case '/home':
              return MaterialPageRoute(
                  builder: (context) => const HomeScreen());
            case '/calendar':
              return MaterialPageRoute(
                  builder: (context) => const CalendarScreen());
            case '/allTasks':
              return MaterialPageRoute(
                  builder: (context) => const AllTasksScreen());
            default:
              return null;
          }
        },
      ),
    );
  }
}
