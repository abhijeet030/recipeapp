import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:recipe/Screens/Webview_Screen.dart';
import 'package:recipe/box/box.dart';
import 'package:recipe/model/Sava_Data_Model.dart';

class RecipeScreen extends StatefulWidget {
  final name;
  final imageUrl;
  final ingredients;
  final url;
  final source;
  RecipeScreen(
      {this.name, this.imageUrl, this.ingredients, this.url, this.source});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState(
      name: name,
      imageUrl: imageUrl,
      ingredients: ingredients,
      url: url,
      source: source);
}

class _RecipeScreenState extends State<RecipeScreen> {
  final String name;
  final String imageUrl;
  final String source;
  final String url;
  final List<String> ingredients;
  bool _isbookmarked = false;

  _RecipeScreenState(
      {required this.name,
      required this.imageUrl,
      required this.ingredients,
      required this.source,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 93.h),
            Row(
              children: [
                SizedBox(
                  width: 27.w,
                ),
                Row(
                  children: [
                    Container(
                      width: 287.w,
                      child: Text(
                        name,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          final data = SaveDataModel(
                              image: imageUrl,
                              url: url,
                              source: source,
                              label: name,
                              ingredientLines: ingredients);
                          final box = Boxes.getData();
                          box.add(data);
                          data.save();
                          _isbookmarked = false;
                          // print(box);
                          final snackBar = SnackBar(
                              backgroundColor: Colors.amberAccent,
                              content: const Text('Recipe Saved'),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Icon(
                          _isbookmarked
                              ? CupertinoIcons.bookmark
                              : CupertinoIcons.bookmark_fill,
                          size: 35.sp,
                        ))
                  ],
                )
              ],
            ),
            SizedBox(
              height: 29.h,
            ),
            Container(
              width: 339.w,
              height: 230.h,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10.sp,
                      offset: Offset(0, 4),
                    )
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl),
                  ),
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(20.sp)),
            ),
            SizedBox(
              height: 43.h,
            ),
            Container(
              width: 339.w,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 10.sp,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.sp)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      width: 300.w,
                      child: Text(
                        'Ingredients',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w400),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      width: 300.w,
                      child: Text(
                        ingredients.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 29.h,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyInAppWebView(
                              url: url,
                              name: name,
                            )));
              },
              child: Container(
                width: 339.w,
                height: 50.h,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        blurRadius: 10.sp,
                        offset: Offset(0, 4),
                      )
                    ],
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(20.sp)),
                alignment: Alignment.center,
                child: Text('Want to see Recipe',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
