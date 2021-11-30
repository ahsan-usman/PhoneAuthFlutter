import 'package:flutter/material.dart';
import 'package:phone_auth_firebase/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double  w =MediaQuery.of(context).size.width;
    double  h =MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [


          Container(
            width: w,
            height: h*0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "images/signup.png"
                  ),
                  fit: BoxFit.cover,
                )
            ),


          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(

              children: [
                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Welcome to the Home Page",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: Colors.grey[500],
                  ),
                ),

                SizedBox(height: 50,),


              ],
            ),
          ),
          SizedBox(height: 40,),


          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            child: Container(
              width: w*0.5,
              height: h*0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: AssetImage(
                        "images/loginbtn.png"
                    ),
                    fit: BoxFit.cover,
                  )
              ),
              child: Center(
                child: Text(
                  "Sign out",
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
          SizedBox(height: w*0.1,),
        ]
      ),
    );
  }
}