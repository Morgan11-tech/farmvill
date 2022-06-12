import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvill/Screens/products_page.dart';
import 'package:farmvill/Services/firebase_services.dart';
import 'package:farmvill/widgets/custom_action_bar.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        FutureBuilder<QuerySnapshot>(
          future: _firebaseServices.usersRef
              .doc(_firebaseServices.getUserId())
              .collection("Cart")
              .get(),
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
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsPage(
                              productId: document.id,
                            ),
                          ),
                        );
                      },
                      child: FutureBuilder<DocumentSnapshot>(
                          future: _firebaseServices.productsRef
                              .doc(document.id)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> productSnap) {
                            if (productSnap.hasError) {
                              return Container(
                                child: Center(
                                  child: Text("${productSnap.error}"),
                                ),
                              );
                            }
                            if (productSnap.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> _productMap =
                                  productSnap.data!.data()
                                      as Map<String, dynamic>;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          "${_productMap['images'][0]}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_productMap['name']}",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              "${_productMap['price']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            "Amount in Kg - ${document['number']}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }),
                    );
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
            title: 'title',
            hasbackArrow: true,
            hasbackground: false,
            hasimage: false),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 150, vertical: 40),
            child: (Text(
              "Cart",
              style: kbBar,
            ))),
      ]),
    );
  }
}
