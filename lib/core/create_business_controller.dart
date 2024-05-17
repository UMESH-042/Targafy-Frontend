// import 'dart:convert';

// import 'package:targafy/business_home_page/models/create_business_model.dart';

// import '../../../api%20repository/api_http_response.dart';
// import '../../../api%20repository/product_repository.dart';
// import '../../../home/screens/controllers/home_controller.dart';
// import '../../../utils/colors.dart';
// import '../../../utils/routes/app_route_constants.dart';
// import '../../../utils/services/shared_preferences_service.dart';
// import '../../../utils/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class CreateBusinessProvider extends ChangeNotifier {
//   CreateBusinessModel? _createBusinessModel;
//   CreateBusinessModel? get createBusinessModel => _createBusinessModel;

//   final nameController = TextEditingController();
//   final industryTypeController = TextEditingController();
//   final cityController = TextEditingController();
//   final countryController = TextEditingController();

//   bool _isError = false;
//   bool get isError => _isError;

//   void clear() {
//     _createBusinessModel = null;
//     _isError = false;
//   }

//   void createBusiness(BuildContext context) async {
//     try {
//       if (!areAllFieldsFilled()) {
//         showSnackBar(context, "Fill complete details!!", invalidColor);
//         return;
//       }

//       String accessToken = await SharedPreferenceService().getAccessToken();

//       debugPrint(jsonEncode(_createBusinessModel!.toJson()));

//       ApiHttpResponse response = await callUserPostMethod(
//           _createBusinessModel!.toJson(), 'business/create', accessToken);

//       if (response.responseCode == 200) {
//         final homeController =
//             Provider.of<HomeProvider>(context, listen: false);

//         homeController.init(context);
//         GoRouter.of(context).goNamed(MyAppRouteConstants.homeRouteName);
//         showSnackBar(context, "Business created Successfully!!", successColor);

//         nameController.clear();
//         industryTypeController.clear();
//         cityController.clear();
//         countryController.clear(); 

//         notifyListeners();
//       } else {
//         final data = jsonDecode(response.responceString ?? "");
//         // Handle other status codes if needed
//         showSnackBar(context, "Failed to create business: ${data['message']}",
//             invalidColor);
//       }

//       debugPrint(response.responceString);
//     } catch (e) {
//       // Handle unexpected errors
//       showSnackBar(context, "An unexpected error occurred", invalidColor);
//       debugPrint("Error: $e");
//     }
//   }

//   void joinBusinessRequest(
//       BuildContext context, String businessCode, bool isScreen) async {
//     try {
//       // Validate business code
//       if (businessCode.isEmpty || businessCode.length != 6) {
//         showSnackBar(context, "Invalid business code!!", invalidColor);
//         return;
//       }

//       String accessToken = await SharedPreferenceService().getAccessToken();

//       ApiHttpResponse response = await callUserPatchMethod(
//           {}, 'business/send/request/$businessCode', accessToken);

//       if (response.responseCode == 200) {
//         showSnackBar(context, "Request sent Successfully!!", successColor);

//         if (isScreen) {
//           GoRouter.of(context).pop();
//         }

//         notifyListeners();
//       } else {
//         final data = jsonDecode(response.responceString ?? "");
//         // Handle other status codes if needed
//         showSnackBar(
//             context,
//             "Failed to send join request to business: ${data['message']}",
//             invalidColor);
//       }

//       debugPrint(response.responceString);
//     } catch (e) {
//       // Handle unexpected errors
//       showSnackBar(context, "An unexpected error occurred", invalidColor);
//       debugPrint("Error: $e");
//     }
//   }

//   bool areAllFieldsFilled() {
//     return _createBusinessModel != null &&
//         _createBusinessModel!.name != null &&
//         _createBusinessModel!.name!.isNotEmpty;
//   }

//   void updateBusinessName(String? name) {
//     if (_createBusinessModel != null) {
//       _createBusinessModel = _createBusinessModel!.copyWith(
//         name: name,
//       );
//     } else {
//       _createBusinessModel = CreateBusinessModel(name: name);
//     }
//     notifyListeners();
//   }

//   void updateBusinessIndustryType(String? industryType) {
//     if (_createBusinessModel != null) {
//       _createBusinessModel = _createBusinessModel!.copyWith(
//         industryType: industryType,
//       );
//     } else {
//       _createBusinessModel = CreateBusinessModel(industryType: industryType);
//     }
//     notifyListeners();
//   }

//   void updateAdminUserName(String? userName) {
//     if (_createBusinessModel != null) {
//       _createBusinessModel = _createBusinessModel!.copyWith(
//         userName: userName,
//       );
//     } else {
//       _createBusinessModel = CreateBusinessModel(userName: userName);
//     }
//     notifyListeners();
//   }

//   void updateBusinessCity(String? city) {
//     if (_createBusinessModel != null) {
//       _createBusinessModel = _createBusinessModel!.copyWith(
//         city: city,
//       );
//     } else {
//       _createBusinessModel = CreateBusinessModel(city: city);
//     }
//     notifyListeners();
//   }

//   void updateBusinessCountry(String? country) {
//     if (_createBusinessModel != null) {
//       _createBusinessModel = _createBusinessModel!.copyWith(
//         country: country,
//       );
//     } else {
//       _createBusinessModel = CreateBusinessModel(country: country);
//     }
//     notifyListeners();
//   }

//     void updateBusinessLogo(String? logo) {
//     if (_createBusinessModel != null) {
//       _createBusinessModel = _createBusinessModel!.copyWith(
//         logo: logo,
//       );
//     } else {
//       _createBusinessModel = CreateBusinessModel(logo: logo);
//     }
//     notifyListeners();
//   }
// }