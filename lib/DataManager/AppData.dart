import 'package:desiride/Models/Address.dart';
import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier{
  UserAddress pickuplocation;
  void updateLocation(UserAddress pickupaddress){
    pickuplocation=pickupaddress;
    notifyListeners();

}
}