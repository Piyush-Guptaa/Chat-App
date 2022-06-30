import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/src/provider.dart';

class OtpScreen extends StatefulWidget {
  String phoneNumber;

  OtpScreen(this.phoneNumber, {Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Color bcolor = const Color.fromRGBO(211, 212, 227, 1);
  String otpCode = '';
  late bool code;
  @override
  void initState() {
    // print("initial state called");
    startTimer();
    secondsRemaining = 30;
    enableResend = false;
    super.initState();
    // context.read<AuthProvider>().generateOtp(widget.phoneNumber);
    _controller = AnimationController(vsync: this);
  }

  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // print(timer);
      if (secondsRemaining != 0) {
        setState(() => secondsRemaining = secondsRemaining - 1);
      } else {
        setState(() {
          enableResend = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    _controller.dispose();
  }

  @override
  

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "+91 ${widget.phoneNumber}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(6, 7, 87, 1),
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 27),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: const TextStyle(fontSize: 20),
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 20,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                onCompleted: (otp) {
                  print(otp);
                  setState(() {
                    bcolor = Colors.green;
                    otpCode = otp;
                  });
                  code = true;
                  // context.read<AuthProvider>().verifyOtp(otp, context);
                  // context.read<AuthProvider>().loginWithoutLogin(
                  //       widget.phoneNumber,
                  //       context,
                  //     );
                },
              ),

              const SizedBox(height: 30),
              SizedBox(
                height: 52, //height of button
                width: 296, //width of button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: bcolor, //background color of button
                      //border width and color
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(20)),
                  onFocusChange: (code) {
                    ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(121, 0, 135, 1),
                    );
                  },
                  onPressed: (otpCode != null)
                      ? () {
                          // context
                          //     .read<AuthProvider>()
                          //     .verifyOtp(otpCode, context);
                        }
                      : null,
                  child: const Text("Verify",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                child: Text("RESEND CODE " + secondsRemaining.toString()),
                onPressed: enableResend ? () => initState() : null,

              ),
              const SizedBox(height: 42),
              const Text(
                "By signing up, you agree to our Terms and Conditions and Privacy Policy.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(6, 7, 87, 1),
                  fontSize: 11,
                ),
              )


            ],
          ),)
      ),
    );
  }
}
