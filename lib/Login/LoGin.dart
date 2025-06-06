import 'package:flutter/material.dart';
import 'package:newz_app/Home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LOGIN",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      backgroundColor: Colors.black, // Optional: Dark background
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Text(
              "WELCOME !!",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            const SizedBox(height: 100),

            // Email Field
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(39),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextField(
                controller: password,
                obscureText: true,
                obscuringCharacter: "*",
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter your password",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(23),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Login Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
