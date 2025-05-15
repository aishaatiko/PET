import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/screens/home_screen.dart';
import 'package:personal_expense_tracker/screens/signup_screen.dart';
import '../services/appwrite_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _message = '';

  @override
  void initState() {
    super.initState();
    _logoutExistingSession();
  }

  Future<void> _logoutExistingSession() async {
    try {
      await AppwriteService.logout();
    } catch (e) {
      // Ignore errors, e.g. no session to logout from
    }
  }

  Future<void> _login() async {
    try {
      await AppwriteService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // final user = await AppwriteService.getCurrentUser();

      if (!mounted) return;

      // Navigate to HomeScreen on success
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      setState(() {
        _message = 'Login failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appwrite Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email')),
            TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                );
              },
              child: const Text("Don't have an account? Sign up"),
            ),
            const SizedBox(height: 8),
            Text(_message),
          ],
        ),
      ),
    );
  }
}
