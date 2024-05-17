
import 'package:remixicon/remixicon.dart';
import 'package:targafy/core/constants/colors.dart';

import 'package:flutter/material.dart';


class MyDrawer extends StatefulWidget {
  final String name;

  const MyDrawer({super.key, required this.name});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  @override
  Widget build(BuildContext context) {



    return Drawer(
      child: Container(
        color: Colors.green,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(color: secondaryColor),
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(10.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    // FutureBuilder<String>(
                    //   future: getVersion(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       return Text(
                    //         snapshot.data ?? "",
                    //         style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w300, fontSize: 12),
                    //       );
                    //     } else {
                    //       return const Text("");
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
              
              
              Theme(
                data: ThemeData(
                  /// Prevents to splash effect when clicking.
                  splashColor: Colors.transparent,

                  /// Prevents the mouse cursor to highlight the tile when hovering on web.
                  hoverColor: Colors.transparent,

                  /// Hides the highlight color when the tile is pressed.
                  highlightColor: Colors.transparent,

                  /// Makes the top and bottom dividers invisible when expanded.
                  dividerColor: Colors.transparent,

                  /// Make background transparent.
                  expansionTileTheme: const ExpansionTileThemeData(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                  ),
                ),
                child: ExpansionTile(
                  collapsedBackgroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  leading: const Icon(
                    Remix.building_line,
                    color: Colors.white,
                  ),
                  trailing: const Icon(
                    Remix.arrow_down_s_line,
                    color: Colors.white,
                  ),
                  initiallyExpanded: true,
                  title: const Text(
                    "Businesses",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        // final business = userModel.businesses[index];
                        return ListTile(
                          title: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // FutureBuilder<String?>(
                              //   future: controller.getUsersBusinessesLogo(context, business.businessId),
                              //   builder: (context, snapshot) {
                              //     String? logoUrl = snapshot.data;

                              //     debugPrint("this is logo url $logoUrl");
                              //     if (snapshot.connectionState == ConnectionState.done) {
                              //       return logoUrl == null
                              //           ? const CircleAvatar(
                              //               radius: 20,
                              //               backgroundColor: Colors.grey,
                              //               backgroundImage: AssetImage("assets/images/logo.png"),
                              //             )
                              //           : CircleAvatar(
                              //               radius: 20,
                              //               backgroundColor: Colors.transparent,
                              //               child: ClipOval(
                              //                 child: CachedNetworkImage(
                              //                   height: 40,
                              //                   width: 40,
                              //                   fit: BoxFit.cover,
                              //                   imageUrl: logoUrl,
                              //                   placeholder: (context, url) => _buildPlaceholder(context),
                              //                   errorWidget: (context, url, error) => _buildError(context),
                              //                 ),
                              //               ),
                              //             );
                              //     }

                              //     if (snapshot.connectionState == ConnectionState.waiting) {
                              //       return const CircleAvatar(
                              //         radius: 20,
                              //         backgroundColor: Colors.grey,
                              //         backgroundImage: AssetImage("assets/images/issuecop_logo.png"),
                              //       );
                              //     }

                              //     // Show a loading indicator while the future is not yet complete
                              //     return const CircularProgressIndicator();
                              //   },
                              // ),
                              SizedBox(width: 5),
                              // Flexible(
                              //   child: Text(
                              //     business.name,
                              //     overflow: TextOverflow.ellipsis,
                              //     style: const TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(width: 5),
                              // FutureBuilder<int>(
                              //   future: controller.getActivityCountForBusiness(business.businessId, business.userType), // Fetch the activity count asynchronously
                              //   builder: (context, snapshot) {
                              //     if (snapshot.connectionState == ConnectionState.waiting) {
                              //       return SizedBox(
                              //         width: 20, // Adjust as needed
                              //         height: 20, // Adjust as needed
                              //         child: Container(),
                              //       );
                              //     } else {
                              //       final activityCount = snapshot.data ?? 0;
                              //       if (activityCount > 0) {
                              //         return Stack(
                              //           alignment: Alignment.topRight,
                              //           children: [
                              //             Container(
                              //               padding: const EdgeInsets.all(4),
                              //               decoration: BoxDecoration(
                              //                 color: Colors.red, // Red background color
                              //                 borderRadius: BorderRadius.circular(8),
                              //               ),
                              //               child: Text(
                              //                 '$activityCount',
                              //                 style: const TextStyle(
                              //                   color: Colors.white, // White text color
                              //                   fontSize: 12, // Adjust font size as needed
                              //                   fontWeight: FontWeight.bold,
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //       } else {
                              //         return const SizedBox();
                              //       }
                              //     }
                              //   },
                              // ),
                            ],
                          ),
                          onTap: () async {
                            // SharedPreferenceService().setSelectedBusiness(business.businessId);
                            // GoRouter.of(context).pop();
                            // Provider.of<BusinessRequestsProvider>(context, listen: false).clear();
                            // Provider.of<BusinessController>(context, listen: false).clear();
                            // Provider.of<BusinessUsersProvider>(context, listen: false).clear();
                            // Provider.of<CreateBusinessProvider>(context, listen: false).clear();
                            // Provider.of<GroupProvider>(context, listen: false).clear();
                            // Provider.of<ViewGroupProvider>(context, listen: false).clear();
                            // Provider.of<IssueProvider>(context, listen: false).clear();
                            // Provider.of<OutsiderProvider>(context, listen: false).clear();
                            // controller.setNewBusiness(context, business.businessId, business.userType);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 0.5,
                endIndent: 20,
                color: Colors.white,
              ),
              ListTile(
                title: const Text(
                  "Create Business",
                  // textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  // GoRouter.of(context).pop(); // pop the drawer
                  // GoRouter.of(context).pushNamed(MyAppRouteConstants.createBusinessRouteName);
                },
              ),
            
             
            
             
            
             
           
      
            
          
            
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor, // Customize progress indicator color
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return  Icon(
      Icons.error,
      color: tertiaryColor, 
    );
  }
}
