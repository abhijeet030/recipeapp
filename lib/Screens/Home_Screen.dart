import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:http/http.dart' as http;
import 'package:recipe/Screens/Search_Screen.dart';

import '../model/model.dart';
import 'Recipe_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? text;
  List<Model> list = <Model>[];
  final url =
      'https://api.edamam.com/search?q=food&app_id=31a1843c&app_key=5f9f4dd2f58ae1a7aff5002950153507&from=0&to=100&calories=591-722&health=alcohol-free';

  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
        url: e['recipe']['url'],
        image: e['recipe']['image'],
        source: e['recipe']['source'],
        label: e['recipe']['label'],
        ingredientLines: List<String>.from(e['recipe']["ingredientLines"]),
      );
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                  "So, what we are going to make today ?",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: TextField(
              onChanged: (v) {
                text = v;
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.sp)),
                  filled: true,
                  hintText: 'Search Recipe',
                  fillColor: Colors.grey.withOpacity(0.01),
                  suffixIcon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen(
                                    search: text,
                                  )));
                    },
                    icon: Icon(CupertinoIcons.search),
                  )),
            ),
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
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeScreen(
                                    name: x.label.toString(),
                                    imageUrl: x.image.toString(),
                                    ingredients: x.ingredientLines,
                                    url: x.url.toString(),
                                    source: x.source.toString(),
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
                                    image: NetworkImage(x.image.toString()),
                                  ),
                                  borderRadius: BorderRadius.circular(20.sp),
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
                                    x.label.toString(),
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
    ));
  }
}
