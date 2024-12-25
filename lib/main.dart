import 'package:email_generator/provider/email_provider.dart';
import 'package:email_generator/screens/home_page.dart';
import 'package:email_generator/screens/stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure that widgets are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  runApp(ChangeNotifierProvider(
    create: (_) => EmailProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Provider.of<EmailProvider>(context, listen: false).isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fly Bird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer<EmailProvider>(builder:
          (BuildContext context, EmailProvider provider, Widget? child) {
        if (provider.isLoading) {
          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 37, 11, 83),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Loading",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
              ));
        }

        return provider.isLoggedIn ? EmailGeneratorScreen() : StepperWidget();
      }),
    );
  }
}
