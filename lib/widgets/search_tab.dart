import 'package:farmvill/widgets/pallete.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 45,
        ),
        Container(
          width: 280,
          decoration: BoxDecoration(
              color: Colors.grey[500]!.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
            style: kBodyText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 19, right: 50, bottom: 8),
              border: InputBorder.none,
              hintText: "Search Product",
              hintStyle: kBodyText,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Search Results",
        )
      ],
    ));
  }
}
