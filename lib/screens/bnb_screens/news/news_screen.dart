// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/size_extension.dart';
// import 'package:koora_app/components/colors.dart';
// import 'package:koora_app/components/global_componnets.dart';
// import 'package:koora_app/items/best_safqa.dart';
// import 'package:koora_app/items/commint_item.dart';
// import 'package:koora_app/items/postdata.dart';
// import 'package:koora_app/items/search.dart';
// import 'package:koora_app/reaction/item.dart';
// import 'package:koora_app/reaction/example_data.dart' as Example;
// import 'package:page_transition/page_transition.dart';
//
// import 'commints_screen.dart';
//
// class NewsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var searchController = TextEditingController();
//     FocusNode _focusSearch = new FocusNode();
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: backGroundColors,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: Center(
//           child: AppBar(
//             actions: [
//               Container(
//                 // padding: EdgeInsets.symmetric(horizontal: 20.w,),
//                 child: Image.asset(
//                   "assets/icons/notification_icon.png",
//                   height: 0,
//                 ),
//               ),
//             ],
//             centerTitle: true,
//             title:
//                 myEnglishText('KoORa ZoNE', 18, FontWeight.bold, Colors.white),
//             leading: Container(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 5),
//                     child: CircleAvatar(
//                       radius: 20.r,
//                       backgroundColor: textColor,
//                       child: Padding(
//                         padding: const EdgeInsets.all(1),
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: SizedBox.fromSize(
//                                 size: Size.fromRadius(22),
//                                 child: Image.asset(
//                                   "assets/images/avatar.jpg",
//                                   fit: BoxFit.cover,
//                                 ))),
//                       ),
//                     ),
//                   ),
//                   myEnglishText(
//                     "200",
//                     12,
//                     FontWeight.normal,
//                     Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//             elevation: 0.0,
//             backgroundColor: containerColor,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 15.h,
//             ),
//             Container(
//               height: 40.h,
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: defaultTextField(
//                   foucs: _focusSearch,
//                   controller: searchController,
//                   type: TextInputType.text,
//                   text: 'بحث',
//                   prefix: Icons.search,
//                   onTap: () {},
//                   onSubmit: () {}),
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: containerColor,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         myEnglishText(
//                           "KoORa ZoNE",
//                           13,
//                           FontWeight.bold,
//                           Colors.amber,
//                         ),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         myArabicText('برأيك ما هي الصفقة الافضل هذا الموسم ؟',
//                             16, FontWeight.bold, Colors.white),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         Container(
//                           height: 200.h,
//                           child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: 2,
//                               itemBuilder: (ctx, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20),
//                                   child: safqa(),
//                                 );
//                               }),
//                         ),
//                         // Divider(
//                         //   color: Colors.white.withOpacity(.5),
//                         // ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Container(
//                           child: Row(
//                             children: [
//                               Container(
//                                   height: 30.h, child: Item(Example.reactions)),
//                               // Spacer(),
//                               InkWell(
//
//                                 onTap: (){
//                                   Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: CommintScreen()));
//
//                                 },
//                                 child: Expanded(
//                                   flex: 2,
//                                   child: Container(
//                                     height: 30.h,
//                                     child: Image.asset(
//                                       "assets/icons/commit.png",
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//
//                               // Expanded(
//                               //   flex: 1,
//                               //   child: Container(
//                               //     height: 30.h,
//                               //     child: Image.asset(
//                               //       "assets/icons/stars.png",
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                         ),
//                         Divider(
//                           color: Colors.white.withOpacity(.5),
//                         ),
//                         Row(
//                           children: [
//                             Spacer(),
//                             myArabicText(
//                                 '5 تعليقات', 12, FontWeight.w100, Colors.white)
//                           ],
//                         ),
//                         Container(
//                           padding: EdgeInsets.only(left: 30.w),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   //padding: EdgeInsets.only(right: 20.h),
//                                   child: ClipOval(
//                                     child: CircleAvatar(
//                                       radius: 30.0,
//                                       backgroundImage: NetworkImage(
//                                           'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Karim_Benzema_wearing_Real_Madrid_home_kit_2021-2022.jpg/1200px-Karim_Benzema_wearing_Real_Madrid_home_kit_2021-2022.jpg'),
//                                       backgroundColor: Colors.transparent,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 5.w,
//                               ),
//                               Expanded(
//                                   flex: 7,
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                           decoration: BoxDecoration(
//                                             color: backGroundColors,
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           height: 80.h,
//                                           child: Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 12.w),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 SizedBox(
//                                                   height: 5.h,
//                                                 ),
//                                                 myEnglishText(
//                                                     'mohanad Mortaja',
//                                                     15,
//                                                     FontWeight.w400,
//                                                     Colors.blue),
//                                                 SizedBox(
//                                                   height: 12.h,
//                                                 ),
//                                                 myArabicText(
//                                                     'أكدت العديد من التقارير الصحفية على أن رونالدو طلب الرحيل عن مانشستر يونايتد',
//                                                     11,
//                                                     FontWeight.normal,
//                                                     Colors.white),
//                                               ],
//                                             ),
//                                           )),
//                                     ],
//                                   ))
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15.h,
//                         ),
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 25,
//                               backgroundColor: textColor,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(1),
//                                 child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(20),
//                                     child: SizedBox.fromSize(
//                                         size: Size.fromRadius(22),
//                                         child: Image.asset(
//                                           "assets/images/avatar.jpg",
//                                           fit: BoxFit.cover,
//                                         ))),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: SizedBox(
//                                 height: 50,
//                                 child: TextField(
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: 3,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(50),
//                                       borderSide: BorderSide(
//                                         width: 1.5,
//                                         color: textColor,
//                                       ),
//                                     ),
//
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         width: 1.5,
//                                         color: textColor,
//                                       ),
//                                       borderRadius: BorderRadius.circular(50),
//                                     ),
//                                     hintText: "نص الرسالة",
//                                     hintStyle: TextStyle(
//                                       color: hintTextColor,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 18,
//                                       fontFamily: 'tajawal',
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.only(top: 20, right: 10),
//                                     filled: true,
//                                     fillColor: textFieldColor,
//                                     // border: OutlineInputBorder(
//                                     //     borderSide: BorderSide.none,
//                                     //     borderRadius: BorderRadius.circular(10)),
//                                     suffixIcon: Padding(
//                                       padding: EdgeInsets.only(left: 5),
//                                       child: InkWell(
//                                         onTap: () {},
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           width: 20.0.w,
//                                           height: 20.0.h,
//                                           decoration: BoxDecoration(
//                                             color: Color(0xff3193BC),
//                                             shape: BoxShape.circle,
//                                           ),
//                                           child: Image.asset(
//                                               "assets/icons/send_icon.png"),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                       ],
//                     ),
//                   )),
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//             posts(),
//             Container(
//               child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: 3,
//                   itemBuilder: (ctx, index) {
//                     return posts();
//                   }),
//             )
//             // Expanded(
//
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
