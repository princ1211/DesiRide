import 'package:desiride/Screens/Login.dart';
import 'package:desiride/Screens/MainScreen.dart';
import 'package:desiride/Widgets/CustomTextField.dart';
import 'package:desiride/Widgets/MessageDisplay.dart';
import 'package:desiride/Widgets/Progressbar.dart';
import 'package:desiride/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {
  static const String id ="register";
  TextEditingController name= TextEditingController();
  TextEditingController email= TextEditingController();
//  TextEditingController phone= TextEditingController();
  TextEditingController password= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
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
                "Register as a Rider",
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
                      CustomTextField(label: "Name",data: name,obstext: false),
                      SizedBox(height: 1.0,),
                      CustomTextField(label: "Email",data: email,obstext: false,),
                      SizedBox(height: 1.0,),
                      CustomTextField(label: "Password",data: password,obstext: true,),
                      SizedBox(height: 10.0,),
                      RaisedButton(
                          color: Colors.yellow,
                          textColor: Colors.white,
                          child: Container(
                            height: 50.0,
                            child:Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Brand-Bold",
                                ),
                              ),
                            ) ,
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0),
                          ),
                          onPressed:(){
                           registerNewuser(context);
                          }
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Divider(
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RaisedButton(
                                  color: Colors.yellow,
                                  textColor: Colors.white,
                                  child: Container(
                                    height: 25.0,
                                    child:Center(
                                      child: Text(
                                        "Google",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Brand-Bold",
                                        ),
                                      ),
                                    ) ,
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(24.0),
                                  ),
                                  onPressed:(){
                                    print("Google login is cliked");
                                  }

                              ),

                              RaisedButton(

                                  color: Colors.yellow,
                                  textColor: Colors.white,
                                  child: Container(
                                    height: 25.0,
                                    child:Center(
                                      child: Text(
                                        "Phone Number",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontFamily: "Brand-Bold",
                                        ),
                                      ),
                                    ) ,
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(24.0),
                                  ),
                                  onPressed:(){
                                    print("Phone is cliked");
                                  }
                              ),
                            ],
                          ),
                        ),
                      )]

                ),),
              SizedBox(
                height: 2.0,
              ),
              FlatButton(onPressed: (){
                if (email.text.contains("@")){
                  displaymessage("Email Address Invalid  ", context);
                }
                else if(password.text.length<6 ){
                  displaymessage("Password must be atleast 6 characters", context);
                }
                else{
                  Navigator.pushNamedAndRemoveUntil(context,LoginScreen.StringId, (route) => false);
                }

              },
                  child: Text("Already have an account? Login Here"))
            ],
          ),
        ),
      ),
    );;
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewuser(BuildContext context) async{

    showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "Registering, Please wait...",);
        });
    final  User firebaseUser= (await _firebaseAuth.createUserWithEmailAndPassword(email: email.text, password: password.text).catchError((errMsg){
      Navigator.pop(context);
    displaymessage("Error :-"+ errMsg.toString(), context);
    })).user;
    if (firebaseUser !=null){

      Map userdata ={
        "name": name.text.trim(),
        "email": email.text.trim(),
      };
      userref.child(firebaseUser.uid).set(userdata);
     displaymessage("Congratulations! Your account has been created ", context);
      Navigator.pushNamedAndRemoveUntil(context,MainScreen.id, (route) => false);
    }
    else{
      Navigator.pop(context);
      displaymessage("Your account has not been Created", context);
    }

  }

}
//Flutter toast function for displaying the messages

