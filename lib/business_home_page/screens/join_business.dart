// // screens/join_business_screen.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:targafy/business_home_page/controller/join_business_controller.dart';
// import 'package:targafy/business_home_page/models/business_request.dart';
// import 'package:targafy/widgets/submit_button.dart';

// class JoinBusinessScreen extends ConsumerStatefulWidget {
//   const JoinBusinessScreen({super.key});

//   @override
//   _JoinBusinessScreenState createState() => _JoinBusinessScreenState();
// }

// class _JoinBusinessScreenState extends ConsumerState<JoinBusinessScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Join Business'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _controller,
//                 decoration: const InputDecoration(labelText: 'Business Code'),
//                 maxLength: 6,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a business code';
//                   }
//                   if (value.length != 6) {
//                     return 'Business code must be 6 characters long';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               Consumer(builder: (context, ref, child) {
//                 return SubmitButton(
//                   onPressed: () async {
//                     if (_formKey.currentState?.validate() ?? false) {
//                       try {
//                         final request =
//                             JoinBusinessRequest(businessCode: _controller.text);
//                         final joinBusinessState =
//                             ref.read(joinBusinessProvider(request).future);
//                         final success = await joinBusinessState;
//                         if (success) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content:
//                                       Text('Successfully joined business')));
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Failed to join business')));
//                         }
//                       } catch (e) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text(e.toString())));
//                       }
//                     }
//                   },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:targafy/business_home_page/controller/join_business_controller.dart';
import 'package:targafy/business_home_page/models/business_request.dart';
import 'package:targafy/widgets/submit_button.dart';

class JoinBusinessScreen extends ConsumerStatefulWidget {
  const JoinBusinessScreen({Key? key}) : super(key: key);

  @override
  _JoinBusinessScreenState createState() => _JoinBusinessScreenState();
}

class _JoinBusinessScreenState extends ConsumerState<JoinBusinessScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Business'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Business Code'),
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a business code';
                  }
                  if (value.length != 6) {
                    return 'Business code must be 6 characters long';
                  }
                  if (!value.contains(RegExp(r'^[A-Z0-9]*$'))) {
                    return 'Only capital letters and numbers are allowed';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.characters,
              ),
              const SizedBox(height: 20),
              Consumer(builder: (context, ref, child) {
                return SubmitButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      try {
                        final request =
                            JoinBusinessRequest(businessCode: _controller.text);
                        final joinBusinessState =
                            ref.read(joinBusinessProvider(request).future);
                        final success = await joinBusinessState;
                        if (success) {
                          // Show success dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Request Sent Successfully'),
                              content: Text('Approval Awaited!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                    Navigator.of(context).pop(true);
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Show error dialog - business code incorrect
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Please enter correct code'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      } catch (e) {
                        // Show generic error dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text(e.toString()),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
