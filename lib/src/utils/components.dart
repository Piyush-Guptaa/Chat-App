import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/src/pages/call.dart';
import 'package:video_call/src/pages/join.dart';

// This implements the animation on the homepage
class Anime extends StatelessWidget {
  const Anime({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width,
      width: size.width,
      child: Lottie.asset(
        'assets/lottie/meet1.json',
        fit: BoxFit.cover,
      ),
    );
  }
}

//implements the join meeting button
class JoinMeetingButton extends StatelessWidget {
  const JoinMeetingButton({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => JoinPage())),
      child: Container(
          height: 35,
          width: 160,
          decoration: isDark
              ? BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5.0,
                          spreadRadius: 3.0)
                    ])
              : BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 5.0, spreadRadius: 5.0)
                ]),
          child: Center(
            child: Text('Join with Meet ID',
                style: TextStyle(
                  color: isDark ? Colors.grey[400] : Colors.black,
                  letterSpacing: 1.0,
                )),
          )),
    );
  }
}

//implements the new meeting button
class NewMeetButton extends StatelessWidget {
  const NewMeetButton({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () => showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).cardColor, //Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (builder) {
              return Container(
                height: size.width * 0.60,
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100))),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 4.5,
                      width: 55,
                      decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FlatButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(Icons.link),
                                      SizedBox(width: 10),
                                      Text('Get a meeting link to share'),
                                    ],
                                  )),
                              FlatButton(
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
                              FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cancel),
                                      SizedBox(width: 10),
                                      Text('cancel'),
                                    ],
                                  )),
                            ])
                      ],
                    )
                  ],
                ),
              );
            }),
        focusColor: Colors.grey[700],
        hoverColor: Colors.grey[700],
        splashColor: Colors.grey[700],
        child: Container(
            height: 35,
            width: 160,
            decoration: isDark
                ? BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            spreadRadius: 3.0)
                      ])
                : BoxDecoration(color: Colors.grey[300], boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 5.0, spreadRadius: 3.0)
                  ]),
            child: Center(
                child: Text('New Meeting',
                    style: TextStyle(
                      color: isDark ? Colors.grey[400] : Colors.black,
                      letterSpacing: 1.0,
                    )))));
  }
}

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
//implements new meeting dialog

class NewMeeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (context) => Container(
        child: Column(),
      ),
      onClosing: () => Navigator.pop(context),
    );
  }
}
