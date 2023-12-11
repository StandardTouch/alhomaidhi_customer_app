import 'package:alhomaidhi_customer_app/src/features/home/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomaidhiBottomBar extends ConsumerStatefulWidget {
  const HomaidhiBottomBar({super.key});

  @override
  ConsumerState<HomaidhiBottomBar> createState() => _HomaidhiBottomBarState();
}

class _HomaidhiBottomBarState extends ConsumerState<HomaidhiBottomBar> {
  int _index = 0;
  void goToScreen(int index) {
    if (index == 0) {
      ref.read(productQueryProvider.notifier).updateSearch("");
      context.go("/home");
    } else if (index == 1) {
      context.go("/search");
    } else if (index == 2) {
      context.go("/cart");
    } else if (index == 3) {
      context.go("/profile");
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GNav(
      padding: EdgeInsets.all(15),
      selectedIndex: _index,
      onTabChange: (currentIndex) {
        setState(() {
          _index = currentIndex;
        });
        goToScreen(currentIndex);
      },
      backgroundColor: Theme.of(context).primaryColor,
      tabBackgroundColor: Theme.of(context).highlightColor,
      tabBorderRadius: 5,
      gap: 10,
      iconSize: 30,
      color: Theme.of(context).highlightColor,
      activeColor: Theme.of(context).colorScheme.onBackground,
      tabs: const [
        GButton(
          icon: Icons.home,
          text: "Home",
          borderRadius: BorderRadius.zero,
        ),
        GButton(
          icon: Icons.search,
          text: "Search",
          borderRadius: BorderRadius.zero,
        ),
        GButton(
          icon: Icons.shopping_cart_outlined,
          text: "Cart",
          borderRadius: BorderRadius.zero,
        ),
        GButton(
          icon: Icons.person_3_outlined,
          borderRadius: BorderRadius.zero,
          text: "Profile",
        ),
      ],
    );
  }
}
