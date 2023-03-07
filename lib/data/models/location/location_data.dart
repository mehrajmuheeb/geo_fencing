class LocationData {
  String? latitude;
  String? longitude;
  String? radius;

  LocationData({this.latitude, this.longitude, this.radius});

  LocationData.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['radius'] = radius;
    return data;
  }
}