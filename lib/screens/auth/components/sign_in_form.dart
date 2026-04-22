import 'package:flutter/material.dart';
import '../../findRestaurants/find_restaurants_screen.dart';
import '../../../constants.dart';
import '../../../data/user_data.dart';
import '../forgot_password_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  /// CONTROLLER
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
            keyboardType: TextInputType.emailAddress,
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
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: _obscureText
                    ? const Icon(Icons.visibility_off, color: bodyTextColor)
                    : const Icon(Icons.visibility, color: bodyTextColor),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          /// FORGOT PASSWORD
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen(),
              ),
            ),
            child: Text(
              "Forget Password?",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: defaultPadding),

          /// BUTTON LOGIN
          ElevatedButton(
            onPressed: () {
              print("LOGIN DIKLIK");

              if (_formKey.currentState!.validate()) {
                print("VALID LOGIN");

                /// CEK DATA
                if (emailController.text == savedEmail &&
                    passwordController.text == savedPassword) {

                  print("LOGIN BERHASIL");

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const FindRestaurantsScreen(),
                    ),
                    (_) => false,
                  );

                } else {
                  print("LOGIN GAGAL");

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