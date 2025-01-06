import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  const MainScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StateAppBar(),
      body: Center(
        child: buildList(),
      ),
      drawer: buildDrawer(context),
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/icons/avatar.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                index % 3 == 0
                    ? "Arande Allée"
                    : index % 3 == 1
                        ? "Brande Allée"
                        : "Grande Allée",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(index % 3 == 0
                  ? "Indulge in the bold and hoppy goodness of our..."
                  : "Indulge in the bold"),
            ),
          ),
        );
      },
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 32.0,
          ),
          ListTile(
            title: Text("Profile"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage("https://picsum.photos/200/100")),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${userData['name']['first']} ${userData['name']['last']}"),
                Text(
                  "${userData['email']}",
                  style: TextStyle(
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log out"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
          SizedBox(
            height: 48.0,
          )
        ],
      ),
    );
  }
}

class StateAppBar extends StatefulWidget implements PreferredSizeWidget {
  const StateAppBar({super.key});

  @override
  MainAppBar createState() => MainAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MainAppBar extends State<StateAppBar> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: isSearching
          ? TextField(
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            )
          : Text(
              "Helloshka",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                }
                isSearching = !isSearching;
              });
            },
            icon: Icon(isSearching ? Icons.close : Icons.search))
      ],
    );
  }
}
