import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/responsive/mobilescree_layout.dart';
import 'package:instagram_clone/responsive/responsive.dart';
import 'package:instagram_clone/responsive/webscreen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';

import '../models/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/textfield_inputs.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  _renderImage() async {
    Uint8List pickedImage = await Utils().pickImage(ImageSource.camera);
    setState(() {
      _image = pickedImage;
    });
  }

  void _signUpHandler() async {
    if (_image == null) {
      Utils().showSnackBar('Please select profile picture', context);
      return;
    }

    setState(() {
      _isLoading = true;
    });
    final result = await AuthMethods().signupUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      imageFile: _image!,
    );

    setState(() {
      _isLoading = false;
    });
    if (result != 'Account created successfully') {
      // ignore: use_build_context_synchronously
      Utils().showSnackBar(result, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobilScreenLayout(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/Instagram_Logo_2016.png',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 50,
              ),
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMLYACaGIbSwNMTz6AN8Vac6G8NidhAU0QoguP79Q&s'),
                        ),
                  Positioned(
                    bottom: 5,
                    right: 100,
                    child: IconButton(
                      onPressed: _renderImage,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: _image != null ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your username',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.emailAddress,
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
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
                      onPressed: _signUpHandler,
                      child: const Text('Signup'),
                    ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account?"),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
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
