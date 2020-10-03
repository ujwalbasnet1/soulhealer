import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/core/navigation/routes.gr.dart';
import 'package:soulhealer/di/injection.dart';

class OnboardingView extends StatefulWidget {
  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/backgroud.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "Having a Hard Times",
              body: "We are here to help you!! ",
              image: Container(
                padding: const EdgeInsets.fromLTRB(50, 150, 50, 0),
                child: Image.asset(
                  'assets/images/undraw_thoughts_e49y 1.png',
                ),
              ),
            ),
            PageViewModel(
              title: "Need Councelling",
              body: 'Talk with our exports ',
              image: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                padding: const EdgeInsets.fromLTRB(50, 90, 10, 0),
                child: Image.asset(
                  'assets/images/undraw_conversation_h12g 1.png',
                ),
              ),
            ),
            PageViewModel(
              title: "Need some Resfreshments",
              bodyWidget: Container(
                width: 260,
                child: Text(
                  "Listen some refreshing music and read some quotes",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              image: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                padding: const EdgeInsets.fromLTRB(50, 90, 10, 0),
                child: Image.asset(
                  'assets/images/undraw_refreshing_ncum 1.png',
                ),
              ),
            ),
          ],
          onDone: () {
            injection<NavigationService>().navigateToRoute(
              Routes.loginRoute,
              clearStack: true,
            );
          },
          done: Container(
            // height: 42,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(48),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's Go",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
          next: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(Icons.arrow_forward, color: Colors.white),
          ),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.white54,
            activeColor: Colors.white,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
