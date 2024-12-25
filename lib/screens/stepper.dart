import 'package:email_generator/components/text_field.dart';
import 'package:email_generator/provider/email_provider.dart';
import 'package:email_generator/screens/home_page.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: const Color.fromARGB(255, 37, 11, 83),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 25),
          child: Stack(
            children: [
              Opacity(
                opacity: 0.4,
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
                          text: "Hi, there\n\n",
                          style: TextStyle(fontSize: 20.0)),
                      TextSpan(text: "🤝", style: TextStyle(fontSize: 20.0)),
                      TextSpan(
                          text:
                              '''   Please provide necessary details in order to proceed.''',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: const Color.fromARGB(255, 230, 229, 229))),
                    ])),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 700,
                    child: Stepper(
                      connectorColor: WidgetStatePropertyAll(Colors.deepPurple),
                      connectorThickness: 2,
                      type: StepperType.vertical,
                      currentStep: currentStep,
                      onStepContinue: () => setState(() {
                        if (currentStep < getSteps().length - 1) {
                          currentStep += 1;
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
                            ElevatedButton(
                              onPressed: currentStep == 4
                                  ? () {
                                      Provider.of<EmailProvider>(context,
                                              listen: false)
                                          .setEmail(
                                              _emailController.text,
                                              _nameController.text,
                                              _passwordController.text);
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmailGeneratorScreen()));
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
                            ),
                          ],
                        );
                      },
                    ),
                  ),
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

  List<Step> getSteps() {
    return [
      Step(
        stepStyle:
            StepStyle(color: currentStep == 0 ? Colors.green : Colors.blue),
        content: Column(
          children: [
            GlassmorphicTextField(
              prefixIcon: Text(
                "📧",
                style: TextStyle(fontSize: 30),
              ),
              controller: _emailController,
              labelText: "Please enter your email",
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
