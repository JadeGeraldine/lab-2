import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget 
  {@override
   _RegisterState createState() => _RegisterState();
  }

class _RegisterState extends State<Register> 
  {TextEditingController _emailController = new TextEditingController();
   TextEditingController _passwordControllera = new TextEditingController();
   TextEditingController _passwordControllerb = new TextEditingController();
   bool _obscureText = true;

   @override
   Widget build(BuildContext context) 
    {return Container
      (decoration: new BoxDecoration
        (gradient: new LinearGradient
          (begin: Alignment.topLeft,
           end: Alignment.bottomRight,
           stops: [0.3,1],
           colors: [Colors.green[200],
                    Colors.red[200]
                   ],
          ),
        ),
      child: Scaffold
        (backgroundColor: Colors.transparent,
         body: Center
          (child: SingleChildScrollView 
            (child: Column
              (children: 
                [Container
                  (margin: EdgeInsets.fromLTRB(0,20,0,20),
                   child: Image.asset('assets/images/logo.png', scale:2)
                  ),
                 SizedBox(height:5),
                    
                 Card
                  (margin: EdgeInsets.fromLTRB(20,0,20,30),
                   elevation: 10,
                   shape: RoundedRectangleBorder
                    (borderRadius: BorderRadius.circular(50),
                    ),
                   color: Colors.white60,
                   child: 
                   Padding 
                    (padding: const EdgeInsets.fromLTRB(25, 5, 25, 15),
                     child: Column
                      (children: 
                        [TextField
                          (controller: _emailController,
                           keyboardType: TextInputType.emailAddress,
                           decoration: InputDecoration
                            (labelText: 'Email', 
                             labelStyle: TextStyle
                              (fontFamily: 'Varela_Round', 
                               fontSize:20
                              ),
                             icon: Icon(Icons.email)
                            ),
                           style: TextStyle(fontSize:20),
                          ),
                         TextField
                          (controller: _passwordControllera,
                           decoration: InputDecoration
                            (labelText: 'Enter Password', 
                             labelStyle: TextStyle
                              (fontFamily: 'Varela_Round', 
                               fontSize:20
                              ),
                             icon: Icon(Icons.lock),
                             suffix: InkWell
                              (onTap: _toggle,
                               child: Icon(Icons.visibility),
                              ),
                            ),
                           style: TextStyle(fontSize:20),
                           obscureText: _obscureText,
                          ),
                         TextField
                          (controller: _passwordControllerb,
                           decoration: InputDecoration
                            (labelText: 'Re-Enter Password',
                             labelStyle: TextStyle
                              (fontFamily: 'Varela_Round', 
                               fontSize:20
                              ),
                             icon: Icon(Icons.lock),
                             suffix: InkWell
                              (onTap: _toggle,
                               child: Icon(Icons.visibility),
                              ),
                            ),
                           style: TextStyle(fontSize:20),
                           obscureText: _obscureText,
                          ),
                          SizedBox(height:5),

                          MaterialButton
                          (shape: RoundedRectangleBorder
                            (borderRadius: BorderRadius.circular(5),),
                           minWidth: 150,
                           child: Text('SIGN UP', style: TextStyle
                                    (fontFamily: 'Fredoka_One', 
                                     fontSize:25,
                                     color: Colors.white)
                                    ),
                           onPressed: _onSignUp,
                           color: Colors.green
                          )
                        ],
                      ),
                    ),
                  ),

                  GestureDetector
                    (child: Text
                      ("Already registered?", style: TextStyle
                        (fontFamily: 'Comfortaa', fontSize:18)),
                     onTap: _registered,
                    ),
                ],
              ),
            )
          ),
        ),
      );
    }

   void _onSignUp() 
    {String _email = _emailController.text.toString();
     String _passworda = _passwordControllera.text.toString();
     String _passwordb = _passwordControllerb.text.toString();
     bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email);

     if (_email.isEmpty || _passworda.isEmpty || _passwordb.isEmpty)
      {Fluttertoast.showToast
        (msg: "Email/password is empty",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 18.0
        );
       return;
      }
     
     if (!emailValid)
      {Fluttertoast.showToast
        (msg: "Incorrect email format",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 18.0
        );
       return;
      }

     if (_passworda.length < 6)
      {Fluttertoast.showToast
        (msg: "Password is too short",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 18.0
        );
       return;
      }

     if (_passwordb != _passworda)
      {Fluttertoast.showToast
        (msg: "Passwords do not match",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 18.0
        );
       return;
      }
      
     showDialog
      (context: context,
       builder: (BuildContext context) 
        {return AlertDialog
          (shape: RoundedRectangleBorder
            (borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
           title: Text("REGISTER NEW USER", 
                  style: TextStyle(fontFamily: 'Fredoka_One', 
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  fontSize:22)),
           content: Text("Confirm?",
            style: TextStyle(fontSize:20)),
           actions: 
            [TextButton
              (child: 
                Text("Yes", 
                     style: TextStyle(color: Colors.green[700],
                     fontFamily: 'Varela_Round',
                     fontSize: 18)),
                onPressed: () 
                  {Navigator.of(context).pop();
                   _registerNewUser(_email, _passworda);
                  },
              ),
             TextButton
              (child: 
                Text("Cancel",
                     style: TextStyle(color: Colors.red[700],
                     fontFamily: 'Varela_Round',
                     fontSize: 18)),
                onPressed: () 
                  {Navigator.of(context).pop();
                  }
              ),
            ],
          );
        }
      );
    }
                                                                           
   void _registered() 
    {Navigator.pop(context);
     Navigator.push
      (context, MaterialPageRoute(builder:(content)=>Login()));
    }

   void _registerNewUser(String email, String password) 
    {http.post
      (Uri.parse("https://crimsonwebs.com/s270012/ArtisanalDips/php/register.php"),
       body:
        {"email":email,
         "password":password
        }
      ).then
        ((response)
          {print(response.body);

           if (response.body=="successsuccess")
            {Fluttertoast.showToast
              (msg: "Registered Successfully. Please check email for verification link.",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.TOP,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 18.0
              );
             Navigator.pop(context);
             Navigator.push(
              context, MaterialPageRoute(builder: (content) => Login()));
            }
           else 
            {Fluttertoast.showToast
              (msg: "Registration Failed",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.TOP,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.red,
               textColor: Colors.white,
               fontSize: 18.0
              );
            }
          }
        );
    }
    
  void _toggle() 
    {setState(() 
      {_obscureText = !_obscureText;
      });
    }
}

