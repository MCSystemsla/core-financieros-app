import 'dart:convert';
import 'dart:developer';

import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

typedef AndroidLocalNotifcations = AndroidFlutterLocalNotificationsPlugin;

typedef IOSLocalNotifcations = IOSFlutterLocalNotificationsPlugin;

class FirebaseService {
  late final FirebaseMessaging _instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  Future<void> initializeApp() async {
    await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    _instance = FirebaseMessaging.instance;
    await requestPermission();
    await initLocalNotifications();
    FirebaseMessaging.instance.getToken().then((value) async {
      if (LocalStorage().fcmToken.isNotEmpty) return;
      // final fcmRepository = FcmRepositoryImpl();
      // await fcmRepository.saveFcmToken(token: value ?? '-');
      return LocalStorage().setFcmToken(value ?? '-');
    });

    FirebaseMessaging.onMessage.listen((message) => _onMessageHandler(message));
  }

  _onMessageHandler(RemoteMessage message) {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.high,
      priority: Priority.max,
      ticker: 'ticker',
      colorized: true,
      color: AppColors.getPrimaryColor(),
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    _localNotifications.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

  AndroidInitializationSettings _androidSettings() =>
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  DarwinInitializationSettings _iosSettings() =>
      const DarwinInitializationSettings();

  Future<void> requestPermission() async {
    NotificationSettings settings = await _instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> initLocalNotifications() async {
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
    );

    final initializationSettingsAndroid = _androidSettings();
    final initializationSettingsIOS = _iosSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    //creando canal de notificaciones para ANDROID
    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidLocalNotifcations>()
        ?.createNotificationChannel(channel);
    //solicitud de permisos para IOS dado el caso
    await _localNotifications
        .resolvePlatformSpecificImplementation<IOSLocalNotifcations>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    //si se quiere agregar función para presionar notficaciones
    await _localNotifications.initialize(initializationSettings);
  }
}
