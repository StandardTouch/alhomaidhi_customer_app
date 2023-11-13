import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomaidhiBottomBar extends StatefulWidget {
  const HomaidhiBottomBar({super.key});

  @override
  State<HomaidhiBottomBar> createState() => _HomaidhiBottomBarState();
}

class _HomaidhiBottomBarState extends State<HomaidhiBottomBar> {
  int _index = 0;
  void goToScreen(int index) {
    if (index == 0) {
      context.go("/home");
    } else if (index == 1) {
      context.go("/cart");
    } else if (index == 2) {
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
          icon: Icons.shop,
          text: "Cart",
          borderRadius: BorderRadius.zero,
        ),
        GButton(
          icon: Icons.person_3_outlined,
          borderRadius: BorderRadius.zero,
          text: "Profile",
        )
      ],
    );
  }
}
