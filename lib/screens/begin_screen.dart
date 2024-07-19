import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/index.dart';

class BeginScreen extends StatelessWidget {
  const BeginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool state = true;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('lib/assets/images/begin.png'),
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Simplify, Organize, and Conquer Your Day',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  fontFamily: kDefaultFontFamily),
            ),
            const Text(
              'Take control of your tasks and achieve your goals.',
              style: TextStyle(color: kTextColorDescription),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: MediaQuery.sizeOf(context).height * 0.06,
              child: ElevatedButton(
                  onPressed: () async {
                    final pres = await SharedPreferences.getInstance();
                    pres.setBool("onboarding", true);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 28),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  child: const Text(
                    "Lets Start",
                    style: TextStyle(
                        color: kTextWhiteColor, fontFamily: kDefaultFontFamily),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
