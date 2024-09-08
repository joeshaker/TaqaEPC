import 'package:flutter/material.dart';
import 'package:responsive_card/responsive_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),//your app title
        ),
        body: SizedBox(
          width: 600,
          child: ListView(
            children: List.generate(4, (index) => ResponsiveCard(
              elevation: 5, //elevation
              titleGap: 20, // gap between title and leading
              bgColor: Colors.white, // card background color
              screenWidth: 600, // After this range of screen width it will work as a listtile
              title: const Text("Raihan Hossain",style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              subTitle: const Text("Android, IOS & mern stack developer"),
              leading: Image.network("https://raihandevzone.com/images/Raihan_Hossain.webp"),
              action: const Positioned(// You can use any kind of widget here
                  right: 5,
                  top:5,
                  child: Icon(Icons.heart_broken,color: Colors.red,)),
            ),),
          ),
        )

    );
  }
}