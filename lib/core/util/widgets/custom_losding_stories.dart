import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class CustomLosdingStories extends StatelessWidget {
  const CustomLosdingStories({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
       height: 100 ,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CardLoading(
            height: 70,
            width: 70,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            margin: EdgeInsets.only(bottom: 30),
          );
        },
      ),
    );
  }
}