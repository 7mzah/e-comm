import 'package:firebase_ecom/View/home_view.dart';
import 'package:firebase_ecom/providers/carousel_provider.dart';
import 'package:firebase_ecom/providers/categoryProvider.dart';
import 'package:firebase_ecom/providers/brand_provider.dart'; // Import BrandProvider
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Controller/home_controller.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<BrandProvider>(
          // Add BrandProvider
          create: (context) => BrandProvider(),
        ),
        ChangeNotifierProvider<CarouselProvider>(
          create: (context) => CarouselProvider(),
        ),
        Provider<HomeController>(
          create: (_) => HomeController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
