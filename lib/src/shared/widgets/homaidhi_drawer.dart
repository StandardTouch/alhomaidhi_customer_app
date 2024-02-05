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
    final String userName = await storage.read(key: "full_name") ?? "User";
    return userName;
  }

  void logoutUser() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "token");
    await storage.delete(key: "userId");
    if (!context.mounted) return;
    context.pop();
    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 10,
                    ),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: FutureBuilder(
                            future: getUserName(),
                            builder: (context, snapshot) {
                              return FittedBox(
                                child: Text(
                                  "Welcome, ${snapshot.data}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 22),
                                ),
                              );
                            },
                          ),
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
                const MyDivider(),
                DrawerList(
                  onTap: () {
                    context.pop();
                    context.push("/my_orders");
                  },
                  icon: Icons.list,
                  title: "My Orders",
                ),
                const MyDivider(),
                DrawerList(
                  onTap: () {
                    context.pop();
                    context.push("/my_invoices");
                  },
                  icon: Icons.receipt_outlined,
                  title: "My Invoices",
                ),
                const MyDivider(),
                DrawerList(
                  onTap: () {
                    context.pop();
                    context.push("/delete_profile");
                  },
                  icon: Icons.delete_forever,
                  title: "Delete Account",
                ),
                const MyDivider(),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(),
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  foregroundColor: Colors.black,
                ),
                onPressed: logoutUser,
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 0.5,
      color: Colors.grey,
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
