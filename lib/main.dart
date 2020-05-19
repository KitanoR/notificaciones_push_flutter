import 'package:flutter/material.dart';
import 'package:notificacion_push/src/pages/home_page.dart';
import 'package:notificacion_push/src/pages/mensaje_page.dart';
import 'package:notificacion_push/src/providers/push_notifications_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    final pushProvider = PushNotificationProvider();
    pushProvider.initNotifications();
    pushProvider.mensajes.listen((argumento) { 
      // Navigator.pushNamed(context, 'mensaje');
      print('Argumento del push');
      print(argumento);
      navigatorKey.currentState.pushNamed('mensaje', arguments: argumento);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context ) => HomePage(),
        'mensaje': (BuildContext context ) => MensajePage(),
      },
    );
  }
}



class MyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manejo de push notification'),),
      body: Center(
        child: Text('Hola Mundo caye'),
     ),
   );
  }
}