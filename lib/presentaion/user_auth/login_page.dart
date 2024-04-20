// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wegrow_task_flutter/core/utils/boxes.dart';
import 'package:wegrow_task_flutter/core/utils/color_constant.dart';
import 'package:wegrow_task_flutter/core/utils/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:wegrow_task_flutter/core/utils/validation_functions.dart';
import 'package:wegrow_task_flutter/domain/common_functions/common_functions.dart';
import 'package:wegrow_task_flutter/presentaion/user_auth/log_in_bloc/login_bloc.dart';
import 'package:wegrow_task_flutter/presentaion/user_auth/widgets/form_container_widget.dart';
import 'package:wegrow_task_flutter/presentaion/user_auth/signup_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc loginBloc = LoginBloc();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(LoginLodingEvent(isloading: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _signin,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLodingStat) {
                        return Center(
                          child: state.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      }
                      return const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have Account?"),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SingupPage()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SignIn with Google",
                    style: TextStyle(color: ConfigColors.mainPrimaryColor),
                  ),
                  IconButton(
                      onPressed: () async {
                        await FirebaseAuthServices().singInWithGoogle();
                        CommonFunctions()
                            .showToast(message: "Log In Successfully");
                        Navigator.pushNamed(context, "/home");
                      },
                      icon: Image.asset(
                        "assets/logo/google.png",
                        height: 20,
                        width: 20,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signin() async {
    if (!isValidEmail(_emailController.text, isRequired: true)) {
      CommonFunctions().showToast(message: "InValid Email");
    }

    BlocProvider.of<LoginBloc>(context).add(LoginLodingEvent(isloading: true));

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    BlocProvider.of<LoginBloc>(context).add(LoginLodingEvent(isloading: false));

    if (user != null) {
      // print("User Log in Successfully");
      CommonFunctions().showToast(message: "Log In Successfully");
      await HiveBox().logInfo.put('mail', _emailController.text.toString());
      await HiveBox().logInfo.put('pass', _passwordController.text.toString());
      Navigator.pushNamed(context, "/home");
    } else {
      CommonFunctions().showToast(message: "Log In Failed");
      // print("User Log in failed");
    }
  }
}
