import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache/local_cache_service.dart';
import 'core/navigation/navigation_service.dart';
import 'core/navigation/routes.gr.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  configureInjection();
  LocalCacheService.preferences = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      backgroundColor: Colors.greenAccent,
      radius: 4,
      textPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      position: ToastPosition.bottom,
      animationCurve: Curves.easeIn,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: injection<NavigationService>().navigationKey,
        // home: HomeView(),
        theme: ThemeData.light().copyWith(primaryColor: Color(0xFF0A6C79)),
        onGenerateRoute: Router().onGenerateRoute,
      ),
    );
  }
}
