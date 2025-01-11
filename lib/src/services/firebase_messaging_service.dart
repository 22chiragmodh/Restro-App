import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Initialize notification channels
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.high,
    playSound: true,
  );
  String? _fcmToken;
  Future<void> initialize() async {
    // Request permission
    await _requestPermission();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Initialize FCM settings
    await _initializeFCM();

    // Get FCM token
    // Get FCM token
    _fcmToken = await _firebaseMessaging.getToken();
    print('==========================================');
    print('FCM Token: $_fcmToken');
    print('==========================================');

    // Save token to your backend
    await _saveTokenToBackend(_fcmToken!);
  }

  Future<void> _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iOSSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iOSSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  Future<void> _initializeFCM() async {
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    // Handle notification open events when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationOpen(message);
    });
  }

  void _handleForegroundMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    print('Notification Data: ${message.data}');
    if (notification != null && android != null) {
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            icon: android.smallIcon,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  void _handleNotificationOpen(RemoteMessage message) {
    // Handle notification tap
    print('Notification opened: ${message.data}');
    // Navigate to specific screen based on data
    print('Notification Title: ${message.notification?.title}');
    print('Notification Body: ${message.notification?.body}');
    print('Notification Data: ${message.data}');
    print('============================================');
    // Navigate to specific screen based on data
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle local notification tap

    // Navigate to specific screen based on payload
    print('==== Tapped Local Notification ====');
    print('Notification Payload: ${response.payload}');
    print('====================================');
  }

  Future<void> _saveTokenToBackend(String token) async {
    // Implement API call to save token
  }

  String? get fcmToken => _fcmToken;
}

// This needs to be a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle background messages
  print('Handling background message: ${message.messageId}');
  print('==== Received Background Notification ====');
  print('Notification Title: ${message.notification?.title}');
  print('Notification Body: ${message.notification?.body}');
  print('Notification Data: ${message.data}');
  print('==========================================');
}
