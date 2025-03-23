import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled3/core/constants/constants.dart';
import 'package:untitled3/core/util/styles.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.onChanged,
      required this.onTap,
      required this.onSubmitted, required this.controller});
  final VoidCallback onTap;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  
final TextEditingController controller ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.done,
      controller:controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      showCursor: true,
      cursorColor: kPrimarycolor,
      validator: (data) {
        if (data == null || data.trim().isEmpty) {
         controller.clear();

          return 'Please write Message !';
        } else {
          return null;
        }
      },
      style: Styles.textStyle16.copyWith(
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        prefix: const SizedBox(
          width: 15,
        ),
        contentPadding: const EdgeInsets.only(left: 15),
        filled: true,
        fillColor: kContainerColor,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 5, top: 8, bottom: 8),
          child: Container(
            decoration: const BoxDecoration(
              color: kPrimarycolor,
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: -30 * pi / 180,
              child: IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.send_rounded,
                ),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kContainerColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kContainerColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kContainerColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kContainerColor)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kContainerColor)),
        hintText: "Type your message...",
        hintStyle: Styles.textStyle16
            .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
        errorStyle: Styles.textStyle16.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
