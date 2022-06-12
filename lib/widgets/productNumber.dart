import 'package:flutter/material.dart';

class ProductNumber extends StatefulWidget {
  final List productNumber;
  final Function(String) onselected;
  ProductNumber({required this.productNumber, required this.onselected});

  @override
  _ProductNumberState createState() => _ProductNumberState();
}

class _ProductNumberState extends State<ProductNumber> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          for (var i = 0; i < widget.productNumber.length; i++)
            GestureDetector(
              onTap: () {
                widget.onselected("${widget.productNumber[i]}");
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: _selected == i
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey[350],
                    borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Text("${widget.productNumber[i]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selected == i ? Colors.white : Colors.black,
                    )),
              ),
            ),
        ],
      ),
    );
  }
}
