import 'dart:convert';
import 'package:base_flutter/data/models/location/location_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin AuthMixin {

  static const String LATITUDE = "latitude";
  static const String LONGITUDE = "longitude";
  static const String RADIUS = "radius";

  Future<void> saveDetails(String latitude, String longitude, String radius) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(LATITUDE, latitude);
    prefs.setString(LONGITUDE, longitude);
    prefs.setString(RADIUS, radius);
  }

  Future<LocationData> getDetails() async {
    var prefs = await SharedPreferences.getInstance();
    return LocationData(
      latitude: prefs.getString(LATITUDE),
      longitude: prefs.getString(LONGITUDE),
      radius: prefs.getString(RADIUS)
    );
  }

  Future<void> clearToken() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(LATITUDE);
    prefs.remove(LONGITUDE);
    prefs.remove(RADIUS);
  }

}