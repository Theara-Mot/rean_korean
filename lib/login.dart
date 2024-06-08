import 'package:flutter/material.dart';
import 'package:flutter_telegram_login/flutter_telegram_login.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TelegramLogin telegramLogin = TelegramLogin(
    '+855715538000','','Thearamot.epizy.com'
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              children: [
                ElevatedButton(
                    onPressed: telegramLogin.loginTelegram,
                    child: const Text("loginTelegram")
                ),
                ElevatedButton(
                    onPressed: () async {
                      var success = await telegramLogin.checkLogin();
                      print(success);
                    },
                    child: const Text("checkLogin")
                ),
                ElevatedButton(
                    onPressed: () async {
                      var data = await telegramLogin.getData();
                      print(data);
                      if (data) {
                        print(telegramLogin.userData);
                      }
                    },
                    child: const Text("getData")
                ),
                ElevatedButton(
                    onPressed: () async {
                      await telegramLogin.telegramLaunch();
                    },
                    child: const Text("openTelegram")
                ),
              ]
          )
      ),
    );
  }
}
