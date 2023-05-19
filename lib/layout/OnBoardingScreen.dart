import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/LoginCubit/LoginCubit.dart';
import 'package:shop_app/cacheHelper/CacheHelper.dart';
import 'package:shop_app/modules/login/LoginShopApp.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

Widget buildItemPageView({
  required String image,
  required String titleText,
  required String bodyText,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              image,
            ),
          ),
        ),
        Text(
          titleText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          bodyText,
          style: const TextStyle(
            fontSize: 20.0,
          ),
        ),
      ],
    );

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageViewController = PageController();

  bool isLast = false;

  List boarding = [
    buildItemPageView(
      image: 'assets/images/first.png',
      titleText: 'First Boarding',
      bodyText: 'Body of First Boarding',
    ),
    buildItemPageView(
      image: 'assets/images/second.png',
      titleText: 'Second Boarding',
      bodyText: 'Body of Second Boarding',
    ),
    buildItemPageView(
      image: 'assets/images/third.png',
      titleText: 'Third Boarding',
      bodyText: 'Body of Third Boarding',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              CacheHelper.saveData(key: 'onBoarding', value: true);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginShopApp()),
                    (route) => false,
              );
            },
            child: const Text(
                'SKIP',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    if (index == boarding.length - 1) {
                      isLast = true;
                    } else {
                      isLast = false;
                    }
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => boarding[index],
                itemCount: boarding.length,
                controller: pageViewController,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageViewController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 12.0,
                    dotWidth: 12.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (isLast) {
                        CacheHelper.saveData(key: 'onBoarding', value: true);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginShopApp()),
                              (route) => false,
                        );
                      }
                    });
                    pageViewController.nextPage(
                      duration: const Duration(
                        seconds: 1,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
