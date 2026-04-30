import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../forgot_password_screen.dart';
import '../../../viewmodels/auth_viewmodel.dart';

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
    return Consumer<AuthViewModel>(
      builder: (context, vm, child) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username wajib diisi";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Username",
                ),
              ),

              const SizedBox(height: defaultPadding),

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
                      _obscureText ? Icons.visibility_off : Icons.visibility,
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

              ElevatedButton(
                onPressed: vm.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          final username = emailController.text.trim();
                          final password = passwordController.text.trim();

                          print("LOGIN TRY → $username");

                          final success = await vm.login(
                            username,
                            password,
                          );

                          if (success) {
                            /// ✅ CALLBACK KE SignInScreen
                            widget.onLoginSuccess(username);
                          } else {
                            print("LOGIN FAILED");

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(vm.error ?? "Login gagal"),
                              ),
                            );
                          }
                        }
                      },
                child: vm.isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Sign in"),
              ),
            ],
          ),
        );
      },
    );
  }
}
