import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled3/core/util/app_route.dart';

import '../../../../core/constants/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LearningStartScreen(),
    );
  }
}

class LearningStartScreen extends StatefulWidget {
  const LearningStartScreen({Key? key}) : super(key: key);

  @override
  State<LearningStartScreen> createState() => _LearningStartScreenState();
}

class _LearningStartScreenState extends State<LearningStartScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/asi.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height / 2.88,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height*0.07,
                  ),
                  CustomText(
                    text: 'Online Learning Everywhere',
                    size: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Added missing color argument
                  ),
                  CustomText(
                    text: 'Learn with pleasure with',
                    size: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey, // Added missing color argument
                  ),
                  CustomText(
                    text: 'us,wherever you are',
                    size: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey, // Added missing color argument
                  ),
                  SizedBox(
                    height: height*0.01,
                  ),
                  GestureDetector(
                    onTap: (){
                      GoRouter.of(context).go(AppRoute.learningHome);
                    },
                    child: Container(
                      alignment:Alignment.center ,
                      height: height*0.08,
                      width: width*0.35,
                      decoration: BoxDecoration(
                          color: SecondryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: SecondryColor.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ]
                      ),
                      child: CustomText(
                        text:'Get Started',
                        size :20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ) ,
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key, required this.size, required this.color, required this.fontWeight, required this.text
  });

  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
      ),
    );
  }
}