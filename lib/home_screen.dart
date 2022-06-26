import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'src/pages/call.dart';


class HomeScreen extends StatefulWidget {
  String phoneNumber;
  HomeScreen(this.phoneNumber , {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to Home Screen'),
            Text('Phone Number: ${widget.phoneNumber}'),
            ElevatedButton(
                                  onPressed: () async {await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: 'piyush123',
            role: ClientRole.Broadcaster//_role,
          ),
        ),);
                                    },
                                  
                                  child: Row(
                                    children: [
                                      Icon(Icons.video_call),
                                      SizedBox(width: 10),
                                      Text('start instant meeting'),
                                    ],
                                  )),
          ],
        ),
      ),
    );
  }
    Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}