import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/screens/auth_screens/cubit/cubit.dart';
import 'package:koora_app/screens/auth_screens/cubit/states.dart';

import 'login_successfully_screen .dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var myToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.getToken().then((String token) {
      setState(() {
        myToken = token;
        print(token);
        print('this my Device TOKEN');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordconfirmController = TextEditingController();

    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.registermodel.status) {
                ToAndFinish(
                  context,
                  LoginSuccessfulyScreen(),
                );
              } else {
                // Toast
                print('Sucsess');
              }
            }
          },
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0xff20272D),
                body: Stack(
                  children: [
                    //            Container(
                    //              height: double.infinity,
                    //              width: double.infinity,
                    //              child: SvgPicture.asset(
                    //                'assets/images/background.svg',
                    //                fit: BoxFit.cover,
                    //              ),
                    //            ),

                    Container(
                      height: 200.h,
                      decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                          bottomRight: Radius.circular(90),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        margin: (EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.1,
                          bottom: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.1,
                        )),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: LayoutBuilder(
                          builder: (ctx, constraint) => Form(
                            key: formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: constraint.maxHeight * 0.03,
                                            child: Image.asset(
                                              "assets/icons/back_arrow.png",
                                              width: 12,
                                            ),
                                          )),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: constraint.maxHeight * 0.05,
                                  child: myEnglishText(
                                    "KoORa ZoNE",
                                    25,
                                    FontWeight.bold,
                                    Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                                Container(
                                  height: constraint.maxHeight * 0.1,
                                  child: myTextField(
                                    emailController,
                                    "البريد الاكتروني",
                                    Image.asset("assets/icons/email.png"),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: constraint.maxHeight * 0.1,
                                  child: myTextField(
                                      passwordController,
                                      "كلمة المرور",
                                      Image.asset("assets/icons/lock.png"),
                                      obscure: true),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: constraint.maxHeight * 0.1,
                                  child: myTextField(
                                      passwordconfirmController,
                                      "تأكيد كلمة المرور",
                                      Image.asset("assets/icons/lock.png"),
                                      obscure: true),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),

                                ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context) => myButton(
                                    "سجل",
                                    () {
                                      if (formKey.currentState.validate()) {
                                        LoginCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          password_confirmation:
                                              passwordconfirmController.text,
                                          deviceToken: myToken,
                                        );
                                      }
                                      // To(context, InformationScreen());
                                      //  To(context, InformationScreen());
                                    },
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),

                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: Divider(
                                //         color: DividerColor,
                                //         thickness: 1,
                                //       ),
                                //     ),
                                //     Padding(
                                //       padding: EdgeInsets.symmetric(horizontal: 20),
                                //       child: myArabicText(
                                //         "أو",
                                //         13,
                                //         FontWeight.normal,
                                //         DividerColor,
                                //       ),
                                //     ),
                                //     Expanded(
                                //       child: Divider(
                                //         color: DividerColor,
                                //         thickness: 1,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Container(
                                //       height: 40.h,
                                //       child: socialMediaSignup(
                                //         () {},
                                //         Image.asset("assets/icons/apple.png"),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 20.w,
                                //     ),
                                //     Container(
                                //       height: 40.h,
                                //       child: socialMediaSignup(
                                //         () {},
                                //         Image.asset("assets/icons/google.png"),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 20.w,
                                //     ),
                                //     Container(
                                //       height: 40.h,
                                //       child: socialMediaSignup(
                                //         () {},
                                //         Image.asset("assets/icons/facebook.png"),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Spacer(),
                                // Padding(
                                //   padding: EdgeInsets.only(bottom: 20.h),
                                //   child: myEnglishText(
                                //     "AWK-software",
                                //     18,
                                //     FontWeight.bold,
                                //     textColor,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
