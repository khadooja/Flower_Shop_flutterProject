import 'package:flutter/material.dart';
import 'package:gift_planner/utils/design_components.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  _SplashScreensState createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  PageController _pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 50.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زر الرجوع يظهر فقط في الصفحات 2 و 3
                if (currentPage > 0)
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppStyles.textStyle),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  )
                else
                  const SizedBox(width: 48), // مساحة فارغة عند الصفحة الأولى

                // زر Skip يظهر دائمًا
                TextButton(
                  onPressed: () {
                    // الانتقال إلى الشاشة الأخيرة عند الضغط على Skip
                    _pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Color.fromARGB(166, 17, 16, 16)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              children: [
                buildPage(
                  imagePath: 'images/2.jpg',
                  title: 'Floral Elegance!',
                  description:
                      'Discover our exquisite flowers for all your occasions.',
                ),
                buildPage(
                  imagePath: 'images/onboarding1.png',
                  title: 'Quality That Makes a Difference',
                  description:
                      'We carefully select the finest flowers to ensure their beauty lasts longer. With us, you\'ll find flowers that exceed your expectations.',
                ),
                buildPage(
                  imagePath: 'images/onboarding2.png',
                  title: 'Ready to Begin Your Journey?',
                  description:
                      'Explore our wide range of flowers and gifts now! Just one click away from the beauty of nature.',
                ),
              ],
            ),
          ),
          // النقاط السفلية
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => buildDot(index, currentPage),
            ),
          ),
          const SizedBox(height: 20),
          // زر Next أو Get Started
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: () {
                if (currentPage < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  Navigator.pushReplacementNamed(context, '/signorlog');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStyles.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                currentPage == 2 ? 'Get Started' : 'Next',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildPage({String? imagePath, String? title, String? description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath!,
          height: 300,
        ),
        const SizedBox(height: 30),
        Text(
          title!,
          style: const TextStyle(
            fontSize: 24,
            color: AppStyles.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(110, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDot(int index, int currentIndex) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentIndex == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? AppStyles.primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
