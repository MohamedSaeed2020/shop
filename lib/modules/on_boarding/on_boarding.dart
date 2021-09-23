import 'package:flutter/material.dart';
import 'package:shop/models/boarding_model.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  final List<BoardingModel> _boardingItems = [
    BoardingModel(
      image: 'assets/images/onboard3.png',
      title: 'Our Products',
      body: 'Here you can find all what you dream',
    ),
    BoardingModel(
      image: 'assets/images/onboard2.png',
      title: 'Our Prices',
      body: 'We always announce for big offers and occasion',
    ),
    BoardingModel(
      image: 'assets/images/onboard1.png',
      title: 'Dealing',
      body: 'We have a respect staff of employees',
    ),
  ];

  final _boardController = PageController();

  bool _isLast = false;

  void submit(context){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          defaultTextButton(
            onPressed: () {
              submit(context);
            },
            text: 'skip',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(_boardingItems[index]),
                itemCount: _boardingItems.length,
                onPageChanged: (index) {
                  if (index == _boardingItems.length - 1) {
                    _isLast = true;
                    print('Last');
                  } else {
                    _isLast = false;
                    print('Not Last');
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: _boardController,
                  count: _boardingItems.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotWidth: 10,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 3,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (_isLast == true) {
                      submit(context);
                    } else {
                      _boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Jannah',
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Jannah',
              color: Colors.blue
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );


}
