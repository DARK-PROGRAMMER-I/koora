import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/state.dart';

import '../../../../components/global_componnets.dart';
import 'cubit.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var passwordConfirmController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => EditProfileCubit()..getProfileinfo(),
      child: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = EditProfileCubit.get(context);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Color(0xff20272D),
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xff283037),
                centerTitle: true,
                title: myArabicText(
                  "تغيير كلمة المرور",
                  15,
                  FontWeight.bold,
                  Colors.white,
                ),
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/icons/back_icon.png",
                    )),
              ),
              body: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Column(children: [
                  Container(
                    child: myTextField(
                        passwordController,
                        "  إدخال كلمة المرور الجديدة",
                        Image.asset("assets/icons/lock.png"),
                        validate: (value) {
                      if (value.isEmpty) {
                        return ' يرجى إدخال كلمة المرور ';
                      }
                    }, obscure: true),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    child: myTextField(
                        passwordConfirmController,
                        " تأكيد كلمة المرور الجديدة",
                        Image.asset("assets/icons/lock.png"),
                        validate: (value) {
                      if (value.isEmpty) {
                        return ' يرجى إدخال كلمة المرور ';
                      }
                    }, obscure: true),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  myButton(
                    "تعديل  ",
                    () {
                      cubit.EditPassword(
                          password: passwordController.text,
                          passwordConfirm: passwordConfirmController.text);
                      //To(context, LoginScreen());
                      //  To(context, InformationScreen());
                    },
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
