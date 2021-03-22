import 'package:desiride/Screens/Register.dart';
import 'package:desiride/Widgets/CustomTextField.dart';
import 'package:desiride/Widgets/MessageDisplay.dart';
import 'package:desiride/Widgets/Progressbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'MainScreen.dart';
import 'PhoneLog.dart';

class LoginScreen extends StatelessWidget {
  static const String StringId = "login";
  TextEditingController Loginemail = TextEditingController();
  TextEditingController LoginPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 35.0,),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(height: 1.0,),
              Text(
                "Login as a Rider",
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "Brand-Bold",

                ),
                textAlign: TextAlign.center,
              ),
              Padding(padding: EdgeInsets.all(20.0),
                child: Column(
                    children: [
                      SizedBox(height: 1.0,),
                      CustomTextField(
                        label: "Email", obstext: false, data: Loginemail,),
                      SizedBox(height: 1.0,),
                      CustomTextField(
                        label: "Password", obstext: true, data: LoginPassword,),
                      SizedBox(height: 10.0,),
                      RaisedButton(
                          color: Colors.yellow,
                          textColor: Colors.white,
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Brand-Bold",
                                ),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0),
                          ),
                          onPressed: () {
                            if (!Loginemail.text.contains("@")){
                              displaymessage("Email Address Invalid  ", context);
                            }
                            else if(LoginPassword.text.isEmpty ){
                              displaymessage("Password is mandatory", context);
                            }
                            else{
                              loginandauthenticate(context);
                            }

                          }
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(
                        thickness: 2.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            RaisedButton(
                                color: Colors.yellow,
                                textColor: Colors.white,
                                child: Container(
                                  height: 25.0,
                                  child: Center(
                                    child: Text(
                                      "Google",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: "Brand-Bold",
                                      ),
                                    ),
                                  ),
                                ),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(24.0),
                                ),
                                onPressed: () {
                                  print("Google login is cliked");
                                }

                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(

                                  color: Colors.yellow,
                                  textColor: Colors.white,
                                  child: Container(
                                    height: 25.0,
                                    child: Center(
                                      child: Text(
                                        "Phone Number",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Brand-Bold",
                                        ),
                                      ),
                                    ),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(
                                        24.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, PhoneLog.id, (route) => false);
                                  }
                              ),
                            ),
                          ],
                        ),
                      )
                    ]

                ),),
              SizedBox(
                height: 5.0,
              ),
              FlatButton(onPressed: () {
                print("Register");
                Navigator.pushNamedAndRemoveUntil(
                    context, RegisterScreen.id, (route) => false);
              },
                  child: Text("Do not have an account? Register Here"))
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  void loginandauthenticate(BuildContext context) async {
    showDialog(context: context,
    barrierDismissible: false,
    builder: (BuildContext context){
      return ProgressDialog(message: "Authenticating, Please wait...",);
    });



    final User firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
        email: Loginemail.text, password: LoginPassword.text).catchError((errMsg){
          Navigator.pop(context);
      displaymessage("Error :-"+ errMsg.toString(), context);
    })).user;
    if (firebaseUser != null) {
      Map userdata = {

        "email": Loginemail.text.trim(),
      };
      userref.child(firebaseUser.uid).once().then(
          (DataSnapshot snap) {
        if (snap.value != null) {
          displaymessage("you are logged-in now!", context);
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.id, (route) => false);
        }
        else {
          displaymessage("No record Found! Please create new account.", context);
          Navigator.pop(context);
          _firebaseAuth.signOut();
        }
      });


    }
    else
      {
        Navigator.pop(context);
        displaymessage("Error Occurred, can not be signed-in ", context);
      }
  }
}
