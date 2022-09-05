import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  dynamic userName;
  dynamic password;
  dynamic confirmPassword;
  bool hidePassword = true;

  void signUp() {
    final bool? isValid = formKey.currentState?.validate();
    if (isValid == true) {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 200),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Creat new account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (name) {
                    if (name == null || name.trim().isEmpty) {
                      return "Username can't be empty";
                    }
                    if (name.length < 4) {
                      return "Username must be at least 4 characters";
                    }
                    return null;
                  },
                  onChanged: (text) => userName = text,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    labelText: 'Please enter your username',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: hidePassword,
                  validator: (txt) {
                    if (txt == null || txt.isEmpty) {
                      return "Invalid password!";
                    }
                    if (txt.length < 8) {
                      return "Password must has 8 characters";
                    }
                    if (!txt.contains(RegExp(r'[A-Z]'))) {
                      return "Password must has uppercase";
                    }
                    if (!txt.contains(RegExp(r'[0-9]'))) {
                      return "Password must has digits";
                    }
                    if (!txt.contains(RegExp(r'[a-z]'))) {
                      return "Password must has lowercase";
                    }
                    if (!txt.contains(RegExp(r'[#?!@$%^&*-+]'))) {
                      return "Password must has special characters";
                    }
                    return null;
                  },
                  onChanged: (value) => password = value,
                  decoration: InputDecoration(
                    hintText: 'Example12?',
                    prefixIcon: const Icon(Icons.password_rounded),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      child: Icon(
                        hidePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Please enter your password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: hidePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    }
                    if (value != password) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  onChanged: (value) => confirmPassword = value,
                  decoration: InputDecoration(
                    hintText: 'Example12?',
                    prefixIcon: const Icon(Icons.password_rounded),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      child: Icon(
                        hidePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Please confirm your password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setString('name', userName);
                    sharedPreferences.setString('password', password);
                    signUp();
                  },
                  child: const Text('Sign up'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text('Log in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
