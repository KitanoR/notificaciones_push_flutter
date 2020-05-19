
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token){
      print('====== FCM token ====');
      print(token);

      // cAFZiN4TzQ4:APA91bEONzSamua1tAieck-7hxywkcNZ_tC_GT7lx2xBnyr5d6cnGbpJLr5gHvq8vmoT5GPZ0pm866NmUMqIYM5ROI90Umqub0n4nEJVEak8mQBWMbXkXcLTnc8HQFvgITHRT3FpgM74

    });

    _firebaseMessaging.configure(
      onMessage: (info) async {
        print('======= on menssage ===');
        print(info);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
      },
      onLaunch: (info) async {
        print('======= on launch ===');
        print(info);
       
      },
      onResume: (info) async {
        print('======= on resume ===');
        print(info);
        final noti = info['data']['comida'];
        print(noti);
        String argumento = 'no-data';
        if(Platform.isAndroid){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        _mensajesStreamController.sink.add(argumento);
      }
    );
  }

  dispose(){
    _mensajesStreamController?.close();
  }
}