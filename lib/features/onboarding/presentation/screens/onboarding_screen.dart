import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uptodo/core/constant/app_colors.dart';
import 'package:uptodo/core/constant/navigation.dart';
import 'package:uptodo/core/constant/size_boxes.dart';
import 'package:uptodo/core/widgets/uptodo_button.dart';
import 'package:uptodo/features/onboarding/data/page_details_data.dart';
import 'package:uptodo/features/onboarding/presentation/screens/start_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  late PageController pageViewController;

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
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IntrinsicWidth(
            child: UpToDoButton(
              onPressed: () {
                context.pushTo(StartScreen());
              },
              backgroundColour: AppColors.backgroundColor,
              text: 'SKIP',
              textColour: AppColors.mediumDarkGray,
            ),
          ),
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
                        50.heightBox,
                        SmoothPageIndicator(
                          controller: pageViewController,
                          count: pageDetails.length,
                          effect: SlideEffect(
                            dotWidth: 24.0,
                            dotHeight: 4.0,
                            offset: 24,
                            spacing: 4,
                            dotColor: AppColors.mediumLightGray,
                            activeDotColor: AppColors.white,
                            radius: 2.0,
                          ),
                        ),
                        50.heightBox,
                        Text(
                          pageDetails[index].title,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        30.heightBox,
                        Text(
                          textAlign: TextAlign.center,
                          pageDetails[index].subtitle,
                          style: TextStyle(
                            color: AppColors.white,
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
                        ? AppColors.mediumDarkGray
                        : AppColors.white,
                    backgroundColour: currentIndex == 0
                        ? AppColors.backgroundColor
                        : AppColors.purple,
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
                        context.pushTo(StartScreen());
                      }
                      updatePageIndex(currentIndex + 1);
                    },
                    text: currentIndex == 2 ? 'GET STARTED' : 'NEXT',
                    textColour: AppColors.white,
                    backgroundColour: AppColors.purple,
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
