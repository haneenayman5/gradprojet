import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const Cardloading();
          }),
    );
  }
}

class Cardloading extends StatelessWidget {
  const Cardloading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: 10,
      children: [
        CardLoading(
          height: 60,
          width: 60,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          margin: EdgeInsets.only(bottom: 30),
        ),
        Expanded(
          child: CardLoading(
            height: 60,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            margin: EdgeInsets.only(bottom: 30),
          ),
        ),
      ],
    );
  }
}
