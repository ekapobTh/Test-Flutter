import 'package:english_words/english_words.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../config/config.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Color appRedColor = Color(0xFFCF1F2F);

  Widget build(BuildContext context) => Scaffold(
      body: Stack(children: [myMainHeader(), myMainTopic(), inputUI()]));

  Widget myMainHeader() => Scaffold(
        appBar: AppBar(
          backgroundColor: appRedColor,
          centerTitle: true,
          title: const Text(
            'Login',
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 35, color: Colors.white),
          ),
        ),
      );

  Widget myMainTopic() => Positioned.fill(
        top: 150, // adjust the top position of the icon
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            'SCM',
            style: TextStyle(
              fontSize: 110.0,
              fontWeight: FontWeight.bold,
              color: appRedColor,
            ),
          ),
        ),
      );

  Widget inputUI() => Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 425, bottom: 5),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: TextField(
                      autofocus: false,
                      controller: userNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        labelStyle: TextStyle(color: Color(0xFFC3C3C3)),
                        hoverColor: Colors.grey,
                        filled: true,
                        fillColor: Color(0xFFE3E3E3),
                        prefixIcon: Icon(Icons.account_circle,
                            color: Color(0xFFC3C3C3)),
                        focusColor: Colors.green,
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        labelStyle: TextStyle(color: Color(0xFFC3C3C3)),
                        hoverColor: Colors.grey,
                        filled: true,
                        fillColor: Color(0xFFE3E3E3),
                        prefixIcon: Icon(Icons.lock, color: Color(0xFFC3C3C3)),
                      ),
                    )),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  print("Forgot Password");
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: appRedColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 35, bottom: 5),
            child: Column(
              children: [
                ElevatedButton(
                  child: Text('Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  onPressed: () {
                    print("Login");
                  },
                  style: ElevatedButton.styleFrom(
                      primary: appRedColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        ]),
      );

  void ShowErrorDialog() {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      text: "Incorrect username or password",
    );
  }

  Future login(String userName, String password) async {
    if (userName.isEmpty || password.isEmpty) {
      ShowErrorDialog();
      print("EIEI");
      return;
    }
    final response = await http.post(
      Uri.parse('${Config.apiEndpoint}login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': userName.toLowerCase(),
        'password': password,
      }),
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      ShowErrorDialog();
      return;
    }
    final Map parsed = json.decode(response.body);
    final storage = FlutterSecureStorage();
    await storage.write(key: "access_token", value: parsed["data"]["token"]);

    // Config.authToken = parsed["data"]["token"];
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('username', userName.toLowerCase());
    // prefs.setString('password', password);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
