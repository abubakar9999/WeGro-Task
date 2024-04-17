import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wegrow_task_flutter/all_bloc_providers.dart';
import 'package:wegrow_task_flutter/presentaion/home_screen/home_page.dart';
import 'package:wegrow_task_flutter/presentaion/splass_screen.dart';
import 'package:wegrow_task_flutter/presentaion/user_auth/login_page.dart';
import 'package:wegrow_task_flutter/presentaion/user_auth/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('login_info');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      
       providers: [...AllBlocProviders.getAllBlocProviders],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const SplashScreen(
                // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
                child: LoginPage(),
              ),
          '/login': (context) => LoginPage(),
          '/signUp': (context) => SingupPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
