import 'package:flutter/material.dart';
// import 'package:video_call/home_screen.dart';

// import 'otp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  final _textController = TextEditingController();
  Color bcolor = Color.fromRGBO(211, 212, 227, 1);
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  final _phoneNumber = GlobalKey<FormState>();
    String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile Number can\'t be empty';
    } else if (value.length < 10) {
      return 'Mobile Number should contain 10 digits.';
    } else if (value.length > 10) {
      return 'Mobile Number can\'t contain more than 10 digits.';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 296,
                    child: TextFormField(
                      style: (const TextStyle(color: Colors.black)),
                      validator: phoneValidator,
                      controller: mobileController,
                      onChanged: (status) {
                        setState(() {
                          bcolor = Color.fromARGB(255, 0, 17, 255);
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        labelText: 'Enter Phone Number',
                        errorText: null,
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 296,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: bcolor, //background color of button
                          //border width and color
                          elevation: 3, //elevation of button
                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.all(
                              20) //content padding inside button
                          ),
                      onPressed: () {
                        var status = _formKey.currentState?.validate();
                        if (status != null && status) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => OtpScreen(
                          //       mobileController.text,
                          //     ),
                          //   ),
                          // );
                        }
                        
                      },
                      child: const Text("Generate OTP"),
                    ),
                  ),
                  TextButton.icon(onPressed: (() {
                    var status = _formKey.currentState?.validate();
                    if (status != null && status) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => HomeScreen(
                      //       mobileController.text,
                      //     ),
                      //   ),
                      // );
                    }
                    
                  }),
                      icon: Icon(Icons.arrow_forward),
                      label: Text("Continue without OTP")),  
              

                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}