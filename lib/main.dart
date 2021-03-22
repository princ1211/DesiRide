import 'package:desiride/DataManager/AppData.dart';
import 'package:desiride/Screens/Login.dart';
import 'package:desiride/Screens/MainScreen.dart';
import 'package:desiride/Screens/PhoneLog.dart';
import 'package:desiride/Screens/Register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userref = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>AppData(),
      child: MaterialApp(
        title: 'Desi Rider',

        theme: ThemeData(
          fontFamily: 'Brand-Bold',
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.StringId,
        routes: {
          RegisterScreen.id:(context) => RegisterScreen(),
          MainScreen.id:(context) => MainScreen(),
          LoginScreen.StringId:(context) => LoginScreen(),
          PhoneLog.id:(context) => PhoneLog(),

        },



      ),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      ),

    );
  }
}
