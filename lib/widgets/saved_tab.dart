import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvill/Screens/products_page.dart';
import 'package:farmvill/Services/firebase_services.dart';
import 'package:farmvill/widgets/custom_action_bar.dart';
import 'package:farmvill/widgets/pallete.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        FutureBuilder<QuerySnapshot>(
          future: _firebaseServices.usersRef
              .doc(_firebaseServices.getUserId())
              .collection("Saved")
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }

            // Collection Data ready to display
            if (snapshot.connectionState == ConnectionState.done) {
              // Display the data inside a list view
              return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map(
                    (document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductsPage(
                                  productId: document.id,
                                ),
                              ));
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                              ),
                                              child: Text(
                                                "${_productMap['price']}",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                20),
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.teal[50],
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () => _firebaseServices
                                              .savedRef
                                              .doc(document.id)
                                              .delete(),
                                          color: Colors.red,
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
                    },
                  ).toList());
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
            hasbackArrow: false,
            hasbackground: false,
            hasimage: false),
        Container(
            width: 175,
            margin: EdgeInsets.symmetric(horizontal: 140, vertical: 40),
            child: (Text(
              "Saved",
              style: kBlack_bold,
            ))),
      ]),
    );
  }
}
