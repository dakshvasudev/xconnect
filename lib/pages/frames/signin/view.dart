import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/values/colors.dart';

import 'index.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});
  Widget _buildLogo() {
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      child: const Text(
        "Xconnect",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
          fontSize: 34,
        ),
      ),
    );
  }

  Widget _buildThirdPartyGoogleLogin() {
    return GestureDetector(
        child: Container(
          width: 295,
          height: 44,
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(padding: EdgeInsets.only(left: 40, right: 30), child: Image.asset("assets/icons/google.png")),
              Container(
                child: Text(
                  "Sign in with Google",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // controller.handleSignIn("google");
        });
  }

  Widget _buildThirdPartyFacebookLogin() {
    return GestureDetector(
        child: Container(
          width: 295,
          height: 44,
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(padding: EdgeInsets.only(left: 40, right: 30), child: Image.asset("assets/icons/facebook.png")),
              Container(
                child: Text(
                  "Sign in with Facebook",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // controller.handleSignIn("facebook");
        });
  }

  Widget _buildThirdPartyAppleLogin() {
    return GestureDetector(
        child: Container(
          width: 295,
          height: 44,
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(padding: EdgeInsets.only(left: 40, right: 30), child: Image.asset("assets/icons/apple.png")),
              Container(
                child: Text(
                  "Sign in with Apple",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // controller.handleSignIn("apple");
        });
  }

  Widget _buildThirdPartyPhoneLogin() {
    return GestureDetector(
        child: Container(
          width: 295,
          height: 44,
          margin: EdgeInsets.only(bottom: 40),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Sign in with phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // controller.handleSignIn("phone");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLogo(),
            _buildThirdPartyGoogleLogin(),
            _buildThirdPartyFacebookLogin(),
            _buildThirdPartyAppleLogin(),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 35),
              child: Row(children: <Widget>[
                Expanded(
                    child: Divider(
                  height: 2,
                  indent: 50,
                  color: AppColors.primarySecondaryElementText,
                )),
                Text("  or  "),
                Expanded(
                    child: Divider(
                  height: 2,
                  endIndent: 50,
                  color: AppColors.primarySecondaryElementText,
                )),
              ]),
            ),
            _buildThirdPartyPhoneLogin(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "Already have an account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                      child: Text(
                        "Sign up here ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryElement,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        // controller.handleSignIn("email");
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
