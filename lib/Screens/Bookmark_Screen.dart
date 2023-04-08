import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe/box/box.dart';
import 'Recipe_Screen.dart';
import 'package:recipe/model/Sava_Data_Model.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<Box<SaveDataModel>>(
      valueListenable: Boxes.getData().listenable(),
      builder: (context, box, _) {
        var data = box.values.toList().cast<SaveDataModel>();
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 83.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 27.w,
                  ),
                  Container(
                    width: 287.w,
                    child: Text(
                      "Your saved recipes.",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 10.h),
                child: GridView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: box.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecipeScreen(
                                        name: data[i].label.toString(),
                                        imageUrl: data[i].image.toString(),
                                        ingredients: data[i].ingredientLines,
                                        url: data[i].url.toString(),
                                        source: data[i].source.toString(),
                                      )));
                        },
                        child: Column(
                          children: [
                            // Card(
                            //   child: Image.network(x.image.toString()),
                            // )
                            Container(
                              // height: 180.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 10.sp,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    height: 120.h,
                                    width: 140.w,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.1),
                                          blurRadius: 10.sp,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            data[i].image.toString()),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(20.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                      width: 140.w,
                                      height: 35.h,
                                      alignment: Alignment.center,
                                      child: Text(
                                        data[i].label,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    ));
  }
}
