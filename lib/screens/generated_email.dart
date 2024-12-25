import 'package:email_generator/components/text_field.dart';
import 'package:email_generator/provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:email_generator/components/gradient_button.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';

class GeneratedEmail extends StatefulWidget {
  final String receiverEmail;
  final String subject;
  final String generatedEmail;
  const GeneratedEmail(
      {super.key,
      required this.receiverEmail,
      required this.subject,
      required this.generatedEmail});

  @override
  GeneratedEmailState createState() => GeneratedEmailState();
}

class GeneratedEmailState extends State<GeneratedEmail> {
  final TextEditingController _bodyController = TextEditingController();
  String changedBody = '';
  @override
  void initState() {
    super.initState();
    _bodyController.text = widget.generatedEmail;
    Provider.of<EmailProvider>(context, listen: false).loadEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 11, 83),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image

          SizedBox(
            height: double.infinity,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                './assets/images/background.jpeg', // Make sure to add the image in assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphism Effect
          Positioned.fill(
            child: Container(
              color: Colors.black
                  .withAlpha((0.5 * 255).toInt()), // Overlay for glassmorphism
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    centerTitle: true,
                    title: Text(
                      "📩 Generated Email",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GlassmorphicTextField(
                    controller: _bodyController,
                    labelText: '',
                    maxLines: 20,
                    onChanged: (newValue) {
                      setState(() {
                        isChanged = true;
                        changedBody = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Consumer<EmailProvider>(builder:
                      (context, EmailProvider provider, Widget? child) {
                    return isLoading
                        ? Column(
                            children: [
                              SizedBox(height: 20),
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                              Text(
                                "⏳ Sending...",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        : GradientButton(
                            icon: "🚀 ",
                            text: "Send",
                            onpressed: () {
                              sendEmail(provider.username, provider.email,
                                  provider.password);
                            });
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isLoading = false;
  bool isChanged = false;
  Future<void> sendEmail(String appname, String email, String password) async {
    final smtpServer = gmail(email, password); // For Gmail

    // Create the email
    final message = Message()
      ..from = Address(email, appname) // Sender email and name
      ..recipients.add(widget.receiverEmail) // Recipient email
      ..subject = widget.subject // Subject of the email
      ..text = isChanged
          ? _bodyController.text
          : widget.generatedEmail; // Plain text body
    // ..html = '<h1>HTML content</h1>'; // Optional HTML content

    try {
      setState(() {
        isLoading = true;
      });
      await send(message, smtpServer);
      // print('Message sent: $sendReport');
      setState(() {
        isLoading = false;
      });
      Get.snackbar("✅ Success", '''😊  Email sent successfully''',
          colorText: Colors.white, backgroundColor: Colors.green);
    } on MailerException catch (e) {
      Get.snackbar(
        "⚠️ Error",
        "🤦 Failed to send email: $e",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      for (var p in e.problems) {
        Get.snackbar(
          "⚠️ Error",
          "🤦 Problem: ${p.code}:${p.msg}",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
      Get.snackbar(
        "⚠️ Error",
        "🤦 Failed to send email",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
