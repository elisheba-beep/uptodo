import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uptodo/features/widgets/uptodo_button.dart';
import 'package:uptodo/features/intro/page_details.dart';
import 'package:uptodo/features/intro/start_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  late PageController pageViewController;

  List<PageDetails> pageDetails = [
    PageDetails(
      'assets/images/onboarding1.svg',
      'Manage your tasks',
      'You can easily manage all of your daily tasks in DoMe for free',
    ),
    PageDetails(
      'assets/images/onboarding2.svg',
      'Create daily routine',
      'In Uptodo  you can create your personalized routine to stay productive',
    ),
    PageDetails(
      'assets/images/onboarding3.svg',
      'Orgonaize your tasks',
      'You can organize your daily tasks by adding your tasks into separate categories',
    ),
  ];

  void updatePageIndex(int index) {
    pageViewController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        foregroundColor: Colors.white,

        elevation: 0,
        leadingWidth: 80,
        leading: UpToDoButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StartScreen()),
            );
          },
          backgroundColour: Color(0xff121212),
          text: 'SKIP',
          textColour: Color(0xff7a7a7a),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                controller: pageViewController,
                itemCount: pageDetails.length,
                itemBuilder: (context, index) => Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        SvgPicture.asset(pageDetails[index].image, height: 251),
                        SizedBox(height: 50),
                        SmoothPageIndicator(
                          controller: pageViewController,
                          count: pageDetails.length,
                          effect: SlideEffect(
                            dotWidth: 24.0,
                            dotHeight: 4.0,
                            offset: 24,
                            spacing: 4,
                            dotColor: Color(0xffAFAFAF),
                            activeDotColor: Colors.white,
                            radius: 2.0,
                          ),
                        ),
                        SizedBox(height: 50),

                        Text(
                          pageDetails[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          textAlign: TextAlign.center,
                          pageDetails[index].subtitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UpToDoButton(
                    text: 'BACK',
                    textColour: currentIndex == 0
                        ? Color(0xff7a7a7a)
                        : Colors.white,
                    backgroundColour: currentIndex == 0
                        ? Color(0xff121212)
                        : Color(0xff8875FF),
                    onPressed: () {
                      if (currentIndex == 0) {
                        return;
                      }
                      updatePageIndex(currentIndex - 1);
                    },
                  ),

                  UpToDoButton(
                    onPressed: () {
                      if (currentIndex == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartScreen(),
                          ),
                        );
                      }
                      updatePageIndex(currentIndex + 1);
                    },
                    text: currentIndex == 2 ? 'GET STARTED' : 'NEXT',
                    textColour: Colors.white,
                    backgroundColour: Color(0xff8875FF),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
