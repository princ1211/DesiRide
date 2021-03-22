import 'dart:async';

import 'package:desiride/DataManager/AppData.dart';
import 'package:desiride/MapAssistent/FetchData.dart';
import 'package:desiride/Screens/SearchScreen.dart';
import 'package:desiride/Widgets/Divider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String id='main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController NewGMC;
  GlobalKey<ScaffoldState> scafflodkey= new GlobalKey<ScaffoldState>();

  Position current;
  var geolocator= Geolocator();
  double bottompading=0;
  void locate()async{
    Position position= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    current=position;
    LatLng latlngposition=LatLng(position.latitude, position.longitude);
    CameraPosition camposiiton= new CameraPosition(target: latlngposition, zoom: 14);
    NewGMC.animateCamera(CameraUpdate.newCameraPosition(camposiiton));

    String address= await Assistent.searchCoordinateAddress(position,context);
    print(address);

  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafflodkey,
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    Image.asset("images/user_icon.png", height: 65.0,width: 65.0,),
                    SizedBox(height:16.0,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile Name", style: TextStyle(fontSize: 16.0, fontFamily: "Brand-Bold"),),
                        SizedBox(height: 6.0,),
                        Text("Visit Profile", style: TextStyle(),)

                      ],
                    )
                  ],
                ),
              ),
              DividerClass(),
              SizedBox(height: 12.0,),
              ListTile(
                leading: Icon(Icons.history),
                title: Text("History",style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Visit Profile",style: TextStyle(fontSize: 15.0),),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About",style: TextStyle(fontSize: 15.0),),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottompading),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              NewGMC=controller;
              setState(() {
                bottompading=300.0;
              });

              locate();
            },
          ),
          Positioned(
            top: 45.0,
            left: 22.0,
            child: GestureDetector(
              onTap: (){
                scafflodkey.currentState.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7),
                      )
                    ]

                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 320.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7,0.7),
                  )
                ]

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi there, ",style: TextStyle(fontSize: 12.0),),
                    Text("Where to ?", style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold",)),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7,0.7),
                              )
                            ]

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Icon(Icons.search,color: Colors.blueAccent,),
                              SizedBox(width: 10.0,),

                              Text("Search Drop Off"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0,),
                    Row(
                      children: [
                        Icon(Icons.home,
                        color: Colors.grey,),
                        SizedBox(width:12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Provider.of<AppData>(context).pickuplocation !=null
                                ? Provider.of<AppData>(context).pickuplocation.Placename
                            : "Add Home"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text("Your living Home Address", style: TextStyle(
                              color: Colors.black54,fontSize: 12.0,
                            ),),

                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    DividerClass(),
                    SizedBox(height: 16.0,),
                    Row(
                      children: [
                        Icon(Icons.work,
                          color: Colors.grey,),
                        SizedBox(width:12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add Office"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text("Your office Address", style: TextStyle(
                              color: Colors.black54,fontSize: 12.0,
                            ),),

                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),

            ),
          )
        ],
      ),

    );
  }
}
