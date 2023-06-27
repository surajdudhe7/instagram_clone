import 'package:flutter/material.dart';

class MobileScreenLayout extends StatelessWidget{
  const MobileScreenLayout({Key? key}): super(key: key);
  @override
  Widget build(BuildContextcontext){
    return Scaffold(
      body: Center(
        child: Text('This is mobile'),
      ),
    );
  }
}