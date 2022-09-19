import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/items/choose_national_team%20_Edit.dart';
import 'package:koora_app/items/choose_team_item.dart';
import 'package:koora_app/screens/choose_team_screens/almontakab.dart/cubit.dart';
import 'package:koora_app/screens/choose_team_screens/almontakab.dart/state.dart';

import 'package:koora_app/screens/choose_team_screens/selectTeam/selected_team_screen.dart';

class AlmontakhabScreenEdit extends StatefulWidget {
  @override
  _AlmontakhabScreenEditState createState() => _AlmontakhabScreenEditState();
}

class _AlmontakhabScreenEditState extends State<AlmontakhabScreenEdit> {
  almontakhabTeamCubit newsApi = almontakhabTeamCubit();
  //List<dynamic> articles = [];
  int currentPage = 1;
  bool loading = true;
  ScrollController scrollController = ScrollController();
  fetchNews() {
    setState(() {
      // ignore: missing_return
      Builder(builder: (BuildContext context) {
        newsApi;
      });

      for (int i = 0; i < newsApi.articles.length; i++) {
        print(newsApi.articles[i].name);
      }

      newsApi.getalmontakhabTeam(number: currentPage);

      currentPage++;
      loading = false;
    });
  }

  @override
  void initState() {
    fetchNews();
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      double minScroll = scrollController.position.maxScrollExtent - 100.h;
      double maxScroll = scrollController.position.maxScrollExtent;
      if (scrollController.position.pixels >= minScroll &&
          scrollController.position.pixels <= maxScroll) {
        setState(() {});
        if (newsApi.lastpage >= currentPage) {
          fetchNews();
        } else {
          print('heloooooo');
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<almontakhabTeamCubit>(
      create: (BuildContext context) =>
          almontakhabTeamCubit()..getalmontakhabTeam(),
      child: BlocConsumer<almontakhabTeamCubit, almontakhabTeamStates>(
          listener: (context, state) {},
          builder: (context, state) {
            File _file;
            var name_team = TextEditingController();
            var almontakhabTeam =
                almontakhabTeamCubit.get(context).almontakhab_team;

            Future<dynamic> uploadImage(File file) async {
              String fileName = file.path.split('/').last;
              FormData formData = FormData.fromMap({
                'type': 'national',
                "image":
                    await MultipartFile.fromFile(file.path, filename: fileName),
                'name': name_team.text
              });

              await almontakhabTeamCubit
                  .get(context)
                  .userSuggest(mydata: formData, context: context);
              print(formData.toString());
              Navigator.pop(context);
            }

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                backgroundColor: Color(0xff20272D),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  "assets/icons/back_arrow.png",
                                  width: 10,
                                  height: (MediaQuery.of(context).size.height -
                                          MediaQuery.of(context).padding.top) *
                                      0.03,
                                )),
                            Spacer(),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                          height: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).padding.top) *
                              0.05,
                          child: clubScreensHeder()),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myArabicText(
                              "المنتخب",
                              18,
                              FontWeight.normal,
                              textColor,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: textColor,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            myArabicText(
                              "٣ من ٣ محدد",
                              12,
                              FontWeight.normal,
                              Colors.grey,
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      almontakhabTeam != null
                          ? Container(
                              height: (MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).padding.top) *
                                  0.55,
                              width: double.infinity,
                              child: GridView.builder(
                                  //                    shrinkWrap: true,
                                  //                    physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 0.9,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 4,
                                  ),
                                  // number of items in your list
                                  itemCount: newsApi.articles.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == newsApi.articles.length) {
                                      return const Center();
                                    } else {
                                      return ChooseNationalScreenItemEdit(
                                          newsApi.articles[index]);
                                    }
                                  }
                                  // itemBuilder: (context, index) {

                                  //   // return ChooseNationalScreenItem(
                                  //   //     almontakhabTeam.data.data[index]);
                                  // }

                                  ),
                            )
                          : const Center(child: CircularProgressIndicator()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 200.w,
                                  child: myArabicText(
                                      'في حالة عدم ظهور فرق الرجوع للصفحة السابقة والدخول مجدداً ',
                                      12,
                                      FontWeight.normal,
                                      Colors.white),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              margin: EdgeInsets.only(top: 10.h),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (ctx, setState) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            title: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery)
                                                        .then((value) {
                                                      setState(() {
                                                        _file =
                                                            File(value.path);
                                                      });
                                                    });
                                                  },
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 100.0.w,
                                                      height: 120.0.h,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color:
                                                                Colors.white),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: _file == null
                                                          ? Image.asset(
                                                              "assets/icons/camera.png")
                                                          : ClipOval(
                                                              child: SizedBox
                                                                  .fromSize(
                                                                size: Size
                                                                    .fromRadius(
                                                                        50), // Image radius
                                                                child:
                                                                    Image.file(
                                                                  File(_file
                                                                      .path),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            )),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: TextField(
                                                    controller: name_team,
                                                    decoration: InputDecoration(
                                                      hintText: "الاسم",
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
                                                      border:
                                                          OutlineInputBorder(
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
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            Directionality(
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                child:
                                                                    AlertDialog(
                                                                  content:
                                                                      Container(
                                                                    height:
                                                                        200.h,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        myArabicText(
                                                                          '  تم ارسال طلبك بنجاح بامكانك اختيار نادي مؤقتا حتى يتم الموافقة على طلبك',
                                                                          22,
                                                                          FontWeight
                                                                              .normal,
                                                                          Colors
                                                                              .white,
                                                                        ),
                                                                        Spacer(),
                                                                        InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await uploadImage(_file);

                                                                            Fluttertoast.showToast(
                                                                                msg: "تم تعديل البيانات بنجاح",
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                gravity: ToastGravity.BOTTOM,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.blue,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            height:
                                                                                50,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              color: textColor,
                                                                            ),
                                                                            child:
                                                                                myArabicText(
                                                                              "تم",
                                                                              12,
                                                                              FontWeight.bold,
                                                                              Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )));
                                                    // await uploadImage(_file);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: textColor,
                                                    ),
                                                    child: myArabicText(
                                                      "ارسل",
                                                      12,
                                                      FontWeight.bold,
                                                      Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                      });
                                },
                                child: Container(
                                  height: (MediaQuery.of(context).size.height -
                                          MediaQuery.of(context).padding.top) *
                                      0.17,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xff283037),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/icons/add.png"),
                                      SizedBox(height: 10.h),
                                      myArabicText(
                                        "اقترح فريقك",
                                        13,
                                        FontWeight.normal,
                                        Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
