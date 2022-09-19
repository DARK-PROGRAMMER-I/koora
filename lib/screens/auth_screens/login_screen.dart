// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:conditional_builder/conditional_builder.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/screens/auth_screens/info/info_screen.dart';
import 'package:koora_app/screens/auth_screens/signup_screen.dart';
import 'package:koora_app/screens/bnb_screens/main_screen.dart';
import 'package:koora_app/screens/choose_team_screens/localTeam/local_club_screen.dart';
import 'package:koora_app/shared/cache_helper.dart';
import 'package:koora_app/shared/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'forgetpassword_screen.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

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

  // final fb = FacebookLogin();
  var acessToken;
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken.token);

  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //   print(loginResult.accessToken);
  //   acessToken = loginResult.accessToken;

  //   print('firebase token');
  // }

  @override
  Widget build(BuildContext context) {
    //signInWithFacebook();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if (state.loginModel.message == 'login successfully') {
                token = state.loginModel.user.token;
                if (LoginCubit.get(context).loginModel.user.firstName == null) {
                  CacheHelper.saveData(
                          key: 'userId', value: state.loginModel.user.id)
                      .then((value) {
                    userId = state.loginModel.user.id;
                    token = state.loginModel.user.token;

                    ToAndFinish(
                      context,
                      InformationScreen(),
                    );
                  });
                } else if (LoginCubit.get(context)
                    .loginModel
                    .user
                    .teams
                    .isEmpty) {
                  token = state.loginModel.user.token;
                  CacheHelper.saveData(
                          key: 'userId', value: state.loginModel.user.token)
                      .then((value) {
                    userId = state.loginModel.user.id;
                    token = state.loginModel.user.token;
                    ToAndFinish(
                      context,
                      LocalClubScreen(),
                    );
                  });
                } else {
                  CacheHelper.saveData(
                          key: 'token', value: state.loginModel.user.token)
                      .then((value) {
                    token = state.loginModel.user.token;
                    ToAndFinish(
                      context,
                      MainScreen(),
                    );
                    CacheHelper.saveData(
                            key: 'userId', value: state.loginModel.user.id)
                        .then((value) {
                      userId = state.loginModel.user.id;
                    });
                  });
                }
                print(state.loginModel.message);
                print(state.loginModel.user.token);
              }
            }
          },
          builder: (context, state) {
            // Future<UserCredential> signInWithGoogle() async {
            //   // Trigger the authentication flow
            //   final GoogleSignInAccount googleUser =
            //       await GoogleSignIn().signIn();
            //   if (googleUser != null) {
            //     String email = googleUser.email;
            //     String provider = 'google';
            //     String id = googleUser.id;
            //     String image = googleUser.photoUrl;
            //     String name = googleUser.displayName;
            //     String device_token = myToken;

            //     await LoginCubit.get(context).userLoginWithGoogle(
            //         provider: provider,
            //         context: context,
            //         device_token: device_token,
            //         email: email,
            //         id: id,
            //         image: image,
            //         name: name);
            //   }
            // }

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0xff20272D),
                body: Stack(
                  children: [
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
                                  height: 30.h,
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
                                    height: constraint.maxHeight * 0.13,
                                    child: myTextField(
                                        emailController,
                                        "البريد الاكتروني",
                                        Image.asset("assets/icons/email.png"),
                                        validate: (value) {
                                      if (value.isEmpty) {
                                        return 'يرجى إدخال البريد الإلكتروني  ';
                                      }
                                    })),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: constraint.maxHeight * 0.13,
                                  child: myTextField(
                                      passwordController,
                                      "كلمة المرور",
                                      Image.asset("assets/icons/lock.png"),
                                      validate: (value) {
                                    if (value.isEmpty) {
                                      return ' يرجى إدخال كلمة المرور ';
                                    }
                                  }, obscure: true),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: constraint.maxHeight * 0.05,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            To(context, ForgetPasswordScreen());
                                          },
                                          child: myArabicText(
                                            "هل نسيت كلمة السر ؟",
                                            12,
                                            FontWeight.normal,
                                            Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => myButton(
                                    "تسجيل الدخول",
                                    () async {
                                      if (formKey.currentState.validate()) {
                                        await LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            context: context);
                                      }
                                    },
                                  ),
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 10.h),
                                  child: myBorderButton(
                                    myArabicText(
                                      "انشاء حساب",
                                      15,
                                      FontWeight.bold,
                                      Colors.white,
                                    ),
                                    () {
                                      To(context, SignupScreen());
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Divider(
                                        color: DividerColor,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: myArabicText(
                                        "أو",
                                        13,
                                        FontWeight.normal,
                                        DividerColor,
                                      ),
                                    ),
                                    const Expanded(
                                      child: Divider(
                                        color: DividerColor,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     SizedBox(
                                //       width: 20.w,
                                //     ),
                                //     SizedBox(
                                //       height: constraint.maxHeight * 0.1,
                                //       child: socialMediaSignup(
                                //         () async {
                                //           await signInWithGoogle();
                                //         },
                                //         Image.asset("assets/icons/google.png"),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 20.w,
                                //     ),
                                //     // SizedBox(
                                //     //   height: constraint.maxHeight * 0.1,
                                //     //   child: socialMediaSignup(
                                //     //     () async {
                                //     //       await signInWithFacebook()
                                //     //           .then((value) async {
                                //     //         await LoginCubit.get(context)
                                //     //             .userLoginWithGoogle(
                                //     //                 provider: 'facebook',
                                //     //                 context: context,
                                //     //                 device_token: myToken,
                                //     //                 email: value.user.email,
                                //     //                 id: value.additionalUserInfo
                                //     //                     .profile['id'],
                                //     //                 image: value
                                //     //                         .additionalUserInfo
                                //     //                         .profile['picture']
                                //     //                     ['data']['url'],
                                //     //                 name:
                                //     //                     value.user.displayName);
                                //     //         print(value.additionalUserInfo
                                //     //                 .profile['picture']['data']
                                //     //             ['url']);
                                //     //         print(value.user.email);
                                //     //         print(value.user.displayName);
                                //     //         print(value.additionalUserInfo
                                //     //             .profile['id']);
                                //     //         //   print(acessToken.toString());
                                //     //         print('tooooooooooooken');
                                //     //       });
                                //     //       // await fb.logIn(permissions: [
                                //     //       //   FacebookPermission.publicProfile,
                                //     //       //   FacebookPermission.email,
                                //     //       // ]).then((value) {
                                //     //       //   print('this is tokeeeeeeeeeen');
                                //     //       //   print(value.accessToken.token);
                                //     //       //   LoginCubit.get(context)
                                //     //       //       .userLoginWithFacebook(
                                //     //       //           provider: 'facebook',
                                //     //       //           access_token:
                                //     //       //               value.accessToken.token,
                                //     //       //           context: context,
                                //     //       //           device_token: myToken);
                                //     //       // });
                                //     //     },
                                //     //     Image.asset(
                                //     //         "assets/icons/facebook.png"),
                                //     //   ),
                                //     // ),
                                //   ],
                                // ),
                                // const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: myEnglishText(
                                    "AWK-software",
                                    18,
                                    FontWeight.bold,
                                    textColor,
                                  ),
                                ),
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
