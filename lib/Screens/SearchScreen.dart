import 'package:desiride/DataManager/AppData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController pickuplocation= TextEditingController();
  TextEditingController droplocation= TextEditingController();
  @override
  Widget build(BuildContext context) {

    String placeaddress = Provider.of<AppData>(context).pickuplocation.Placename ?? "";
    pickuplocation.text=placeaddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  )
                ]

            ),
              child: Padding(padding: EdgeInsets.only(left: 25.0, right: 25.0, top:20.0,bottom: 20.0),
                child: Column(
                  children: [
                    SizedBox(height:5.0),
                    Stack(
                      children: [
                        GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back)
                        ),
                        Center(child: Text("Set Drop Off", style: TextStyle(fontSize: 18.0, fontFamily: 'Brand-Bold'),))
                      ],
                    ),
                    SizedBox(height: 16.0,),
                    Row(
                      children: [
                        Image.asset("images/pickicon.png", height: 16.0, width: 16.0,),
                        SizedBox(width: 18.0,),
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: pickuplocation,
                              decoration: InputDecoration(
                                hintText: "PickUp Location",
                                fillColor: Colors.grey[400],
                                border: InputBorder.none,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 11.0),
                              ),
                            ),
                          ),

                        ),
                        )
                      ],
                    ),

                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Image.asset("images/desticon.png", height: 16.0, width: 16.0,),
                        SizedBox(width: 18.0,),
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onTap: () async {
//                                Prediction p = await PlacesAutocomplete.show(context: context, apiKey: 'AIzaSyDeK2i8U1DyB9Nnm_LLYjVLD_U2d5WLI6M',
//                                language: "en", );
                              },
                              controller: droplocation,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                fillColor: Colors.grey[400],
                                border: InputBorder.none,
                                filled: true,
                                isDense: true,
                                contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 11.0),
                              ),
                            ),
                          ),

                        ),
                        )
                      ],
                    )

                  ],
                ),),
          ),

        ],
      ),
    );
  }

}
