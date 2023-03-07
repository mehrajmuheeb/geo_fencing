import 'package:base_flutter/data/network/api/web.dart';
import 'package:base_flutter/data/network/api_end_points.dart';
import 'package:base_flutter/data/network/services/base_api_service.dart';
import 'package:base_flutter/data/network/services/network_api_service.dart';
import 'package:flutter/material.dart';

class WebApiImpl implements WebApi {
  final BaseApiService _apiService = NetworkApiService();


}
