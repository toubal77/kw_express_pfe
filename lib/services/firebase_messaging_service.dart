import 'dart:core';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kw_express_pfe/services/database.dart';
import 'package:kw_express_pfe/utils/logger.dart';

import 'api_path.dart';

class FirebaseMessagingService {
  final Database database;
  final String uid;

  FirebaseMessagingService({required this.database, required this.uid});

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String notificationTitle = '';
  String notificationBody = '';

  Future<void> _configLocalNotification() async {
    final initializationSettingsAndroid =
        AndroidInitializationSettings('icon_appp');
    final initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) {
      // this is for iphone usings ios under 10

      // didReceiveLocalNotificationSubject.add(ReceivedNotification(
      //     id: id, title: title, body: body, payload: payload));
    });
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (dynamic payload) async {
      if (payload != null) {
        //! clicking on the notif callback
        logger.info('onMessage Clicked: ');
        logger.info(payload);
      }
    });
  }

  Future<void> configFirebaseNotification() async {
    //logger.info('configuring FIREBASE MESSAGING');
    _configLocalNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        logger.info('Got a message whilst in the foreground!');
        _showNotification(message.notification);
      }
    });

    await _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((String? newToken) async {
      logger.info('************user token*************');
      logger.info(newToken);
      //oldToken != newToken
      if (true) {
        database.setData(
          path: APIPath.userDocument(uid),
          data: {'token': newToken},
        );
      }
    });
  }

  Future<void> _showNotification(RemoteNotification? message) async {
    if (notificationTitle == message?.title &&
        notificationBody == message?.body) {
      logger.severe('repeated notif cancelling');
      return;
    } else {
      notificationTitle = message?.title ?? '';
      notificationBody = message?.body ?? '';
    }
    final int id = Random().nextInt(1000);
    logger.info('showing local notification called');
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.example.kw_express_pfe'
          : 'com.example.kw_express_pfe',
      'TBL Express',
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      message?.title,
      message?.body,
      platformChannelSpecifics,
    );
  }

  Future<void> removeToken(String uid) async {
    database.setData(
      path: APIPath.userDocument(uid),
      data: {'token': ''},
    );
  }
}
