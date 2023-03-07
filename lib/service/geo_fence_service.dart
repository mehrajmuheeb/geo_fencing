import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';

class GeoFencingService {

  static void startService(String longitude, String latitude, String radius) {
    EasyGeofencing.startGeofenceService(
        pointedLatitude: longitude,
        pointedLongitude: latitude,
        radiusMeter: radius,
        eventPeriodInSeconds: 5
    );
  }

  static void stopService() {
    EasyGeofencing.stopGeofenceService();
  }

  static Stream<GeofenceStatus>? geoFenceStream() {
    return EasyGeofencing.getGeofenceStream();
  }

}