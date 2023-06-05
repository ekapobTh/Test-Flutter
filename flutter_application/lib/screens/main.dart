import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
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
                      controller: TextEditingController(),
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
                      controller: TextEditingController(),
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
}
