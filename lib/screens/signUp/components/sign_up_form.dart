import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../data/user_data.dart';
import '../../auth/sign_in_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  /// CONTROLLER
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// FULL NAME
          TextFormField(
            controller: nameController,
            validator: requiredValidator.call,
            decoration: const InputDecoration(hintText: "Full Name"),
          ),
          const SizedBox(height: defaultPadding),

          /// EMAIL
          TextFormField(
            controller: emailController,
            validator: emailValidator.call,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email Address"),
          ),
          const SizedBox(height: defaultPadding),

          /// PASSWORD (FIXED)
          TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password wajib diisi";
              }
              if (value.length < 3) {
                return "Minimal 3 karakter";
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

          /// CONFIRM PASSWORD (FIXED)
          TextFormField(
            controller: confirmPasswordController,
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Wajib diisi";
              }
              if (value != passwordController.text) {
                return "Password tidak sama";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Confirm Password",
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

          /// BUTTON SIGN UP (FIXED + DEBUG)
          ElevatedButton(
            onPressed: () {
              print("TOMBOL DIKLIK");

              /// DEBUG TAMBAHAN (BIAR KETAHUAN)
              print("Nama: ${nameController.text}");
              print("Email: ${emailController.text}");
              print("Password: ${passwordController.text}");
              print("Confirm: ${confirmPasswordController.text}");

              if (_formKey.currentState!.validate()) {
                print("VALID");

                /// SIMPAN DATA
                savedEmail = emailController.text;
                savedPassword = passwordController.text;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Akun berhasil dibuat")),
                );

                /// PINDAH KE LOGIN
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignInScreen(),
                  ),
                );
              } else {
                print("TIDAK VALID");
              }
            },
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}