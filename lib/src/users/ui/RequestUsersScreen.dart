import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/src/users/ui/controller/business_request_controller.dart';
import 'package:targafy/src/users/ui/widget/accept_request_dialog.dart';
import 'package:targafy/src/users/ui/widget/request_tile.dart';
import 'package:targafy/widgets/custom_back_button.dart';

class BusinessRequestsPage extends ConsumerStatefulWidget {
  final String? businessId;

  const BusinessRequestsPage({Key? key, required this.businessId})
      : super(key: key);

  @override
  _BusinessRequestsPageState createState() => _BusinessRequestsPageState();
}

class _BusinessRequestsPageState extends ConsumerState<BusinessRequestsPage> {
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // Fetch initial requests list
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.businessId != null && !_isRefreshing) {
        ref
            .read(businessRequestsProvider.notifier)
            .getRequestsList(context, widget.businessId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final requestController = ref.read(businessRequestsProvider.notifier);
    final userRequestList = ref.watch(businessRequestsProvider);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
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
        body: userRequestList.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : userRequestList.errorMessage != null
                ? Center(
                    child: Text(userRequestList.errorMessage!),
                  )
                : userRequestList.userRequestList == null ||
                        userRequestList.userRequestList!.isEmpty
                    ? const Center(
                        child: Text("No requests found"),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          _isRefreshing = true;
                          await requestController.getRequestsList(
                              context, widget.businessId!);
                          _isRefreshing = false;
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    "Requests",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        userRequestList.userRequestList!.length,
                                    itemBuilder: (context, index) {
                                      final user = userRequestList
                                          .userRequestList![index];
                                      return RequestTile(
                                        date: DateTime.parse(user.date),
                                        name: user.name,
                                        contactNumber: user.contactNumber,
                                        onAccept: () {
                                          if (user.userId != null) {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  UserSelectionDialog(
                                                userId: user.userId!,
                                                userRequestCallback: (success) {
                                                  if (success) {
                                                    requestController.clear();
                                                    setState(() {
                                                      ref
                                                          .read(
                                                              businessRequestsProvider
                                                                  .notifier)
                                                          .getRequestsList(
                                                              context,
                                                              widget
                                                                  .businessId!);
                                                    });
                                                  }
                                                },
                                                businessId: widget.businessId!,
                                              ),
                                            );
                                          }
                                        },
                                        onReject: () {
                                          // Handle reject action
                                        },
                                      );
                                    },
                                  ),
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
