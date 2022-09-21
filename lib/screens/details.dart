import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Users.dart';


class UserDetail extends StatelessWidget {
  final User user;
  final double coverHeight = 280;
  final double profileHeight = 144;
  UserDetail(this.user);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
              'User Profile',
            style: TextStyle(
                fontFamily: 'Courier', fontSize: 26.0, color: Colors.black87),
          ),
          ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BuildTop(),
            BuildContent(),
          ],
        ),
    );
  }

  Widget BuildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;

    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: BuildCoverImage()
            ),
          Positioned(
            top: top,
            child: BuildProfileImage(),
          )
        ],
      );
  }

  Widget BuildContent()  => Column(
   children: <Widget>[
    const SizedBox(height: 8),
    Text(
      user.name,
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
    ),
    const SizedBox(height: 8),
    Text(
      user.email,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
    ),
    const SizedBox(height: 18),
    ElevatedButton(
      onPressed: () async {
          String email = Uri.encodeComponent(user.email);
          String subject = Uri.encodeComponent("Hello Flutter");
          String body = Uri.encodeComponent("Hi! I'm Flutter Developer");
          print(subject); //output: Hello%20Flutter
          Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
          await launchUrl(mail);
      }, 
      child: Text("Send EMail Now")
    ),
    buildAbout(),
   ],
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        const SizedBox(height: 12,),
        Text(
          'About',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)
        ),
        SizedBox(height: 8),
        Text(
          'A Card, from the Material library, contains related nuggets of information and can be composed from almost any widget, but is often used with ListTile.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)
        ),
        SizedBox(height: 20),
      ],
    ),
  );
  
  Widget BuildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network(
      "https://images.unsplash.com/photo-1480506132288-68f7705954bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=920&q=80",
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
      ),
  );

  Widget BuildProfileImage() => CircleAvatar(
        radius: profileHeight/2,
        backgroundColor: Color.fromARGB(244, 37, 149, 223),
          child: FullScreenWidget(
            child: CircleAvatar(
              radius: profileHeight/2 - 5,
              backgroundColor: Colors.grey.shade800,
              backgroundImage: NetworkImage(user.avatar)
            ),
          ),
  );
}