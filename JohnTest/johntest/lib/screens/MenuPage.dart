import 'package:english_words/english_words.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:johntest/models/user.dart';
import 'dart:convert';

import '../config/config.dart';
import 'package:http/http.dart' as http;

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final double profileHeight = 144;

  String _nickName = 'null';

  String _firstName = '';
  String _lastName = '';

  String _userId = '';

  User? _currentUser;

  @override
  void initState() {
    super.initState();

    GetData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: const Text(
            'Home',
            style: const TextStyle(
                fontWeight: FontWeight.w700, fontSize: 35, color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              top: 150, // adjust the top position of the icon
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _currentUser != null ? _currentUser!.data.fullName : "null",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/main_cover.png',
                width: 50,
                height: 120,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 70, // adjust the top position of the icon
              left: 20, // adjust the left position of the icon
              child: InkWell(
                  child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
                child: _currentUser!.data.profilePicture.isNotEmpty
                    ? CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        backgroundImage: _currentUser!.data.profilePicture == ""
                            ? null
                            : NetworkImage(_currentUser!.data.profilePicture),
                        radius: profileHeight / 2,
                        child: _currentUser!.data.profilePicture == ""
                            ? const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 100,
                              )
                            : null,
                      )
                    : const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
              )),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          // shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.red,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2.1,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.white,
                        iconSize: 26,
                        icon: Icon(Icons.home),
                        onPressed: () {
                          print("home");
                          // TODO: implement menu button functionality
                        },
                      ),
                      Text(
                        'Home',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              // SizedBox(width: 130, height: 8.0),
              Container(
                color: Colors.white,
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 2.1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.red,
                        iconSize: 26,
                        icon: Icon(Icons.search),
                        onPressed: () {
                          print("search");
                        },
                      ),
                      Text(
                        'Search',
                        style: TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future<void> GetData() async {
    final storage = FlutterSecureStorage();
    var accessToken = await storage.read(key: 'access_token');
    final response = await http.get(
      Uri.parse('${Config.apiEndpoint}overview'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode != 200) {
      await storage.deleteAll();
      print("GetOverview error");
    } else {
      print("GetOverview ${response.body}");
      User user = userFromJson(response.body);
      String _fullname = user.data.fullName;

      List<String> splitNames = _fullname.split(" ");
      _currentUser = user;
      setState(() => MenuPage());
    }
  }
}
