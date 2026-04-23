import 'package:flutter/material.dart';
import 'reset_email_sent_screen.dart';

import '../../components/welcome_text.dart';
import '../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(
              title: "Forgot password",
              text:
                  "Enter your email address and we will \nsend you a reset instructions.",
            ),
            SizedBox(height: defaultPadding),
            ForgotPassForm(),
          ],
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(); // 🔥 tambah ini

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            controller: emailController, // 🔥 pakai controller
            validator: emailValidator.call,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email Address"),
          ),
          const SizedBox(height: defaultPadding),

          // Reset password Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {

                /// 🔥 TAMBAHAN FEEDBACK
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Link reset dikirim ke ${emailController.text}",
                    ),
                  ),
                );

                /// PINDAH KE HALAMAN BERIKUT
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetEmailSentScreen(),
                  ),
                );
              }
            },
            child: const Text("Reset password"),
          ),
        ],
      ),
    );
  }
}