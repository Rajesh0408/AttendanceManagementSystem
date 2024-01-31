// import 'package:flutter/material.dart';
// import 'package:myapp/listClass.dart';
// import 'package:myapp/logIn_faculty.dart';
// import 'constants/colours.dart';
// import 'AdvisorMainPage.dart';
// import 'absentIntimation.dart';
// import 'facultyStudent.dart';
// import 'main.dart';
//
// class NavBar extends StatefulWidget{
//
//    String userId;
//    bool isfaculty;
//    String? name;
//    NavBar(this.userId, this.isfaculty, this.name);
//
//   NavBarState createState()=> NavBarState();
// }
// class NavBarState extends State<NavBar> {
//   String userId='';
//   bool? isfaculty;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     userId=widget.userId;
//     isfaculty=widget.isfaculty;
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const UserAccountsDrawerHeader(
//               decoration: BoxDecoration(
//                 color: AppColor.navbar,
//               ),
//               accountName: Text("Kamal"),
//               accountEmail: Text("rajes.ajsdgagdfjhdgsh"),
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: AppColor.navbar,
//                 backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_FyL3EyZN0SDIV-n1eVzJfzKkGc9Q7QwtjMqtN5gNCZNjcZn6UZkQvFkmCeeQoWlefts&usqp=CAU'),
//               ),
//           ),
//           //
//           ListTile(
//             onTap: (){
//               if(!isfaculty!){
//                 Navigator.push(context, MaterialPageRoute(
//                     builder: (context) => AdvisorMainPage(userId,isfaculty!)));
//               }
//               else{
//                 Navigator.pop(context);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("You're not an advisor"),
//                     duration: Duration(seconds: 2),
//                     backgroundColor: Colors.red,
//                   ),
//                 );
//               }
//             },
//             leading: const ImageIcon(
//               AssetImage(
//                 'lib/assets/advisor.png',
//               ),
//               size: 25.0, // Set the size as per your requirement
//               // color: Colors.white, // Set the color as per your requirement
//             ),
//             title: Text("Advisor"),
//           ),
//           ListTile(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(
//                             builder: (context) => listClass(userId,isfaculty!,name)));
//             },
//             leading: const ImageIcon(
//               AssetImage(
//                 'lib/assets/course.png',
//               ),
//               size: 25.0, // Set the size as per your requirement
//              // color: Colors.white, // Set the color as per your requirement
//             ),
//             title: Text("My courses"),
//           ),
//           ListTile(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => absentIntimation(userId,isfaculty!)));
//             },
//             leading: const ImageIcon(
//               AssetImage(
//                 'lib/assets/absent.png',
//               ),
//               size: 20.0, // Set the size as per your requirement
//               // color: Colors.black, // Set the color as per your requirement
//             ),
//             title: Text("Absent Intimation Forms"),
//           ),
//           // ListTile(
//           //   leading: Icon(Icons.settings),
//           //   title: Text("Settings"),
//           // ),
//           ListTile(
//             onTap: (){
//               Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => LoginPageFaculty()));
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text("Logout successful"),
//                   duration: Duration(seconds: 2),
//                 ),
//               );
//             },
//             leading: Icon(Icons.logout),
//             title: Text("logout"),
//
//           ),
//         ],
//       ),
//     );
//   }
// }
