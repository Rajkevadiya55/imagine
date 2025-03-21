import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imagine/common/color_constant/color_constant.dart';
import 'package:imagine/common/image_constant/image_constant.dart';
import 'package:imagine/cubit/firebase_token/firebase_token_cubit.dart';
import 'package:imagine/cubit/login/login_cubit.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/router/app_router.dart';
import 'package:imagine/widget/app_easy_loading.dart';
import 'package:imagine/widget/common_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController mobileCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppIcons.app_logo,
                  height: 100,
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: mobileCon,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    // Adjust vertical padding
                    hintText: "Enter Mobile Number",
                    hintStyle:
                        TextStyle(color: AppColors.greyA6AEBF, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: AppColors.greyA6AEBF, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: AppColors.greyA6AEBF, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: AppColors.greyA6AEBF, width: 1.5),
                    ),
                    suffixIcon: SizedBox.shrink(), // Added trailing widget
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordCon,
                  obscureText: _obscureText, // Hides or shows the password
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    // Adjust vertical padding
                    hintText: "Enter Password",
                    hintStyle:
                        TextStyle(color: AppColors.greyA6AEBF, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: AppColors.greyA6AEBF, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: AppColors.greyA6AEBF, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide:
                          BorderSide(color: AppColors.greyA6AEBF, width: 1.5),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _obscureText = !_obscureText;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset(
                          _obscureText ? AppIcons.closeEyes : AppIcons.openEyes,
                          height: 15,
                          width: 15,
                          color: AppColors.greyA6AEBF,
                        ),
                      ),
                    ), // Added trailing widget
                  ),
                ),
                // SizedBox(
                //   height: 6,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextButton(
                //       onPressed: () {},
                //       child: CustomText(
                //         text: 'Forgot Password?',
                //         color: Colors.red,
                //         fontWeight: FontWeight.w400,
                //         fontSize: 15,
                //         textDecoration: TextDecoration.underline,
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 35,
                ),
                BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginStateLoading) {
                      easyLoadingShowProgress(status: "Please Wait...");
                    } else if (state is LoginStateSuccess) {
                      easyLoadingShowSuccess(state.message);
                      AppRouter.navigatorKey.currentState
                          ?.pushNamedAndRemoveUntil(AppRouter.dashboard,
                              (Route<dynamic> route) => false);
                      context
                          .read<FirebaseTokenCubit>()
                          .firebaseTokenCubit(token: token.toString());
                    } else if (state is LoginStateError) {
                      easyLoadingShowError(state.message);
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      context.read<LoginCubit>().loginCubit(
                          mobile: mobileCon.text.trim(),
                          password: passwordCon.text.trim());
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Login',
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
