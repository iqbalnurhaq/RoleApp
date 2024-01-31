import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roleapp/presentation/provider/auth_notifier.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roleapp/presentation/widgets/input/input_text_field.dart';
import 'package:roleapp/shared/state_enum.dart';

import '../../shared/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode emailFocus = FocusNode();
  final TextEditingController emailController = TextEditingController(text: '');

  final FocusNode passwordFocus = FocusNode();
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    emailFocus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    print("Focus: ${emailFocus.hasPrimaryFocus}");
  }

  Widget title() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back',
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: Text(
              'Login to your right account to continue and find what you want. Thanks',
              style: grayTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textInputField() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InputTextField(
            title: 'Email',
            textController: emailController,
            focusNode: emailFocus,
            icon: 'assets/icon/ic_email.svg',
          ),
          SizedBox(
            height: 16,
          ),
          InputTextField(
            title: 'Password',
            textController: passwordController,
            focusNode: passwordFocus,
            icon: 'assets/icon/ic_password.svg',
            obscure: true,
          ),
        ],
      ),
    );
  }

  Widget submitButton() {
    var provider = Provider.of<AuthNotifier>(context, listen: true);

    return Container(
      width: double.infinity,
      height: 55,
      margin: EdgeInsets.only(top: 24),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: kGreenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          var body = {
            "email": emailController.text,
            "password": passwordController.text
          };

          await provider.authLogin(body);
          if (provider.logged) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: kRedColor,
                content: Text(
                  provider.loginMessage,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        },
        child: provider.loginState == RequestState.Loading
            ? CircularProgressIndicator(
                color: kWhiteColor,
              )
            : Text(
                'Sign In',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
      ),
    );
  }

  Widget termCondition() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Text(
        'By continuing, you agree to our Terms & Conditions and Privacy Policy',
        style: grayTextStyle.copyWith(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            title(),
            textInputField(),
            submitButton(),
            termCondition(),
          ],
        ),
      ),
    );
  }
}
