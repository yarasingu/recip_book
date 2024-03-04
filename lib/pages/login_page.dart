// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:myapp/services/auth_services.dart';
import 'package:status_alert/status_alert.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  // ignore: library_private_types_in_public_api

  @override
  State<StatefulWidget> createState() {
    return _loginPageState();
  }
}

class _loginPageState extends State<loginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  String? username, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login"),
      ),
      body: SafeArea(child: _buildUi()),
    );
  }

  Widget _buildUi() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginform(),
        ],
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Recip Book",
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),
    );
  }

  Widget _loginform() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.90,
        height: MediaQuery.sizeOf(context).height * 0.30,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: "kminchelle",
                onSaved: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a username";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "user name",
                ),
              ),
              TextFormField(
                initialValue: "0lelplR",
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return "Enter a password";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "password",
                ),
              ),
              _loginbutton(),
            ],
          ),
        ));
  }

  Widget _loginbutton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
      child: ElevatedButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await AuthServices().login(username!, password!);
            if (result) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, "/home");
            } else {
              // ignore: use_build_context_synchronously
              StatusAlert.show(
                context,
                duration: const Duration(seconds: 2),
                title: 'Login Failed',
                subtitle: 'please try again later',
                configuration: const IconConfiguration(
                  icon: Icons.error,
                  color: Colors.red,
                ),
                maxWidth: 260,
              );
            }
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}
