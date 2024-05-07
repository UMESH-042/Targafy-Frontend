import 'package:flutter/material.dart';
import 'package:targafy/core/constants/dimensions.dart';
import 'package:targafy/core/utils/texts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getScreenheight(context) * 0.08),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.035),
          margin: EdgeInsets.only(top: getScreenheight(context) * 0.01),
          child: AppBar(
            title: CustomText(
              text: 'Hi Admin',
              fontSize: getScreenWidth(context) * 0.055,
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  child: Image.asset('assets/img/search.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  child: Image.asset('assets/img/filter.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  child: Image.asset('assets/img/add.png'),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: const Drawer(),
      body: Center(
        child: Text('HomeScreenfgdf '),
      ),
    );
  }
}
