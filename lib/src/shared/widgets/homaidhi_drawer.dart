import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomaidhiDrawer extends StatefulWidget {
  const HomaidhiDrawer({super.key});

  @override
  State<HomaidhiDrawer> createState() => _HomaidhiDrawerState();
}

class _HomaidhiDrawerState extends State<HomaidhiDrawer> {
  int currentIndex = 0;
  Future<String> getUserName() async {
    const storage = FlutterSecureStorage();
    final String userName = await storage.read(key: "username") ?? "User";
    return userName;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      child: Icon(
                        Icons.account_circle,
                        size: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: getUserName(),
                    builder: (context, snapshot) {
                      return Text(
                        "Hello, ${snapshot.data}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      );
                    },
                  ),
                ],
              )),
          DrawerList(
            currentIndex: currentIndex,
            index: 1,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            icon: Icons.location_city,
            title: "My Address",
          ),
          DrawerList(
            currentIndex: currentIndex,
            index: 2,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            icon: Icons.list,
            title: "My Orders",
          ),
          DrawerList(
            currentIndex: currentIndex,
            index: 3,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            icon: Icons.receipt_outlined,
            title: "My Invoices",
          ),
          DrawerList(
            currentIndex: currentIndex,
            index: 4,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            icon: Icons.delete_forever,
            title: "Delete Account",
          ),
        ],
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.index,
    required this.title,
    required this.icon,
  });

  final int currentIndex;
  final int? index;
  final Function(int index) onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: Theme.of(context).primaryColor,
      selected: currentIndex == index,
      onTap: () {
        if (index != null) onTap(index!);
      },
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
