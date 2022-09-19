import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/screens/auth_screens/info/cubit/cubit.dart';
import 'package:koora_app/screens/choose_team_screens/localTeam/local_club_screen.dart';

import 'cubit/state.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  File _file;
  var formKey = GlobalKey<FormState>();

  var first_nameController = TextEditingController();
  var last_nameController = TextEditingController();
  var descconfirmController = TextEditingController();
  // Future pickercamera() async {
  //   final myfile = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _file = File(myfile.path);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    var Imagepath;

    return BlocProvider(
      create: (BuildContext context) => InfoCubit(),
      child: BlocConsumer<InfoCubit, InfoStates>(
        listener: (context, state) {
          if (state is InfoSuccessHomeDataState) {
            To(context, LocalClubScreen());
          }
        },
        builder: (context, state) {
          var cubit = InfoCubit.get(context);

          Future<dynamic> uploadImage(File file) async {
            String fileName = file != null ? file.path.split('/').last : '';
            FormData formData = FormData.fromMap({
              'first_name': first_nameController.text,
              'last_name': last_nameController.text,
              'desc': '',
              "image": file != null
                  ? await MultipartFile.fromFile(file.path, filename: fileName)
                  : null,
            });
            await cubit.updateUserData(myinfo: formData);

            print(formData.toString());
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Color(0xff20272D),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.34,
                        left: 15.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myArabicText(
                            "معلوماتك",
                            20,
                            FontWeight.bold,
                            Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    myEnglishText(
                        '"الصورة اختيارية"', 12, FontWeight.w600, Colors.white),
                    InkWell(
                      onTap: () async {
                        await ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((value) {
                          setState(() {
                            _file = File(value.path);
                          });
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 100.0.w,
                          height: 120.0.h,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child: _file == null
                              ? Image.asset("assets/icons/camera.png")
                              : ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(50), // Image radius
                                    child: Image.file(
                                      File(_file.path),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              infoTextField("الاسم الاول", first_nameController,
                                  validate: (value) {
                                if (value.isEmpty) {
                                  return ' أدخل الاسم الاخير ';
                                }
                              }),
                              SizedBox(
                                height: 20,
                              ),
                              infoTextField("الاسم الاخير", last_nameController,
                                  validate: (value) {
                                if (value.isEmpty) {
                                  return ' أدخل الاسم الاخير ';
                                }
                              }),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 10,
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          ConditionalBuilder(
                            condition: state is! InfoLoadingHomeDataState,
                            builder: (context) => InkWell(
                              onTap: () async {
                                // String fileName = _file.path.split('/').last;
                                // await cubit.updateUserData(myinfo: {
                                //   'first_name': first_nameController.text,
                                //   'last_name': last_nameController.text,
                                //   'desc': descconfirmController.text,
                                //   "image": await MultipartFile.fromFile(
                                //       _file.path,
                                //       filename: fileName),
                                // });
                                if (formKey.currentState.validate()) {
                                  uploadImage(_file);
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 30,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1.5, color: textColor),
                                ),
                                child: myArabicText(
                                  "التالي",
                                  12,
                                  FontWeight.normal,
                                  textColor,
                                ),
                              ),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
