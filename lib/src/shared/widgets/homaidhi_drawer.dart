import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class HomaidhiDrawer extends StatefulWidget {
  const HomaidhiDrawer({super.key});

  @override
  State<HomaidhiDrawer> createState() => _HomaidhiDrawerState();
}

class _HomaidhiDrawerState extends State<HomaidhiDrawer> {
  Future<String> getUserName() async {
    const storage = FlutterSecureStorage();
    final String userName = await storage.read(key: "username") ?? "User";
    return userName;
  }

  void logout() async {
    const storage = FlutterSecureStorage();
    storage.delete(key: "token");
    storage.delete(key: "userId");
    context.pop();
    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder()),
              onPressed: logout,
              label: const Text("Logout"),
            ),
          ),
          ListView(
            children: [
              DrawerHeader(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          );
                        },
                      ),
                    ],
                  )),
              DrawerList(
                onTap: () {
                  context.pop();
                  context.push("/address");
                },
                icon: Icons.location_city,
                title: "My Address",
              ),
              DrawerList(
                onTap: () {
                  context.pop();
                  context.push("/my_orders");
                },
                icon: Icons.list,
                title: "My Orders",
              ),
              DrawerList(
                onTap: () {
                  context.pop();
                  context.push("/my_invoices");
                },
                icon: Icons.receipt_outlined,
                title: "My Invoices",
              ),
              DrawerList(
                onTap: () {
                  context.pop();
                  context.push("/delete_profile");
                },
                icon: Icons.delete_forever,
                title: "Delete Account",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final Function() onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: Theme.of(context).primaryColor,
      onTap: () {
        onTap();
      },
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
