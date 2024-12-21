import 'package:flutter/material.dart';

class WelcomePageImageContainer extends StatelessWidget {
  final String img;
  const WelcomePageImageContainer({
    super.key,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 450,
      child: img != '' ? Image.asset(img) : const Placeholder(),
    );
  }
}
