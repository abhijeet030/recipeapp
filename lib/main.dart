import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe/Screens/Nav_Home_Screen.dart';
import 'package:hive/hive.dart';
import 'package:recipe/model/Sava_Data_Model.dart';

import 'Screens/Home_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(SaveDataModelAdapter());

  await Hive.openBox<SaveDataModel>('SaveData');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Poppins',
            ),
            home: NavHomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
