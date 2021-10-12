import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvill/widgets/custom_action_bar.dart';
import 'package:farmvill/widgets/image_swipe.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:farmvill/widgets/productNumber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:farmvill/Services/firebase_services.dart';

class ProductsPage extends StatefulWidget {
  final String productId;
  ProductsPage({required this.productId});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductNumber = "0";

//this is for adding item to cart
  Future _addtoCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"number": _selectedProductNumber});
  }

  Future _addToSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Saved")
        .doc(widget.productId)
        .set({"number": _selectedProductNumber});
  }

//to display a snackbar to the user
  final SnackBar _snackBar =
      SnackBar(content: Text("Product now added to cart"));

  final SnackBar _savedBar =
      SnackBar(content: Text("Product now saved to cart"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<DocumentSnapshot>(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //firebase document data map
                Map<String, dynamic> documentData =
                    snapshot.data!.data() as Map<String, dynamic>;

                //list of images
                List imageList = documentData["images"];
                List productNumber = documentData["number"];

//for selecting initial size
                _selectedProductNumber = productNumber[0];
                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    ImageSwipe(imageList: imageList),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        bottom: 4,
                        left: 24,
                        right: 24,
                      ),
                      child:
                          Text("${documentData['name']}", style: kBlack_bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: Text(
                        "${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 24),
                      child: Text(
                        "${documentData['desc']}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 24),
                      child: Text("Select Amount", style: kBlack_boldtext),
                    ),
                    ProductNumber(
                        productNumber: productNumber,
                        onselected: (number) {
                          _selectedProductNumber = number;
                        }),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await _addToSaved();
                              Scaffold.of(context).showSnackBar(_savedBar);
                            },
                            child: Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.teal,
                              ),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage("assets/images/bookmark.png"),
                                color: Colors.white,
                                height: 22,
                                width: 29,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addtoCart();
                                //calling the snackbar here to appear after clicking on add to cart button
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_snackBar);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 16),
                                height: 65,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Theme.of(context).accentColor,
                                ),
                                alignment: Alignment.center,
                                child: Text("Add to cart",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
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
            title: '',
            hasbackArrow: true,
            hasbackground: false,
            hasimage: false,
          )
        ],
      ),
    );
  }
}
