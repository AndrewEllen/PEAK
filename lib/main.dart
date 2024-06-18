import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peak/pages/main/main_page.dart';
import 'package:peak/providers/home/home_feed_provider.dart';
import 'package:peak/providers/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';
// ignore: uri_does_not_exist
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Why WidgetsFlutterBinding is used
  /// https://stackoverflow.com/questions/63873338/what-does-widgetsflutterbinding-ensureinitialized-do
  /// Essentially Flutter is having to call native code so this allows it to interact with the engine.
  await Firebase.initializeApp(
    //ignore: undefined_identifier
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => HomeFeedProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Peak',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
