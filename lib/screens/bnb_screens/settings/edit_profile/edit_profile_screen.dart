import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/edite_my_team_item.dart';
import 'package:koora_app/screens/bnb_screens/main_screen.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/cubit.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/passwordUpdate.dart';
import 'package:koora_app/screens/bnb_screens/settings/edit_profile/state.dart';

class EditeProfileScreen extends StatefulWidget {
  @override
  _EditeProfileScreenState createState() => _EditeProfileScreenState();
}

class _EditeProfileScreenState extends State<EditeProfileScreen> {
  var first_nameController = TextEditingController();
  var last_nameController = TextEditingController();
  var email = TextEditingController();
  File _file;

  @override
  Widget build(BuildContext context) {
    var height =
        AppBar().preferredSize.height + MediaQuery.of(context).viewPadding.top;

    return BlocProvider(
      create: (BuildContext context) => EditProfileCubit()..getProfileinfo(),
      child: BlocConsumer<EditProfileCubit, EditProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = EditProfileCubit.get(context);
          uploadImage(File file) async {
            //   email.text = cubit.myprofile.data.email;

            String fileName = file != null ? file.path.split('/').last : '';
            FormData formData = FormData.fromMap({
              'first_name': first_nameController.text != ''
                  ? first_nameController.text
                  : cubit.myprofile.data.firstName,
              "last_name": last_nameController.text != ''
                  ? last_nameController.text
                  : cubit.myprofile.data.lastName,
              'email':
                  email.text != '' ? email.text : cubit.myprofile.data.email,
              "image": file != null
                  ? await MultipartFile.fromFile(file.path, filename: fileName)
                  : null,
            });
            //          var cubit = EditProfileCubit.get(context);

            await cubit.EditProfileinfo(mydata: formData);

            print(formData.toString());
            // Navigator.pop(context);
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Color(0xff20272D),
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color(0xff283037),
                centerTitle: true,
                title: myArabicText(
                  "تعديل الملف الشخصي",
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: cubit.myprofile != null
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                XFile pickPhoto = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (pickPhoto != null) {
                                  setState(() {
                                    _file = File(pickPhoto.path);
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: MediaQuery.of(context).size.width *
                                        0.15,
                                    backgroundColor: textColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: SizedBox.fromSize(
                                              size: Size.fromRadius(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15),
                                              child: _file == null
                                                  ? Image.network(
                                                      "${cubit.myprofile.data.image}",
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.file(_file))),
                                    ),
                                  ),
                                  Positioned(
                                    top: 80,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 35.0.w,
                                      height: 35.0.h,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff3193BC),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        "assets/icons/cam_icon.png",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height -
                                      height) *
                                  0.07,
                              child: TextField(
                                controller: first_nameController,
                                decoration: InputDecoration(
                                  hintText: "${cubit.myprofile.data.firstName}",
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'lora',
                                  ),
                                  filled: true,
                                  fillColor: Color(0xff283037),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                  prefixIcon:
                                      Image.asset("assets/icons/user_icon.png"),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            content: Container(
                                              height: 250.h,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .height -
                                                                height) *
                                                            0.07,
                                                    child: TextField(
                                                      controller:
                                                          first_nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            " ${cubit.myprofile.data.firstName}",
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13,
                                                          fontFamily: 'tajawal',
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xff283037),
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .height -
                                                                height) *
                                                            0.07,
                                                    child: TextField(
                                                      controller:
                                                          last_nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            " ${cubit.myprofile.data.lastName}",
                                                        hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 13,
                                                          fontFamily: 'tajawal',
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xff283037),
                                                        border: OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await uploadImage(_file);
                                                      ToAndFinish(context,
                                                          MainScreen());
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "تم تعديل البيانات بنجاح",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.blue,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: textColor,
                                                      ),
                                                      child: myArabicText(
                                                        "تعديل",
                                                        12,
                                                        FontWeight.bold,
                                                        Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 7, bottom: 7),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: (MediaQuery.of(context).size.height -
                                      height) *
                                  0.07,
                              child: TextField(
                                controller: last_nameController,
                                decoration: InputDecoration(
                                  hintText: "${cubit.myprofile.data.lastName}",
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'lora',
                                  ),
                                  filled: true,
                                  fillColor: Color(0xff283037),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                  prefixIcon:
                                      Image.asset("assets/icons/user_icon.png"),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 7, bottom: 7),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: AlertDialog(
                                                  content: Container(
                                                    height: 250.h,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height -
                                                                  height) *
                                                              0.07,
                                                          child: TextField(
                                                            controller:
                                                                first_nameController,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  " ${cubit.myprofile.data.firstName}",
                                                              hintStyle:
                                                                  TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'tajawal',
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xff283037),
                                                              border: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        SizedBox(
                                                          height: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height -
                                                                  height) *
                                                              0.07,
                                                          child: TextField(
                                                            controller:
                                                                last_nameController,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  " ${cubit.myprofile.data.lastName}",
                                                              hintStyle:
                                                                  TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'tajawal',
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xff283037),
                                                              border: OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            await uploadImage(
                                                                _file);
                                                            ToAndFinish(context,
                                                                MainScreen());
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "تم تعديل البيانات بنجاح",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: textColor,
                                                            ),
                                                            child: myArabicText(
                                                              "تعديل",
                                                              12,
                                                              FontWeight.bold,
                                                              Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: (MediaQuery.of(context).size.height -
                                      height) *
                                  0.2,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cubit.myprofile.data.teams.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: EditeMyTeamItem(
                                          cubit.myprofile.data.teams[index],
                                          index),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                To(context, UpdatePassword());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: (MediaQuery.of(context).size.height -
                                        height) *
                                    0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: textColor, width: 1.5),
                                ),
                                child: myArabicText(
                                  "تغيير كلمة المرور",
                                  12,
                                  FontWeight.bold,
                                  Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                await uploadImage(_file);
                                ToAndFinish(context, MainScreen());
                                Fluttertoast.showToast(
                                    msg: "تم تعديل البيانات بنجاح",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: (MediaQuery.of(context).size.height -
                                        height) *
                                    0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: textColor,
                                ),
                                child: myArabicText(
                                  "تعديل",
                                  12,
                                  FontWeight.bold,
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
