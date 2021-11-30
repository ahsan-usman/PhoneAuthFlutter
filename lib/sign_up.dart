import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'welcome.dart';

enum LoginScreen{
  SHOW_MOBILE_ENTER_WIDGET,
  SHOW_OTP_FORM_WIDGET
}
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController  phoneController = TextEditingController();
  TextEditingController  otpController = TextEditingController();

  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationID = "";

  void SignOutME() async{
    await _auth.signOut();
  }
  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async
  {

    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if(authCred.user != null)
      {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Welcome()));
      }
    }     on FirebaseAuthException catch (e) {

      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }

  showMobilePhoneWidget(context){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "images/loginimg.png"
                  ),
                  fit: BoxFit.cover,
                )
            ),
          ),

          Container(
            child: Text(
              "Let's get started",
              style: TextStyle(
                fontSize:40 ,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 20,),
          Text(
            "Phone Authentication Demo",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Poppins',
              color: Colors.grey[500],
            ),
          ),


          SizedBox(height: 40,),
          Text("Verify Your Phone Number"
            , style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 30,),

          Center(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Colors.deepOrangeAccent,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),
                  hintText: "Enter Your Phone Number"
              ),
            ),
          ),

          SizedBox(height: 30,),
          Container(
           height: 60.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: AssetImage(
                      "images/loginbtn.png"
                  ),
                  fit: BoxFit.cover,
                )
            ),

            child: GestureDetector(
              onTap: () async{
                await _auth.verifyPhoneNumber(
                    phoneNumber: "+92${phoneController.text}",
                    verificationCompleted: (phoneAuthCredential) async{
                    },
                    verificationFailed: (verificationFailed){
                      print(verificationFailed);
                    },
                    codeSent: (verificationID, resendingToken) async{
                      setState(() {
                        currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
                        this.verificationID = verificationID;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationID) async{
                    }
                );
              },
              child: Center(
                child: Text(
                  "Send OTP",
                  style: TextStyle(
                    fontSize: 30 ,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16,),
          Spacer()
        ],
      ),
    );
  }

  showOtpFormWidget(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),

        Text(
          "Verification",
          style: TextStyle(
            fontSize:40 ,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 20,),

        Text(
          "Enter your OTP",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            color: Colors.grey[500],
          ),
        ),

        SizedBox(height: 30,),

        Center(
            child: TextField(
              controller:  otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone, color: Colors.deepOrangeAccent,),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30) ),
                  hintText: "Enter Your OTP"
              ),
            ),
        ),
        SizedBox(height: 20,),

        Container(
          height: 60.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: AssetImage(
                    "images/loginbtn.png"
                ),
                fit: BoxFit.cover,
              )
          ),

          child: GestureDetector(
            onTap: () {
              AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);
              signInWithPhoneAuthCred(phoneAuthCredential);
            },
            child: Center(
              child: Text(
                "Sign in",
                style: TextStyle(
                  fontSize: 30 ,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Spacer()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET ? showMobilePhoneWidget(context) : showOtpFormWidget(context),
    );


  }
}