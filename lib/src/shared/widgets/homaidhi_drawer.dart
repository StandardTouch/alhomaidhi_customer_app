import 'package:Alhomaidhi/src/features/login/providers/login_provider.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/providers/orders_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/auth_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/language_provider.dart';
import 'package:Alhomaidhi/src/utils/helpers/auth_helper.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomaidhiDrawer extends ConsumerStatefulWidget {
  const HomaidhiDrawer({super.key});

  @override
  ConsumerState<HomaidhiDrawer> createState() => _HomaidhiDrawerState();
}

class _HomaidhiDrawerState extends ConsumerState<HomaidhiDrawer> {
  Future<String> getUserName() async {
    const storage = FlutterSecureStorage();
    final String userName = await storage.read(key: "full_name") ?? "User";
    return userName;
  }

  void logoutUser() async {
    const storage = FlutterSecureStorage();
    storage.delete(key: "token");
    storage.delete(key: "userId");
    storage.delete(key: "username");
    storage.delete(key: "full_name");
    storage.delete(key: "masterCustomerId");
    ref.read(authProvider.notifier).logOut();
    if (!context.mounted) return;
    context.pop();
    context.go("/login");
  }

  void checkAuth() async {
    final isLoggedIn = await AuthHelper.checkUserAuth();
    if (!isLoggedIn) {
      final storage = FlutterSecureStorage();
      storage.delete(key: "username");
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    final languageOperations = ref.read(languageProvider.notifier);
    final isArabic = ref.watch(languageProvider);
    final isLoggedIn = ref.watch(authProvider);
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
                                  "${TranslationHelper.translation(context)!.welcome} ${snapshot.data}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 22,
                                      ),
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
                    ref.invalidate(addressProvider);
                    context.push("/address");
                  },
                  icon: Icons.location_city,
                  title: TranslationHelper.translation(context)!.myAddress,
                ),
                const MyDivider(),
                DrawerList(
                  onTap: () {
                    context.pop();
                    ref.invalidate(myOrdersListProvider);
                    context.push("/my_orders");
                  },
                  icon: Icons.list,
                  title: TranslationHelper.translation(context)!.myOrders,
                ),
                const MyDivider(),
                DrawerList(
                  onTap: () {
                    context.pop();
                    context.push("/my_invoices");
                  },
                  icon: Icons.receipt_outlined,
                  title: TranslationHelper.translation(context)!.myInvoices,
                ),
                const MyDivider(),
                DrawerList(
                  onTap: () {
                    context.pop();
                    context.push("/delete_profile");
                  },
                  icon: Icons.delete_forever,
                  title: TranslationHelper.translation(context)!.deleteProfile,
                ),
                const MyDivider(),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  ListTile(
                    title: Text(isArabic ? 'عربي' : 'English'),
                    trailing: Switch(
                        value: isArabic,
                        onChanged: (newVal) {
                          languageOperations.toggleLanguage(newVal);
                        }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(isLoggedIn ? Icons.logout : Icons.login),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: isLoggedIn
                          ? logoutUser
                          : () {
                              context.push("/login");
                            },
                      label: Text(isLoggedIn
                          ? TranslationHelper.translation(context)!.logout
                          : TranslationHelper.translation(context)!.signIn),
                    ),
                  ),
                ],
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
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
