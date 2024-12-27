import 'dart:convert';
import 'package:email_generator/consts/consts.dart';
import 'package:email_generator/provider/email_provider.dart';
import 'package:email_generator/screens/generated_email.dart';
import 'package:email_generator/screens/settings.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:email_generator/components/drop_down.dart';
import 'package:email_generator/components/gradient_button.dart';
import 'package:email_generator/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EmailGeneratorScreen extends StatefulWidget {
  const EmailGeneratorScreen({super.key});

  @override
  EmailGeneratorScreenState createState() => EmailGeneratorScreenState();
}

class EmailGeneratorScreenState extends State<EmailGeneratorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _recipientNameController = TextEditingController();
  final _senderNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _customSubjectController = TextEditingController();
  String recipientName = '';
  String senderName = '';
  String email = '';
  String customSubject = '';

  String? _selectedSubject;
  String generatedEmail = '';
  bool isLoading = false;
  String prompt = '';

  // Predefined subjects for the dropdown menu
  final List<String> subjects = [
    'Leave',
    'Project Update',
    'Meeting Invitation',
    'Feedback Request',
    'Job Application',
    'Thank You Note',
    'Custom Subject', // Option for custom input
  ];

  // Simulate an API call to ChatGPT to generate dynamic email content
  Future<String> generateEmailContent(String subject) async {
    setState(() {
      isLoading = true;
    });

    // Simulated response from a backend or OpenAI API
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    final apiUrl =
        'https://api-inference.huggingface.co/models/google/flan-t5-large';

    final apiKey =
        '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'; // Replace with your API key

    prompt =
        'Write a professional and formal email based on the following subject: "$subject". The email should include the relevant details associated with the subject, a clear message, and any necessary context to ensure the recipient understands the purpose. The tone should be polite, respectful, and concise, while avoiding redundancy. Ensure the email is structured appropriately, with an introduction, body, and closing statement. Be sure to use appropriate language and address the recipient respectfully.';

    final body = json.encode({
      "inputs": prompt,
      "parameters": {
        "max_length": 1000,
        "temperature": 0.7,
        "top_p": 0.9,
        "repetition_penalty": 2.0,
      }
    });

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        isLoading = false;
      });
      return responseData[0]['generated_text'];
    } else {
      Get.snackbar(
        "⚠️ Error",
        "🤦 Please make sure you've entered correct email & app password",
        colorText: Colors.white,
        backgroundColor: const Color.fromARGB(255, 133, 17, 8),
      );
      return "null";
    }
  }

  // Function to generate the email template
  void generateEmail() async {
    String subject = _selectedSubject == 'Custom Subject'
        ? customSubject
        : _selectedSubject ?? 'No Subject';

    if (subject.isEmpty) {
      setState(() {
        generatedEmail = 'Please provide a subject.';
      });
      return;
    }

    String emailBody = await generateEmailContent(subject);

    int index = emailBody.indexOf(',');
    if (emailBody.contains(',')) {
      emailBody = emailBody.substring(
          subject == "Leave" ? index : index + 2, emailBody.length);
    }
    if (emailBody.toLowerCase().contains("thank you")) {
      int thankIndex = emailBody.toLowerCase().lastIndexOf('thank you');
      emailBody =
          '${emailBody.substring(0, thankIndex)}\n${emailBody.substring(thankIndex)}';
    }
    if (emailBody
        .toLowerCase()
        .contains("i am looking forward to hearing from you")) {
      int index = emailBody
          .toLowerCase()
          .lastIndexOf('i am looking forward to hearing from you');
      emailBody =
          '${emailBody.substring(0, index)}\n\n${emailBody.substring(index)}';
    }
    setState(() {
      generatedEmail = '''
Dear $recipientName,\n
$emailBody

Best regards,
${Provider.of<EmailProvider>(context, listen: false).username}
      ''';
    });
    Get.to(() => GeneratedEmail(
        receiverEmail: email,
        subject: subject,
        generatedEmail: generatedEmail));
  }

  @override
  void initState() {
    super.initState();
    Provider.of<EmailProvider>(context, listen: false).loadEmail();
  }

  @override
  void dispose() {
    super.dispose();
    _senderNameController.clear();
    _recipientNameController.clear();
    _emailController.clear();
    _senderNameController.dispose();
    _recipientNameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            height: double.infinity,
            child: Opacity(
              opacity: opacity,
              child: Image.asset(
                backgroundImagePath, // Make sure to add the image in assets
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphism Effect

          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      title: const Text(
                        '🕊️ F L Y B I R D',
                        style: TextStyle(color: Colors.white),
                      ),
                      actions: [
                        PopupMenuButton(
                            iconColor: Colors.white,
                            color: const Color.fromARGB(255, 37, 11, 83),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            offset: Offset(0, 50),
                            itemBuilder: (context) => <PopupMenuItem>[
                                  PopupMenuItem(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                duration:
                                                    Duration(milliseconds: 250),
                                                child: Settings(),
                                                type: PageTransitionType
                                                    .rightToLeft));
                                      },
                                      child: Text(
                                        '''🔧   Settings''',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ])
                      ],
                    ),
                    // Recipient's Name Text Field
                    GlassmorphicTextField(
                      prefixIcon: Text(
                        "🧑",
                        style: TextStyle(fontSize: 30),
                      ),
                      controller: _recipientNameController,
                      labelText: "Recipient's Name",
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),

                    // Email Text Field
                    GlassmorphicTextField(
                      prefixIcon: Text(
                        "📧",
                        style: TextStyle(fontSize: 30),
                      ),
                      controller: _emailController,
                      labelText: "Recipient's Email",
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
                    // Dropdown for subject selection
                    GlassmorphicDropdown(
                      value: _selectedSubject,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSubject = newValue;
                          if (_selectedSubject != 'Custom Subject') {
                            _customSubjectController.clear();
                          }
                        });
                      },
                      items: subjects.map<DropdownMenuItem<String>>(
                        (String subject) {
                          return DropdownMenuItem<String>(
                            value: subject,
                            child: Text(
                              subject,
                              style: TextStyle(
                                  fontSize: 16.5,
                                  fontFamily:
                                      GoogleFonts.playfair().fontFamily),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                    // Custom subject input field
                    if (_selectedSubject == 'Custom Subject')
                      GlassmorphicTextField(
                        controller: _customSubjectController,
                        labelText: 'Enter Your Subject',
                      ),
                    const SizedBox(height: 20),
                    Consumer<EmailProvider>(
                        builder: (context, EmailProvider provider, child) {
                      return GradientButton(
                        icon: "✍️ ",
                        text: "Generate Email",
                        onpressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              senderName = _senderNameController.text;
                              email = _emailController.text;
                              recipientName = _recipientNameController.text;
                              customSubject = _customSubjectController.text;
                            });
                            generateEmail();
                            FocusScope.of(context).unfocus();
                            _senderNameController.clear();
                            _emailController.clear();
                            _recipientNameController.clear();
                            _customSubjectController.clear();
                          }
                        },
                      );
                    }),
                    SizedBox(height: 100),
                    isLoading
                        ? Center(
                            child: Column(
                            children: [
                              Lottie.asset(
                                  height: 100, "./assets/lottie/loading.json"),
                              Text("🤔 Writing....",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ))
                        : Text(""),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
