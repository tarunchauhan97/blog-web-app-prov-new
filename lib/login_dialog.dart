import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final errorNotifier = ValueNotifier('');
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login'),
            SizedBox(
              height: 10,
            ),
            // Email field
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 10,
            ),
            // Password field
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.blue.shade800),
                ),
                onPressed: () async {
                  final email = emailController.text;
                  final password = passwordController.text;
                  if (email.isEmpty || password.isEmpty) {
                    errorNotifier.value = 'Please enter in Fields';
                    return null;
                  }
                  final userCred = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: email, password: password)
                      .then((value) => Navigator.of(context).pop())
                      .catchError((error) {
                    //errorNotifier.value = error.toString();
                    if (error is FirebaseAuthException) {
                      errorNotifier.value = error.message!;
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ValueListenableBuilder<String>(
                valueListenable: errorNotifier,
                builder: (context, value, child) {
                  if (value.isEmpty) return SizedBox();
                  return Text(value);
                }),
          ],
        ),
      ),
    );
  }
}
