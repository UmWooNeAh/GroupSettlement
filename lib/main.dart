import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:group_settlement/firebase_options.dart';
import 'package:get/get.dart';
import 'dart:async';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GroupSettlement",
      initialRoute: "/",
      initialBinding: BindingsBuilder(() {}),
      theme: ThemeData(primarySwatch: Colors.pink,),
      getPages: [
        GetPage(name: '/',         page: () => const GroupSettlement()),
        GetPage(name: '/HomePage', page: () => const HomePage(),),
      ],
    );
  }
}

class GroupSettlement extends StatefulWidget {
  const GroupSettlement({Key? key}) : super(key: key);

  @override
  State<GroupSettlement> createState() => _GroupSettlement();
}

class _GroupSettlement extends State<GroupSettlement> {
  @override
  void initState(){
    super.initState();

    Timer(
      const Duration(seconds: 1),
      (){
        Get.offAll(
          () => const HomePage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Group Settlement"),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        width: 100,
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}

