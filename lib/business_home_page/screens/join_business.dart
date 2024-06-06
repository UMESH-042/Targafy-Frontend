  // screens/join_business_screen.dart

  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:targafy/business_home_page/controller/join_business_controller.dart';
  import 'package:targafy/business_home_page/models/business_request.dart';


  class JoinBusinessScreen extends ConsumerStatefulWidget {
  const JoinBusinessScreen({super.key});

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
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Consumer(builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          final request = JoinBusinessRequest(businessCode: _controller.text);
                          final joinBusinessState = ref.read(joinBusinessProvider(request).future);
                          final success = await joinBusinessState;
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully joined business')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to join business')));
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                    child: const Text('Submit'),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    }
  }
