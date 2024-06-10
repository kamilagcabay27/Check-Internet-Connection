import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInternet = false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      // print(event);
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isInternet = false;
          });
          break;
        default:
          setState(() {
            isInternet = false;
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _internetConnectionStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isInternet ? Icons.wifi : Icons.wifi_off,
              size: 50,
              color: isInternet ? Colors.green : Colors.red,
            ),
            Text(isInternet ? 'Internet Connected' : 'Internet Disconnected'),
          ],
        ),
      ),
    );
  }
}
