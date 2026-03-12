import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart'; // Add to pubspec: crypto: ^3.0.3

// ─────────────────────────────────────────
// MODEL — Encapsulation lives here
// ─────────────────────────────────────────
class UserAuth {
  final String username;
  String _hashedPassword; // 🔒 private
  bool _isLoggedIn = false;
  int _failedAttempts = 0;

  static const int _maxAttempts = 3;

  UserAuth({required this.username, required String password})
      : _hashedPassword = _hashPassword(password);

  // ✅ Only expose what's needed
  bool get isLoggedIn => _isLoggedIn;
  bool get isLocked => _failedAttempts >= _maxAttempts;

  // 🔒 Private static hash — never exposed
  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // ✅ Controlled login
  String login(String inputPassword) {
    if (isLocked) return '🔒 Account locked. Too many failed attempts.';

    if (_hashPassword(inputPassword) == _hashedPassword) {
      _isLoggedIn = true;
      _failedAttempts = 0;
      return '✅ Login successful! Welcome, $username';
    } else {
      _failedAttempts++;
      int remaining = _maxAttempts - _failedAttempts;
      if (remaining <= 0) return '🔒 Account locked!';
      return '❌ Wrong password. $remaining attempt(s) left.';
    }
  }

  // ✅ Controlled password change
  String changePassword(String oldPass, String newPass) {
    if (!_isLoggedIn) return '⚠️ Must be logged in to change password.';
    if (newPass.length < 6) return '⚠️ Password must be at least 6 characters.';

    if (_hashPassword(oldPass) == _hashedPassword) {
      _hashedPassword = _hashPassword(newPass);
      return '✅ Password changed successfully!';
    }
    return '❌ Old password is incorrect.';
  }

  void logout() {
    _isLoggedIn = false;
  }
}

// ─────────────────────────────────────────
// UI
// ─────────────────────────────────────────
void main() => runApp(const AuthApp());

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Pre-registered user (password: "secret123")
  final UserAuth _user = UserAuth(username: 'Alice', password: 'secret123');

  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  String _message = '';

  void _login() {
    setState(() {
      _message = _user.login(_passwordCtrl.text);
    });

    if (_user.isLoggedIn) {
      Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(user: _user),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Center(
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 56, color: Colors.indigo),
                const SizedBox(height: 12),
                const Text('Sign In', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  'Hint: user = Alice, pass = secret123',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
                const SizedBox(height: 24),

                // Username
                TextField(
                  controller: _usernameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 16),

                // Password (encapsulated — never stored in UI state)
                TextField(
                  controller: _passwordCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Message
                if (_message.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: _message.startsWith('✅')
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(_message,
                        style: TextStyle(
                          color: _message.startsWith('✅') ? Colors.green : Colors.red,
                        )),
                  ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _user.isLocked ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(_user.isLocked ? 'Account Locked' : 'Login',
                        style: const TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// HOME SCREEN (after login)
// ─────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  final UserAuth user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  String _changeMsg = '';

  void _changePassword() {
    setState(() {
      _changeMsg = widget.user.changePassword(
        _oldPassCtrl.text,
        _newPassCtrl.text,
      );
      _oldPassCtrl.clear();
      _newPassCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: Text('Welcome, ${widget.user.username}!'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              widget.user.logout();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Change Password',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _oldPassCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _newPassCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'New Password (min 6 chars)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_changeMsg.isNotEmpty)
                      Text(_changeMsg,
                          style: TextStyle(
                            color: _changeMsg.startsWith('✅') ? Colors.green : Colors.red,
                          )),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _changePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Update Password'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Show what's hidden
            Card(
              color: Colors.amber.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('🔐 Encapsulation in Action',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('• _hashedPassword → hidden, never accessible'),
                    const Text('• _failedAttempts → hidden, auto-managed'),
                    const Text('• _isLoggedIn → read-only via getter'),
                    const Text('• _hashPassword() → private method, SHA-256'),
                    const SizedBox(height: 8),
                    Text('isLoggedIn: ${widget.user.isLoggedIn}',
                        style: const TextStyle(color: Colors.indigo)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}