import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /* Code copied from here 
    https://pub.dev/packages/flutter_local_notifications
  */
  static Future initLocalNotification() async {
    // initialization Settings Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_notification');

    // initialization Settings iOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: ((id, title, body, payload) =>
                null));

    // initialization Settings Linux
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
      defaultActionName: 'Open notification',
    );

    // initialization all settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) => null,
    );
  }

  // showNotification
  static Future showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    /* 
    androidNotificationDetails - holds configuration details specific to Android notifications.
    channel_id - unique identifier for the notification channel
   */
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            icon: 'flutter_logo',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'),
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    /* 
      flutterLocalNotificationsPlugin.show -> Display Notification
      An identifier for the notification. Should be unique for each 
      notification. In this case, it's set to 0
     */

    /* 
      The channel ID is associated with the notification channel and is used 
      for grouping and managing notifications at the system level.
      The identifier (in this case, 0) is associated with a specific 
      notification instance and is used to distinguish individual notifications 
      from each other.
    */
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
