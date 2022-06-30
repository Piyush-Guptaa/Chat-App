import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class AuthProvider with ChangeNotifier {
  bool _isLoggedin = false;
  bool _loading = true;
  String _name = "";
  String _token = "";
  String _email = "";
  String _mobile = "";
  String _username = "";
  bool get isLoggedin => _isLoggedin;
  String get name => _name;
  String get token => _token;
  String get email => _email;
  String get mobile => _mobile;
  String get username => _username;
  bool get loading => _loading;
  String _verificationId = "";

  // login(Map data) async {
  //   Map? awsUser = await loginToServer(data);
  //   if (awsUser != null) {
  //     setInfos(
  //       awsUser['access'],
  //       "NA",
  //       data['email'] ?? '',
  //       data['mobile'] ?? '',
  //       data['username'],
  //     );
  //   }
  // }



  Future<void> setInfos(String userToken, String name, String email,
      String mobile, String username) async {
    // Create storage
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    await storage.write(key: "token", value: userToken);
    await storage.write(key: "name", value: name);
    await storage.write(key: "email", value: email);
    await storage.write(key: "mobile", value: mobile);
    await storage.write(key: "username", value: username);
    _token = userToken;
    _name = name;
    _email = email;
    _mobile = mobile;
    _username = username;
    if (userToken != "") _isLoggedin = true;
    notifyListeners();
  }

  Future<void> logout() async {
    // Create storage
    const storage = FlutterSecureStorage();
    // Delete all
    await storage.deleteAll();
    _token = _name = _email = _mobile = "";
    _isLoggedin = false;
    notifyListeners();
  }

  Future<void> initAuth() async {
    // Create storage
    const storage = FlutterSecureStorage();
    try {
      _token = await storage.read(key: "token") ?? "";
      _name = await storage.read(key: "name") ?? "";
      _email = await storage.read(key: "email") ?? "";
      _mobile = await storage.read(key: "mobile") ?? "";
      _username = await storage.read(key: "username") ?? "";
    } catch (e) {
      _token = _name = _email = _mobile = "";
      print(e);
    }
    _isLoggedin = _token != "" ? true : false;
    _loading = false;
    // print("log in successful");
    notifyListeners();
  }
  Future<void> generateOtp(String phoneNo) async {
    _verificationId = "";
    final PhoneCodeSent smsOTPSent = (String verId, int? forceCodeResend) {
      _verificationId = verId;
      print("===>" + _verificationId);
    };
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91" + phoneNo,
        codeAutoRetrievalTimeout: (String verId) {
          // Tab Chalega jab auto Verification nahi ho pata hai time rehte, ye bhi humko otp dega
          _verificationId = verId;
        },
        codeSent: smsOTPSent, // runs when OTP is recieved
        timeout:
            const Duration(seconds: 60), // itni derr tak dusra OTP nahi aayega
        verificationCompleted: (AuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException exception) {
          print("-----------------------------------");
          print(exception.message);
          print("firebase varification failed.");
          // Navigator.pop(context, exception.message);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> verifyOtp(String enteredOtp, BuildContext context) async {
    // Create storage
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: enteredOtp,
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User currentUser = _auth.currentUser!;
      assert(authResult.user!.uid == currentUser.uid);
      Map data = {
        'username': currentUser.uid,
        'password': currentUser.uid.hashCode.toString(),
      };
      if (currentUser.email != null) data['email'] = currentUser.email;
      if (currentUser.phoneNumber != null) {
        data['mobile_number'] = currentUser.phoneNumber!.substring(3);
      }
      // await login(data);
      Navigator.pop(context);
    } catch (e) {

      print("---------- varification otp failed. -------------");
      print(e.toString());
    }
    // notifyListeners();
  }
}
