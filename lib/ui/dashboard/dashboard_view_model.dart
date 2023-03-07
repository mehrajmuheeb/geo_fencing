import 'dart:developer';

import 'package:base_flutter/base/base_view_model.dart';
import 'package:base_flutter/data/models/location/location_data.dart';
import 'package:base_flutter/service/geo_fence_service.dart';
import 'package:base_flutter/ui/dashboard/dashboard_navigator.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';

class DashboardViewModel extends BaseViewModel<DashboardNavigator> {
  String? latitude;
  String? longitude;
  String? radius;
  LocationData? locationData;

  Future<void> initData() async {
    locationData = await getDetails();
    if(locationData == null || locationData?.latitude == null) return;

    latitude = locationData?.latitude;
    longitude = locationData?.longitude;
    radius = locationData?.radius;
    notifyListeners();
  }

  void startGeoFence() {
    if (latitude == null || longitude == null || radius == null) return;
    saveDetails(latitude!, longitude!, radius!);

    GeoFencingService.startService(longitude!, latitude!, radius!);
    getNavigator().onServiceStarted();
  }

  void stopGeoFence() {
    GeoFencingService.stopService();
  }
}
