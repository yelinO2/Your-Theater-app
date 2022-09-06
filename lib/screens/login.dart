import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  dynamic setName;
  dynamic setPassword;
  bool hidePassword = true;
  bool validate = false;

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      setName = sharedPreferences.getString('name');
      setPassword = sharedPreferences.getString('password');
    });

    // debugPrint(setName);
    // debugPrint(setPassword);
  }

  void login() {
    final bool? isValid = formKey.currentState?.validate();
    if (isValid == true) {
      Navigator.pushNamed(context, '/home');
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
              const Center(
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  autovalidateMode: validate
                      ? AutovalidateMode.always
                      : AutovalidateMode.onUserInteraction,
                  validator: (name) {
                    getValidationData();
                    if (name != setName) {
                      return "Invalid username";
                    }

                    return null;
                  },
                  // onChanged: (text) => setName = text,
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
                  obscureText: hidePassword,
                  autovalidateMode: validate
                      ? AutovalidateMode.always
                      : AutovalidateMode.onUserInteraction,
                  validator: (password) {
                    getValidationData();
                    if (password != setPassword) {
                      return 'Invalid password';
                    }
                    return null;
                  },
                  // onChanged: (text) => setPassword = text,
                  decoration: InputDecoration(
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
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      validate = true;
                    });
                    // getValidationData();
                    login();
                  },
                  child: const Text('Log in'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New user?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('Sign up'),
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
