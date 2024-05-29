import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart'; //para uso de iconos svg
import 'package:metro_experts/pages/editProfile.dart'; 

class viewProfile extends StatelessWidget {

  final double coverHeight = 220;
  final double profileHeight = 100;
  const viewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final top = coverHeight - profileHeight;
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        children: [
            Center(
              child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children:[
                buildCoverImage(),
                Positioned(
                  top: top,
                  child: buildUserCard(context),
                ),
              buildProfileImage()
              ],
           ),
          ),
        ],
      ),
    );
  }

  Widget buildCoverImage() => Container(
    color: Color(0xfff9FA9FF),
    height: coverHeight,
    width: double.infinity,
  );

  Widget buildUserCard(context) => Container(
    width: 345,
    height: 195,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          spreadRadius: 2,
          blurRadius: 10,
          color: Colors.black.withOpacity(0.1)
        ),
      ],
      borderRadius: BorderRadius.circular(35),
      color: Colors.white,
      shape: BoxShape.rectangle,
    ),  
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfile()),
            );
          }, 
          child: Text("Edit", style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Color(0xfff060B26),
        ),
      ),
    ]
  ),
  );

  Widget buildProfileImage() => Container(
    width: 158,
    height: 158,
    decoration: BoxDecoration(
      color: Color(0xfff9FE7F5),
      boxShadow: [
        BoxShadow(
          spreadRadius: 2,
          blurRadius: 10,
          color: Colors.black.withOpacity(0.1),
        ),
      ],
      shape: BoxShape.circle,
        //image: DecorationImage(
        //fit: BoxFit.cover,
        // image: NetworkImage(),
        // )
      ),
    );


  AppBar appBar() {
    return AppBar(
      backgroundColor: Color(0xfff9FA9FF),
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 30,
            width: 30,
          ),
        ),
      ),
    );
  }
}