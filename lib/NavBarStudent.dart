import 'package:flutter/material.dart';
import 'package:myapp/listClass.dart';
import 'constants/colours.dart';

import 'absentIntimation.dart';
import 'facultyStudent.dart';
import 'logIn_faculty.dart';
import 'main.dart';
class NavBarStudent extends StatefulWidget{

  //String userId;
  // String password;
 //NavBarStudent(this.userId);
  NavBarState createState()=> NavBarState();
}
class NavBarState extends State<NavBarStudent> {
  String userId='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //userId=widget.userId;
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: AppColor.navbar,
            ),
            accountName: Text(" Attendance Manager",style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic),),
            accountEmail: Text(""),
            // currentAccountPicture: CircleAvatar(
            //   backgroundColor: AppColor.navbar,
            //   child: ClipOval(
            //     child: ImageIcon(
            //       AssetImage(
            //         'lib/assets/profile.png',
            //       ),
            //       size: 70.0, // Set the size as per your requirement
            //       // color: Colors.black, // Set the color as per your requirement
            //     ),
            //   ),
            // ),
          ),
          // const UserAccountsDrawerHeader(
          //   decoration: BoxDecoration(
          //     color: AppColor.navbar,
          //   ),
          //   accountName: Text("flutter.com"),
          //   accountEmail: Text("example@gmail.com"),
          //   currentAccountPicture: CircleAvatar(
          //     backgroundColor: AppColor.navbar,
          //     child: ClipOval(
          //       child: ImageIcon(
          //         AssetImage(
          //           'lib/assets/profile.png',
          //         ),
          //         size: 70.0, // Set the size as per your requirement
          //         // color: Colors.black, // Set the color as per your requirement
          //       ),
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(
          //         builder: (context) => listClass(userId)));
          //   },
          //   leading: const ImageIcon(
          //     AssetImage(
          //       'lib/assets/courses.png',
          //     ),
          //     size: 25.0, // Set the size as per your requirement
          //     // color: Colors.white, // Set the color as per your requirement
          //   ),
          //   title: Text("My courses"),
          // ),
          // ListTile(
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(
          //         builder: (context) => absentIntimation()));
          //   },
          //   leading: const ImageIcon(
          //     AssetImage(
          //       'lib/assets/absent.png',
          //     ),
          //     size: 20.0, // Set the size as per your requirement
          //     // color: Colors.black, // Set the color as per your requirement
          //   ),
          //   title: Text("Absent Intimation Forms"),
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text("Settings"),
          // ),
          ListTile(
            onTap: (){

            },
            leading: const ImageIcon(
              AssetImage(
                'lib/assets/absent.png',
              ),
              size: 20.0, // Set the size as per your requirement
              // color: Colors.black, // Set the color as per your requirement
            ),
            title: Text("Submitted Forms"),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginPageFaculty()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logout successful"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            leading: Icon(Icons.logout),
            title: Text("logout"),

          ),
        ],
      ),
    );
  }
}
