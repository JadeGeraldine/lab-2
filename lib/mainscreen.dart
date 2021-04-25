import 'package:flutter/material.dart';
import 'user.dart';
 
class Mainscreen extends StatefulWidget 
  {final User user;

   const Mainscreen({Key key, this.user}) : super(key: key);
  
   @override
   _MainscreenState createState() => _MainscreenState();
  }

class _MainscreenState extends State<Mainscreen> 
  {@override
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
       appBar: AppBar
        (title: Text('Main Screen'),
         backgroundColor: Colors.green
        ),
       drawer: Theme
        (data: Theme.of(context).copyWith(
          canvasColor: Colors.red[100],),
         child: Drawer
        (child: ListView
          (children: 
            [DrawerHeader
              (child: 
               Text
                 ("USER PROFILE",
                  style: TextStyle(fontFamily: 'Fredoka_One',
                  fontSize:20)),
               decoration: BoxDecoration
                (color: Colors.green[100])
              ),
             ListTile
              (title: Text("About",
                  style: TextStyle(fontFamily: 'Varela_Round',
                  fontSize:18)
                  ),
               onTap: ()
                {Navigator.pop(context);
                }
              ),
             ListTile
              (title: Text("Dips",
                  style: TextStyle(fontFamily: 'Varela_Round',
                  fontSize:18)
                  ),
               onTap: ()
                {Navigator.pop(context);
                }
              ),
             ListTile
              (title: Text("My Cart",
                  style: TextStyle(fontFamily: 'Varela_Round',
                  fontSize:18)
                  ),
               onTap: ()
                {Navigator.pop(context);
                }
              ),
             ListTile
              (title: Text("Messaging",
                  style: TextStyle(fontFamily: 'Varela_Round',
                  fontSize:18)
                  ),
               onTap: ()
                {Navigator.pop(context);
                }
              ),
             ListTile
              (title: Text("My Profile",
                  style: TextStyle(fontFamily: 'Varela_Round',
                  fontSize:18)
                  ),
               onTap: ()
                {Navigator.pop(context);
                }
              )
            ],
          )
        ),
        ),
      ),
      );
    }
  }