import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService with ChangeNotifier {
  Position? _currentPosition;
  String? _currentAddress;

  // Yer məlumatlarını almağa başlamaq üçün metod
  void startGettingLocation() async {
    _currentPosition = await LocationHandler.getCurrentPosition();
    if (_currentPosition != null) {
      _currentAddress = await LocationHandler.getAddressFromLatLng(_currentPosition!);
      notifyListeners();  // UI-ı yeniləmək üçün istifadə edilir
    }
  }

  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
}

abstract class LocationHandler {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;  // Yer xidmətləri aktiv deyil
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;  // İcazə inkar edildi
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;  // İcazə daim inkar edilib
    }

    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<String?> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      return "${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}";
    } catch (e) {
      return null;
    }
  }
}
