import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvill/Screens/cart.dart';
import 'package:farmvill/Services/firebase_services.dart';
import 'package:flutter/material.dart';

class CustomactionBar extends StatelessWidget {
  final String title;
  final bool hasbackArrow;
  final bool hasbackground;
  final bool hasimage;
  CustomactionBar(
      {required this.title,
      required this.hasbackArrow,
      required this.hasbackground,
      required this.hasimage});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    bool _hasbackArrow = hasbackArrow;
    bool _hasbackbackground = hasbackground;
    bool _hasimage = hasimage;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasbackbackground
              ? LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1))
              : null),
      padding: EdgeInsets.only(
        top: 30,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasbackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          _hasimage == true
              ? Image.asset(
                  "assets/images/Farmvill Logo Updated B.png",
                  width: 150,
                  height: 40,
                )
              : Container(
                  width: 50,
                  height: 42,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _usersRef
                          .doc(_firebaseServices.getUserId())
                          .collection("Cart")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        int _totalItems = 0;

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List _documents = snapshot.data!.docs;
                          _totalItems = _documents.length;
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              Text(
                                "$_totalItems",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
