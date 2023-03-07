import 'package:base_flutter/helpers/app_state.dart';
import 'package:base_flutter/helpers/service_locator.dart';
import 'package:base_flutter/ui/dashboard/dashboard_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'geo_fence_notifications', // id
    'Geo Fence Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@drawable/ic_launcher');
  const IOSInitializationSettings initializationSettingsDarwin =
  IOSInitializationSettings(
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,);
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void showFlutterNotification(String title, String message) {

  print("Message notification arrived");

  if (message != null) {
    flutterLocalNotificationsPlugin.show(
      message.hashCode,
      "Geo Fence",
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channel.description,
          icon: '@mipmap/ic_launcher',
        ),),
    );
  }
}

Future<void> main() async {
  setupServices();

  WidgetsFlutterBinding.ensureInitialized();

  await setupFlutterNotifications();


  runApp(const BaseApp());
}

class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  final _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DashboardScreen());
  }
}
