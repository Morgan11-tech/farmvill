import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvill/Screens/products_page.dart';
import 'package:farmvill/widgets/custom_action_bar.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:farmvill/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
//when connection is done and data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
//the code below will display the data on firebase in a listview
                return ListView(
                    padding: EdgeInsets.only(top: 110, bottom: 12),
                    children: snapshot.data!.docs.map((document) {
                      return ProductCard(
                          onPressed: () {},
                          imageUrl: document['images'][0],
                          price: "${document['price']}",
                          title: document['name'],
                          productId: document.id);
                    }).toList());
              }

              //when loading
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomactionBar(
            hasbackArrow: false,
            title: '',
            hasbackground: false,
            hasimage: true,
          ),
        ],
      ),
    );
  }
}
