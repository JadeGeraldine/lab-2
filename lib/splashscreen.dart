import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget 
  {@override
   _SplashScreenState createState() => _SplashScreenState();
  }

class _SplashScreenState extends State<SplashScreen> 
  {@override
   void initState() 
    {super.initState();
     Timer(Duration(seconds: 3),
      ()=>Navigator.pushReplacement
        (context, MaterialPageRoute(builder:(content)=>Login()))
     );
    }
 
   @override
   Widget build(BuildContext context) 
    {return Scaffold
      (body: Container
        (decoration: new BoxDecoration
          (gradient: new LinearGradient
            (begin: Alignment.topLeft,
             end: Alignment.bottomRight,
             stops: [0.3,1],
             colors: [Colors.green[300],
                      Colors.red[300]
                     ],
            )
          ),
         child: Column
          (mainAxisAlignment: MainAxisAlignment.center,
           children: 
            [Image.asset('assets/images/logo.png'),
             SizedBox(height:40),
             SpinKitCircle(color: Colors.white, size:70,)
            ]
          ),
        ),
      );
    }
  }
