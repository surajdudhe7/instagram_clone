import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/wigits/text_find_input.dart';
import 'package:instagram_clone/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'data:image/jpeg;base64,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'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
                textEditingController: _bioController,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
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
                    child: const Text(
                      'Already have an account?',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
