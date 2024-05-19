import 'package:dcr_mobile/dto/login_request.dart';
import 'package:dcr_mobile/ui/login/login_screen_viewmodel.dart';
import 'package:dcr_mobile/ui/checkpoint/checkpoint_view.dart';
import 'package:dcr_mobile/widgets/Costom_button_comite.dart';
import 'package:dcr_mobile/widgets/background_pattern.dart';
import 'package:dcr_mobile/widgets/button_primary.dart';
import 'package:dcr_mobile/widgets/custom_button.dart';
import 'package:dcr_mobile/widgets/custom_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:unicons/unicons.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginScreenViewModel>.reactive(
      viewModelBuilder: () => LoginScreenViewModel(),
      builder: (context, viewModel, child) {
        if (viewModel.hasError) {
          var message = "";

          if (viewModel.modelError["status"] == null) {
            message = "Belum mendaftar race";
          } else {
            message = viewModel.modelError["message"];
          }
          Fluttertoast.cancel();
          Fluttertoast.showToast(
            msg: message.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0,
          );

          viewModel.clearErrors();
        }

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BackgroundPattern(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo-white.png",
                      width: 250,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextInput(
                      fillColor: Colors.white,
                      controller: viewModel.usernameController,
                      label: "Username / Email",
                      labelColor: Colors.black54,
                    ),
                    const SizedBox(height: 20),
                    CustomTextInput(
                      controller: viewModel.passwordController,
                      fillColor: Colors.white,
                      label: "Password",
                      obscureText: !viewModel.isHidePassword,
                      labelColor: Colors.black54,
                      suffixIcon: GestureDetector(
                        onTap: () => viewModel.showHidePassword(),
                        child: Icon(
                          !viewModel.isHidePassword
                              ? UniconsLine.eye_slash
                              : UniconsLine.eye,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => viewModel.forgotPassword(),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Forget Password?",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ButtonPrimary(
                      title: "Login",
                      titleWidget: viewModel.isBusy
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : null,
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        viewModel.login(
                          LoginRequest(
                            username: viewModel.usernameController.text,
                            password: viewModel.passwordController.text,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomOutlinedButton(
                      title: "Register",
                      outlinedColor: Colors.white,
                      titleColor: Colors.white,
                      onTap: () => viewModel.register(),
                    ),
                    const SizedBox(height: 20),
                    CustomOutlinedButtoncomite(
                    title: "Login us Committee",
                    outlinedColor: Colors.white,
                    titleColor: Colors.white,
                    onTap: () => viewModel.navigateCheckPoint()
                  ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
