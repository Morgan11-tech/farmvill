import 'package:flutter/material.dart';

class Secondimage extends StatelessWidget {
  const Secondimage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/veggies.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          height: 50.0,
        ),
      ),
    );
  }
}
