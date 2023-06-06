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
  String _nickName = '';

  String _firstName = '';
  String _lastName = '';

  String _userId = '';

  User? _currentUser;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(children: []),
        bottomNavigationBar: BottomAppBar(
          // shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.red,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.white,
                        iconSize: 28,
                        icon: Icon(Icons.home),
                        onPressed: () {
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
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.red,
                        iconSize: 28,
                        icon: Icon(Icons.search),
                        onPressed: () {
                          // TODO: implement menu button functionality
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
}
