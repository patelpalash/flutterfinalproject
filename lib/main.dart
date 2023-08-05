import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sem5finalproject/screens/loginscreen.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      title: 'Flutter Employee management',
      // home: KeyboardVisibilityProvider(child: AuthCheck()),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}

// class AuthCheck extends StatefulWidget {
//   const AuthCheck({super.key});

//   @override
//   State<AuthCheck> createState() => _AuthCheckState();
// }

// class _AuthCheckState extends State<AuthCheck> {
//   bool userAvailable = false;
//   late SharedPreferences sharedPreferences;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getCureentUser();
//   }

//   void _getCureentUser() async {
//     sharedPreferences = await SharedPreferences.getInstance();

//     try {
//       if (sharedPreferences.getString('emplyeeId') != "") {
//         setState(() {
//           // User.userName = sharedPreferences.getString('emplyeeId')!;
//           userAvailable = true;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         userAvailable = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text("i am fucked up"),
//     );
//   }
// }
