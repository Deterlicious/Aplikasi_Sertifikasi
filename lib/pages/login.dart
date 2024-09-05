import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:praktek/pages/home.dart';
import 'package:http/http.dart' as http;

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  // Move handleLogin here, outside the build method.
  Future<void> handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email dan Password harus diisi"),
      ));
      return;
    }

    const String url = "https://api-sertifikasi.vercel.app/api/api/login";
    try {
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text
          }));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      user: emailController.text,
                    )));
      } else {
        final data = jsonDecode(response.body);
        print(data);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          children: [
            _header(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildTextField("Email", emailController, Icons.email, false),
                  const SizedBox(height: 20),
                  _buildTextField(
                      "Password", passwordController, Icons.lock, true),
                  const SizedBox(height: 20),
                  _buildSignInButton(context), // The button now correctly references handleLogin
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function for the header
  Container _header() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      height: 100,
      width: double.infinity,
      child: const Center(
        child: Text(
          "Sign In",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Function to build text fields
  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, bool isPassword) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Function to build Sign In Button
  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: handleLogin, // Now it correctly refers to the function
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 9, 103, 95), // Correct color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
        ),
        child: const Text(
          "Sign In",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
