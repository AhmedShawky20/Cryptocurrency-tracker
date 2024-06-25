import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cryptocurrency/cubit/cubit.dart';
import 'package:Cryptocurrency/cubit/state.dart';
import 'package:Cryptocurrency/view/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String body;
  final String title;

  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var BoardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'images/onboarding.png',
        title: "Easy Trading",
        body:
        "Start investing today and your future will change for the better."),
    BoardingModel(
        image: 'images/WalletSecurity.png',
        title: "Wallet Security.",
        body: "Secure online and offline wallets with our advanced technology"),
    BoardingModel(
        image: 'images/real_time.png',
        title: "Real-Time Graphs",
        body: "Get the real time graphs with market history and info."),
  ];
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: BoardController,
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                        print('last');
                      } else {
                        setState(() {
                          isLast = false;
                        });
                        print('not last');
                      }
                    },
                    itemBuilder: (context, index) =>
                        buildBoardingItem(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                        controller: BoardController,
                        effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.yellow,
                          dotHeight: 10,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 5,
                        ),
                        count: boarding.length),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        } else {
                          BoardController.nextPage(
                              duration: Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
                fontSize: 35,
                fontFamily: "PlayfairDisplay",
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
                fontSize: 20,
                fontFamily: "PlayfairDisplay"
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      );
}
