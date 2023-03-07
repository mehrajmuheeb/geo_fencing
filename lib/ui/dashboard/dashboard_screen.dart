import 'package:base_flutter/base/base_state.dart';
import 'package:base_flutter/helpers/page_identifier.dart';
import 'package:base_flutter/main.dart';
import 'package:base_flutter/service/geo_fence_service.dart';
import 'package:base_flutter/ui/common/app_bar_widget.dart';
import 'package:base_flutter/ui/common/button.dart';
import 'package:base_flutter/ui/common/input_field.dart';
import 'package:base_flutter/ui/common/rounded_button.dart';
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:base_flutter/ui/dashboard/dashboard_navigator.dart';
import 'package:base_flutter/ui/dashboard/dashboard_view_model.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState
    extends BaseState<DashboardScreen, DashboardViewModel>
    implements DashboardNavigator {

  @override
  AppBarWidget buildAppBar() {
    return AppBarWidget(scaffoldKey, isDashboard: true, title: "Geo Prison",);
  }

  @override
  Widget buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Consumer<DashboardViewModel>(
          builder: (_, __, ___) {
            return Form(
              child: Column(
                children: [
                  const TextView(
                    text: "Location", typeFace: TypeFace.bold, size: 20,),
                  InputField(onTextChange: (value) {
                    viewModel.latitude = value;
                  },
                      labelText: "Latitude",
                      isNumber: true,
                      inputText: viewModel.latitude ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid Latitude";
                        }
                      }),
                  InputField(onTextChange: (value) {
                    viewModel.longitude = value;
                  },
                      labelText: "Longitude",
                      isNumber: true,
                      inputText: viewModel.longitude ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid Longitude";
                        }
                      }),
                  InputField(onTextChange: (value) {
                    viewModel.radius = value;
                  },
                      labelText: "Radius",
                      isNumber: true,
                      inputText: viewModel.radius ?? "",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid radius";
                        }
                      }),

                  const Spacer(),

                  RoundedButton(title: "Start Fencing", onClick: () {
                    viewModel.startGeoFence();
                  }),

                  const SizedBox(height: 20,),

                  RoundedButton(title: "Stop Fencing", onClick: () {
                    viewModel.stopGeoFence();
                  }),

                ],
              ),
            );
          },
        ),
      );
    });
  }

  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() => PageIdentifier.dashboard;

  @override
  void loadPageData({value}) {
    viewModel.initData();
  }

  @override
  Future<bool> provideOnWillPopScopeCallBack() => Future.value(true);

  void observeGeofenceStatus() {
    GeoFencingService.geoFenceStream()?.listen((event) {
      var title = "";
      var description = "";
      if (event == GeofenceStatus.exit) {
        title = "Exit";
        description = "You are exiting from ${viewModel.latitude}, ${viewModel.longitude}";
      } else if(event == GeofenceStatus.enter) {
        title = "Entered";
        description = "You have entered location ${viewModel.latitude}, ${viewModel.longitude}";
      }

      showFlutterNotification(title, description);
    });
  }

  @override
  void onServiceStarted() {
    observeGeofenceStatus();
  }
}
