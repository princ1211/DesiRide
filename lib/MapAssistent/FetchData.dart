
import 'package:desiride/DataManager/AppData.dart';
import 'package:desiride/Models/Address.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


class Assistent{
  static Future<String> searchCoordinateAddress(Position position,context) async {
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    String st1, st2, st3,st4;

    UserAddress userpick = new UserAddress();
    userpick.longitude=position.longitude;
    userpick.latitude=position.latitude;

    st2=addresses.first.addressLine;


    userpick.Placename= st2;


    Provider.of<AppData>(context, listen: false).updateLocation(userpick);

    return addresses.first.addressLine;



  }
}
