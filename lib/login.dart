import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainscreen.dart';
import 'register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

 
class Login extends StatefulWidget 
  {@override
   _LoginState createState() => _LoginState();
  }

class _LoginState extends State<Login> 
  {bool _rememberMe = false;
   TextEditingController _emailController = new TextEditingController();
   TextEditingController _passwordController = new TextEditingController();
   SharedPreferences sharedPref;
   
   @override
   void initState() 
   {loadPreferences();
    super.initState();
   }

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
                   child: Image.asset('assets/images/logo.png', scale:2),
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
                             icon: Icon(Icons.email),
                            ),
                           style: TextStyle(fontSize:20),
                          ),
                         TextField
                          (controller: _passwordController,
                           decoration: InputDecoration
                            (labelText: 'Password', 
                             labelStyle: TextStyle
                              (fontFamily: 'Varela_Round', 
                               fontSize:20
                              ),
                             icon: Icon(Icons.lock)
                            ),
                           style: TextStyle(fontSize:20),
                           obscureText: true,
                          ),
                          SizedBox(height:5),

                          Row
                            (children:
                              [Checkbox
                                (value: _rememberMe, onChanged:(bool value)
                                  {_onchange(value);
                                  }
                                ),
                               Text('Remember Me', style: TextStyle
                                (fontFamily: 'Rajdhani', fontSize:18))
                              ],
                            ),
                          
                          MaterialButton
                            (shape: RoundedRectangleBorder
                              (borderRadius: BorderRadius.circular(5),),
                               minWidth: 150,
                               child: Text('LOG IN', style: TextStyle
                                    (fontFamily: 'Fredoka_One', 
                                     fontSize:25,
                                     color: Colors.white)
                                    ),
                               onPressed: _onLogin,
                               color: Colors.green
                            )
                        ],
                      ),
                    ),
                  ),

                 GestureDetector
                  (child: Text
                    ("Sign up", style: TextStyle
                      (fontFamily: 'Comfortaa', fontSize:18)), 
                   onTap: _signUp,
                  ),
                 SizedBox(height:10),
                 GestureDetector
                  (child: Text
                    ("Forgot password", style: TextStyle
                      (fontFamily: 'Comfortaa', fontSize:18)),
                   onTap: _forgot,
                  )
                ],
              ),
            )
          ),
        ),
      );
    }

   void _onLogin() 
    {String _email = _emailController.text.toString();
     String _password = _passwordController.text.toString();
     
     http.post
      (Uri.parse("https://crimsonwebs.com/s270012/ArtisanalDips/php/login.php"),
       body:
        {"email":_email,
         "password":_password
        }
      ).then
        ((response)
          {print(response.body);

           if  (response.body=="successsuccess")
            {Fluttertoast.showToast
              (msg: "Login Success",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.TOP,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 18.0
              );
             Navigator.push
              (context, MaterialPageRoute(builder: (content) => Mainscreen()));
            }
           else 
            {Fluttertoast.showToast
              (msg: "Login Failed. \n Email/Password is incorrect.",
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
                                                                                                                                                                                              
   void _onchange(bool value) 
    {String _email = _emailController.text.toString();
     String _password = _passwordController.text.toString();
     
     if (_email.isEmpty || _password.isEmpty)
      {Fluttertoast.showToast
        (msg: "Email/password is empty",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 18.0,
        );
       return;
      }

     setState(() 
      {_rememberMe = value;
       savePreferences(value,_email,_password);
      });
    }

   void _signUp() 
    {Navigator.push
      (context, MaterialPageRoute(builder:(content)=>Register()));
    }
                                                                              
   void _forgot() 
    {TextEditingController _emailcontroller = TextEditingController();
     showDialog
      (context: context, 
       builder: (BuildContext context)
        {return AlertDialog
          (shape: RoundedRectangleBorder
            (borderRadius: BorderRadius.circular(50),
            ),
           title: Text("FORGOT PASSWORD", 
                  style: TextStyle(fontFamily: 'Fredoka_One', 
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  fontSize:22)),
           content: new Container
            (height: 100,
             child: Column
              (children: 
                [Text('Enter recovery email',
                   style: TextStyle(fontSize:20)),
                 TextField
                  (controller: _emailcontroller,
                   decoration: InputDecoration
                    (labelText: 'Email', 
                     labelStyle: TextStyle
                      (fontFamily: 'Zilla_Slab', 
                       fontSize:20
                      ),
                     icon: Icon(Icons.email)
                    ),
                   style: TextStyle(fontSize:20),
                  ),
                ],
              )
            ),
           actions: 
            [TextButton
              (child: 
                Text("Submit", 
                     style: TextStyle(color: Colors.green[700],
                     fontFamily: 'Varela_Round',
                     fontSize: 18)
                    ), 
                onPressed: ()
                  {print(_emailcontroller.text);
                   _reset(_emailcontroller.text.toString());
                   Navigator.of(context).pop();
                  },
                ),
             TextButton
              (child: 
                Text("Cancel",
                     style: TextStyle(color: Colors.red[700],
                     fontFamily: 'Varela_Round',
                     fontSize: 18)
                    ),
                onPressed: ()
                  {Navigator.of(context).pop();
                  },
              ),
            ],
          );
        }
      );
    }

   Future<void> savePreferences(bool value, String email, String password) async 
    {sharedPref = await SharedPreferences.getInstance();
     
     if (value)
      {await sharedPref.setString("email",email);
       await sharedPref.setString("password",password);
       await sharedPref.setBool("rememberme",value);
       
       Fluttertoast.showToast
        (msg: "Preferences stored",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 18.0
        );
       return;
      }

      else
      {await sharedPref.setString("email",'');
       await sharedPref.setString("password",'');
       await sharedPref.setBool("rememberme",value);
       
       Fluttertoast.showToast
        (msg: "Preferences removed",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.TOP,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 18.0
        );
       setState(() 
        {_emailController.text = '';
         _passwordController.text = '';
         _rememberMe = false;
        });
       return;
      }
    }

   Future<void> loadPreferences() async 
    {sharedPref = await SharedPreferences.getInstance();
     String _email = sharedPref.getString("email") ?? '';
     String _password = sharedPref.getString("password") ?? '';
     _rememberMe = sharedPref.getBool("rememberme") ?? false; 
       
     setState(() 
      {_emailController.text = _email;
       _passwordController.text = _password;
      });
    }

  void _reset(String email) 
    {http.post
      (Uri.parse("https://crimsonwebs.com/s270012/ArtisanalDips/php/reset.php"),
       body:
        {"email":email
        }
      ).then
        ((response)
          {print(response.body);

           if (response.body=="successsuccess")
            {Fluttertoast.showToast
              (msg: "Please check your email",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.TOP,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 18.0
              );
            }
           else 
            {Fluttertoast.showToast
              (msg: "Failed",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.TOP,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.green,
               textColor: Colors.white,
               fontSize: 18.0
              );
            }
          }
        );
    }
  }



