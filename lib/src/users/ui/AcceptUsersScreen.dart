import 'package:flutter/material.dart';
import 'package:targafy/widgets/custom_back_button.dart';

class BusinessRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02,
              horizontal: MediaQuery.of(context).size.width * 0.04,
            ),
            child: const Row(
              children: [
                CustomBackButton(),
                SizedBox(width: 20),
                Text(
                  "Requests",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Requests ",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5, // Replace with actual count
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // RequestTile widget goes here
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
              
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Declined Requests ",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5, // Replace with actual count
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // DeclinedRequestTile widget goes here
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                  
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Accepted Requests ",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                 
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5, // Replace with actual count
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // MyAcceptedRequestTile widget goes here
                          SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

