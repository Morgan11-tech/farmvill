import 'package:farmvill/widgets/bottom_tabs.dart';
import 'package:farmvill/widgets/hometab.dart';

import 'package:farmvill/widgets/saved_tab.dart';
import 'package:farmvill/widgets/search_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController? _tabspageController;
  int _selectedtab = 0;

  @override
  void initState() {
    _tabspageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabspageController!.dispose();
    super.dispose();
  }

  String? email = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Expanded(
            child: PageView(
              controller: _tabspageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedtab = num;
                });
              },
              children: [
                HomeTab(),
                SavedTab(),
                SearchTab(),
              ],
            ),
          ),
          BottomTabs(
              selectedTab: _selectedtab,
              tabPressed: (num) {
                _tabspageController?.animateToPage(num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic);
              })
        ]));
  }
}







    /*Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Container(
          width: 100,
          child: Image.asset(
            "assets/images/Farmvill-logowhite.png",
          ),
        ),
        centerTitle: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        actions: [
          IconButton(
            onPressed: () {
              //sign Out User
              AuthClass().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              //sign Out User
              AuthClass().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false);
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Hello, User',
                style: kBodyTextwhite,
              ),
            ),
            ListTile(
              title: const Text('Categories', style: kBlack_bold),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Dairy', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Eggs', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Fish and Seafoods', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Fruits', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Grains', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Livestock', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Veggies', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Oils', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Tubers and roots', style: kBodyText),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Help',
                  style: TextStyle(fontSize: 15, color: Colors.orange)),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 39,
              margin: EdgeInsets.only(top: 18, left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Stack(
                children: [
                  TextField(
                    maxLengthEnforced: true,
                    style: kBodyText,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 19, right: 50, bottom: 8),
                      border: InputBorder.none,
                      hintText: "Search Product",
                      hintStyle: kBodyText,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
*/