import 'package:email_generator/components/text_field.dart';
import 'package:email_generator/consts/consts.dart';
import 'package:email_generator/provider/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _newNameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: Image.asset(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                fit: BoxFit.cover,
                "./assets/images/background.jpeg"),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              '🔧  S E T T I N G S',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
          ),
          Consumer<EmailProvider>(
              builder: (context, EmailProvider provider, child) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      "Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      tileColor: Colors.white.withAlpha((0.4 * 255).toInt()),
                      title: Text(
                        "👦 Name",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        '''      ${provider.username}''',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 214, 214, 214),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 37, 11, 83),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(
                                    '''✍️  Change Name''',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: GlassmorphicTextField(
                                    controller: _newNameController,
                                    labelText: "Enter new name",
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _newNameController.clear();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          provider.setNewUserName(
                                              _newNameController.text);
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          _newNameController.clear();
                                        },
                                        child: Text(
                                          "Confirm",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ]);
                            });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      tileColor: Colors.white.withAlpha((0.4 * 255).toInt()),
                      title: Text(
                        "📨 Email",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        '''      ${provider.email}''',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 214, 214, 214),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 37, 11, 83),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(
                                    '''✍️  Change Email''',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: GlassmorphicTextField(
                                    labelText: "Enter new email",
                                    controller: _newEmailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Email is required";
                                      }
                                      // Basic email regex validation
                                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return "Enter a valid email";
                                      }
                                      return null;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _newEmailController.clear();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          provider.setNewEmail(
                                              _newEmailController.text);
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          _newEmailController.clear();
                                        },
                                        child: Text(
                                          "Confirm",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ]);
                            });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      tileColor: Colors.white.withAlpha((0.4 * 255).toInt()),
                      title: Text(
                        "🔑 App Password",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        isVisible
                            ? '''      ${provider.password}'''
                            : '''      *************''',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 214, 214, 214),
                        ),
                      ),
                      trailing: TextButton(
                          onPressed: () {
                            setState(() {
                              if (isVisible) {
                                isVisible = false;
                              } else {
                                isVisible = true;
                              }
                              // isVisible = true;
                            });
                          },
                          child: Text(
                            isVisible ? "🐈" : "🙈",
                            style: TextStyle(fontSize: 20.0),
                          )),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 37, 11, 83),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text(
                                    '''✍️  Change App Password''',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  content: GlassmorphicTextField(
                                    labelText: "Enter new app password",
                                    controller: _newPasswordController,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          _newPasswordController.clear();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          provider.setNewPassword(
                                              _newPasswordController.text);
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          _newPasswordController.clear();
                                        },
                                        child: Text(
                                          "Confirm",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ]);
                            });
                      },
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  bool isVisible = false;
}
