import 'package:flutter/material.dart';
import 'package:bookhub/custom_textfield.dart';
import 'package:bookhub/services/auth_services.dart';
import 'package:bookhub/screen/login_screen.dart';
class Recovery extends StatefulWidget {
  const Recovery({Key? key}) : super(key: key);

  @override
  State<Recovery> createState() => _RecoveryState();
}

class _RecoveryState extends State<Recovery> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController forgotpassController = TextEditingController();
  final AuthService authService = AuthService();

  void Recoveryid() {
    authService.recoverypass(
      context: context,
      email: emailController.text,
      forgotpass: forgotpassController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 203, 200, 200),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: forgotpassController,
              hintText: 'Enter your recovery code',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: Recoveryid,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.blue),
              textStyle: WidgetStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Reset",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}