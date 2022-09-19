import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:koora_app/components/colors.dart';
import 'package:koora_app/components/global_componnets.dart';
import 'package:koora_app/reaction/item.dart';
import 'package:koora_app/reaction/example_data.dart' as Example;




class MassegWithImageItem extends StatefulWidget {

  @override
  _MassegWithImageItemState createState() => _MassegWithImageItemState();
}

class _MassegWithImageItemState extends State<MassegWithImageItem> {

  double rating = 3;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 15),
          child: Row(
            children: [
              Container(
                //  width: MediaQuery.of(context).size.width * 0.6,
                constraints: BoxConstraints(
                  minHeight: 100.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),

                  color: Color(0xff1A1A1A),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xffE6B700),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: SizedBox.fromSize(
                                      size: Size.fromRadius(22),
                                      child: Image.asset(
                                        "assets/images/avatar.jpg",
                                        fit: BoxFit.cover,
                                      ))),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          myEnglishText(
                            "Eng.Walid Khoder",
                            11,
                            FontWeight.bold,
                            Color(0xffE6B700),
                          ),

                       SizedBox(width: 50,),


                      StarRating(
                        rating: rating,
                        onRatingChanged: (rating) => setState(() => this.rating = rating),
                      ),


                        ],
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset("assets/images/massege_image.png" , width: 200,),
                    ),



                    SizedBox(
                      width: 330,
                      child: Padding(
                        padding:  EdgeInsets.only(right: 10.w , bottom: 10.h , left: 5),
                        child: Text(
                          "كريستيانو رونالدو يكمل العودة إلى مانشستر يونايتد يمكن أن نرى تدخل الاتحاد الأوروبي لكرة القدم - ميرور أون لاين",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'tajawal'),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
            top: 17,
            left: 10,

            child: Image.asset("assets/icons/other_part.png")),



        Positioned(
          bottom: 3,
          right: 70,
         // child: Container(height: 30.h, child: Item(Example.reactions)),
        ),
      ],
    );
  }
}


typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating({this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        Icons.star_border,
        size: 15,
        color: textColor,
      );
    }
    else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        Icons.star_half , size: 15,
        color: color ?? textColor,
      );
    } else {
      icon = new Icon(
        Icons.star,
        size: 15,
        color: color ?? textColor,
      );
    }
    return new InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: new List.generate(starCount, (index) => buildStar(context, index)));
  }
}