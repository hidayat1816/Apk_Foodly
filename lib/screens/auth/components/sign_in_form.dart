import 'package:flutter/material.dart';

import '../../findRestaurants/find_restaurants_screen.dart';
import '../../../constants.dart';
import '../../../data/user_data.dart';
import '../forgot_password_screen.dart';

class SignInForm extends StatefulWidget {
  final Function(String email) onLoginSuccess;

  const SignInForm({
    super.key,
    required this.onLoginSuccess,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// EMAIL
          TextFormField(
            controller: emailController,
            validator: emailValidator.call,
            decoration: const InputDecoration(hintText: "Email Address"),
          ),

          const SizedBox(height: defaultPadding),

          /// PASSWORD
          TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password wajib diisi";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding),

          /// FORGOT PASSWORD
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ForgotPasswordScreen(),
                ),
              );
            },
            child: const Text("Forget Password?"),
          ),

          const SizedBox(height: defaultPadding),

          /// LOGIN BUTTON
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (emailController.text == savedEmail &&
                    passwordController.text == savedPassword) {
                  
                  /// 🔥 AUTO LOGIN CALLBACK
                  widget.onLoginSuccess(emailController.text);

                  /// pindah halaman (opsional kalau tidak pakai callback)
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FindRestaurantsScreen(),
                    ),
                    (_) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Email atau Password salah"),
                    ),
                  );
                }
              }
            },
            child: const Text("Sign in"),
          ),
        ],
      ),
    );
  }
}