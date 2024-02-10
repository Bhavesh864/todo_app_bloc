import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobilescree_layout.dart';
import 'package:instagram_clone/responsive/responsive.dart';
import 'package:instagram_clone/responsive/webscreen_layout.dart';

import 'package:instagram_clone/screens/signup_screen.dart';
import '../utils/utils.dart';
import '../models/auth_methods.dart';
import '../utils/colors.dart';
import '../widgets/textfield_inputs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _loginUserHandler() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);

    setState(() {
      _isLoading = false;
    });
    if (res == 'Successfully logged in') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobilScreenLayout(),
          ),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      Utils().showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Image.asset(
                'assets/Instagram_Logo_2016.png',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.emailAddress,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        minimumSize: const Size(350, 40),
                      ),
                      onPressed: _loginUserHandler,
                      child: const Text('Login'),
                    ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account ?"),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
