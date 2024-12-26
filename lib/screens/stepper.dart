import 'package:email_generator/components/text_field.dart';
import 'package:email_generator/consts/consts.dart';
import 'package:email_generator/provider/email_provider.dart';
import 'package:email_generator/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({super.key});

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
          child: Stack(
            children: [
              Opacity(
                opacity: opacity,
                child: Image.asset(
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                    "./assets/images/background.jpeg"),
              ),
              Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "🕊️ F L Y B I R D",
                      style: TextStyle(color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                  Divider(height: 2.0),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "🙋", style: TextStyle(fontSize: 30.0)),
                      TextSpan(
                          text: "Hi, there\n",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily:
                                  GoogleFonts.playfairDisplay().fontFamily)),
                      TextSpan(text: "🤝", style: TextStyle(fontSize: 20.0)),
                      TextSpan(
                          text:
                              '''   Please provide necessary details in order to proceed and make sure you've internet access.''',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily:
                                  GoogleFonts.playfairDisplay().fontFamily,
                              color: const Color.fromARGB(255, 230, 229, 229))),
                    ])),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 560,
                    child: Stepper(
                      connectorColor: WidgetStatePropertyAll(Colors.deepPurple),
                      connectorThickness: 2,
                      type: StepperType.vertical,
                      currentStep: currentStep,
                      onStepContinue: () => setState(() {
                        if (currentStep < getSteps().length - 1) {
                          if (currentStep == 0) {
                            if (_formKey.currentState?.validate() ?? false) {
                              currentStep += 1;
                            }
                          } else {
                            currentStep += 1;
                          }
                        }
                      }),
                      onStepCancel: currentStep == 0
                          ? null
                          : () => setState(() {
                                currentStep -= 1;
                              }),
                      steps: getSteps(),
                      controlsBuilder:
                          (BuildContext context, ControlsDetails details) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: details.onStepCancel,
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor:
                                    Colors.red, // Cancel button color
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 20),
                            Consumer<EmailProvider>(
                              builder:
                                  (context, EmailProvider provider, child) {
                                return ElevatedButton(
                                  onPressed: currentStep == 4
                                      ? () {
                                          provider.setEmail(
                                              _emailController.text,
                                              _nameController.text,
                                              _passwordController.text);
                                          setState(() {
                                            isLoading = true;
                                          });
                                          Future.delayed(Duration(seconds: 5),
                                              () {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Get.off(
                                                () => EmailGeneratorScreen());
                                          });
                                        }
                                      : details
                                          .onStepContinue, // Disable if email is invalid
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.blue, // Next button color
                                  ),
                                  child: Text(
                                    currentStep == 4 ? 'Confirm' : 'Next',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  isLoading
                      ? Lottie.asset(
                          height: 100, "./assets/lottie/loading.json")
                      : Text(""),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // bool _isEmailValid = false; // Flag to track email validity

  // Function to validate email format
  // bool _validateEmail(String email) {
  //   final emailRegex = RegExp(
  //       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'); // Simple email regex
  //   return emailRegex.hasMatch(email);
  // }
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<Step> getSteps() {
    return [
      Step(
        stepStyle:
            StepStyle(color: currentStep == 0 ? Colors.green : Colors.blue),
        content: Column(
          children: [
            Form(
              key: _formKey,
              child: GlassmorphicTextField(
                prefixIcon: Text(
                  "📧",
                  style: TextStyle(fontSize: 30),
                ),
                controller: _emailController,
                labelText: "Enter your email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  // Basic email regex validation
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        title: const Text(
          "Email",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Step(
        stepStyle:
            StepStyle(color: currentStep == 1 ? Colors.green : Colors.blue),
        content: Column(
          children: [
            GlassmorphicTextField(
                controller: _nameController,
                prefixIcon: Text(
                  "🧑",
                  style: TextStyle(fontSize: 30.0),
                ),
                labelText: "Enter your full name"),
            SizedBox(height: 10),
          ],
        ),
        title: const Text(
          "Name",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Step(
        stepStyle:
            StepStyle(color: currentStep == 2 ? Colors.green : Colors.blue),
        content: Column(
          children: [
            Text(
              '''⚠️ Kindly follow these steps otherwise app won't perform it's task''',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            Divider(color: Colors.yellow),
            SizedBox(height: 20),
            Text(
              "👉 Go to 'Manage Your Google Account' setting\n\n👉 Tap on Security\n\n👉 Enable 2-Step Verification if you haven't done so\n\n👉 At the bottom of 2-Step Verification, tap on App Passwords \nOR \nSearch 🔍 'App Passwords' on the search bar\n\n👉 Write the name through which you want to send email 📧\n\n👉 Tap on create\n\n👉 Copy the password",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
          ],
        ),
        title: const Text(
          "Generate App Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Step(
        stepStyle:
            StepStyle(color: currentStep == 3 ? Colors.green : Colors.blue),
        content: Column(
          children: [
            GlassmorphicTextField(
              controller: _passwordController,
              prefixIcon: Text(
                "🔐",
                style: TextStyle(fontSize: 30.0),
              ),
              labelText: "Enter the copied password here",
            ),
            SizedBox(height: 10),
          ],
        ),
        title: const Text(
          "App Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Step(
        stepStyle:
            StepStyle(color: currentStep == 4 ? Colors.green : Colors.blue),
        content: Column(
          children: [
            Text(
              "🤔",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
                overflow: TextOverflow.visible,
                "Are you sure the details that you've provided are correct ?",
                style: TextStyle(
                  color: Colors.white,
                )),
            SizedBox(height: 10),
          ],
        ),
        title: const Text(
          "Confirm",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];
  }
}
