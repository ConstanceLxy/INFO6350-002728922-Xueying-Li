import 'package:camera/camera.dart';
import 'package:finalproject/BrowsePostActivity.dart';
import 'package:finalproject/LoginActivity.dart';
import 'package:finalproject/NewPostActivity.dart';
import 'package:finalproject/PostDetailActivity.dart';
import 'package:finalproject/RegisterActivity.dart';
import 'package:finalproject/TakePictureActivity.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'package:flutter/material.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
 
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
        // your preferred provider. Choose from:
        // 1. Debug provider
        // 2. Device Check provider
        // 3. App Attest provider
        // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp(this.camera, {super.key});

  final CameraDescription camera;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperGarageSale',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginActivity(),
      routes: {
        "new_post_page": (context) => NewPostActivity(),
        "post_detail_page": (context) => PostDetailActivity(),
        "take_page": (context) => TakePictureScreen(camera),
        "show_pic_page": (context) => DisplayPictureScreen(),
        "login_page": (context) => LoginActivity(),
        "register_page": (context) => RegisterActivity(),
        "browse_page": (context) => BrowsePostActivity(),
      },
    );
  }
}
