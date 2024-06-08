import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController();
  String _verificationCode = '';
  bool _isCodeSent = false;

  void _sendCode() async {
    final phoneNumber = _phoneNumberController.text;
    final apiId = 'YOUR_API_ID';
    final apiHash = 'YOUR_API_HASH';

    final response = await http.post(
      Uri.parse('https://api.telegram.org/bot<your_bot_token>/sendCode'),
      body: {
        'phone_number': phoneNumber,
        'api_id': apiId,
        'api_hash': apiHash,
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['ok']) {
      setState(() {
        _isCodeSent = true;
      });
    } else {
      // Handle error
    }
  }

  void _verifyCode() async {
    final phoneNumber = _phoneNumberController.text;
    final apiId = 'YOUR_API_ID';
    final apiHash = 'YOUR_API_HASH';
    final verificationCode = _verificationCode;

    final response = await http.post(
      Uri.parse('https://api.telegram.org/bot<your_bot_token>/signIn'),
      body: {
        'phone_number': phoneNumber,
        'api_id': apiId,
        'api_hash': apiHash,
        'verification_code': verificationCode,
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['ok']) {
      // Handle successful login
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Telegram Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            if (_isCodeSent)
              TextField(
                decoration: InputDecoration(labelText: 'Verification Code'),
                onChanged: (value) {
                  setState(() {
                    _verificationCode = value;
                  });
                },
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isCodeSent ? _verifyCode : _sendCode,
              child: Text(_isCodeSent ? 'Verify Code' : 'Send Code'),
            ),
          ],
        ),
      ),
    );
  }
}
