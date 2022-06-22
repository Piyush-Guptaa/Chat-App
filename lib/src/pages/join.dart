import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'call.dart';

class JoinPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<JoinPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Join a Meeting', style: TextStyle(color: Colors.grey[700],fontWeight:FontWeight.w400,letterSpacing: 1.0,)),
        leading: InkWell(onTap:()=>Navigator.pop(context),child: Icon(CupertinoIcons.arrow_left, color: Colors.black,)),
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: RaisedButton(
              onPressed: onJoin,
              child: Text('Join'),
              color: Theme.of(context).buttonColor,//Colors.grey[700],
              textColor: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                      errorText:
                          _validateError ? 'Recipients ID is mandatory' : null,
                      border: UnderlineInputBorder(
                       // borderRadius: //BorderRadius.circular(20)
                        borderSide: BorderSide(width: 1),
                       ),
                      hintText: 'Meeting ID',
                    ),
                  ))
                ],
              ),
              // Column(
              //   children: [
              //     ListTile(
              //       title: Text(ClientRole.Broadcaster.toString()),
              //       leading: Radio(
              //         value: ClientRole.Broadcaster,
              //         groupValue: _role,
              //         onChanged: (ClientRole value) {
              //           setState(() {
              //             _role = value;
              //           });
              //         },
              //       ),
              //     ),
              //     ListTile(
              //       title: Text(ClientRole.Audience.toString()),
              //       leading: Radio(
              //         value: ClientRole.Audience,
              //         groupValue: _role,
              //         onChanged: (ClientRole value) {
              //           setState(() {
              //             _role = value;
              //           });
              //         },
              //       ),
              //     )
              //   ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 20),
              //   child: Row(
              //     children: <Widget>[
              //       Expanded(
              //         child: RaisedButton(
              //           onPressed: onJoin,
              //           child: Text('Join'),
              //           color: Colors.blueAccent,
              //           textColor: Colors.white,
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: ClientRole.Audience//_role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
