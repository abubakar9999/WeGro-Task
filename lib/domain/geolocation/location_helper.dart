// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class LocationHelper {
//   /*------------------------------------Get Current Location--------------------------*/
//   Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     // if (!serviceEnabled) {
//     //   return Future.error('Location services are disabled.');
//     // }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition();
//   }
//
//   /*------------------------------------Get Location Name--------------------------*/
//   Future<List<Placemark>?> getCityName(Position pos) async {
//     try {
//       List<Placemark> placeMarks = await placemarkFromCoordinates(
//         pos.latitude,
//         pos.longitude,
//       );
//       return placeMarks;
//     } catch (err) {
//       return null;
//     }
//   }
// }
