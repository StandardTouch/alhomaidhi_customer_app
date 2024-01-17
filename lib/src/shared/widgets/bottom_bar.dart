import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/shared/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomaidhiBottomBar extends ConsumerStatefulWidget {
  const HomaidhiBottomBar({super.key});

  @override
  ConsumerState<HomaidhiBottomBar> createState() => _HomaidhiBottomBarState();
}

class _HomaidhiBottomBarState extends ConsumerState<HomaidhiBottomBar> {
  int _index = 0;
  void goToScreen(int index) async {
    if (index == 0) {
      final query = ref.watch(productQueryProvider);
      if (query.search != "") {
        ref.read(productQueryProvider.notifier).updateSearch("");
      }
      context.go("/home");
    } else if (index == 1) {
      context.go("/search");
    } else if (index == 2) {
      ref.read(isLoadingProvider.notifier).state = true;
      context.go("/cart");
      // ignore: unused_result
      await ref.refresh(myCartProvider.future);
      ref.read(isLoadingProvider.notifier).state = false;
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
      iconSize: 20,
      color: Theme.of(context).highlightColor,
      activeColor: Theme.of(context).colorScheme.onBackground,
      tabs: const [
        GButton(
          icon: FontAwesomeIcons.house,
          text: "Home",
          borderRadius: BorderRadius.zero,
        ),
        GButton(
          icon: FontAwesomeIcons.magnifyingGlass,
          text: "Search",
          borderRadius: BorderRadius.zero,
        ),
        GButton(
          icon: FontAwesomeIcons.cartShopping,
          text: "Cart",
          borderRadius: BorderRadius.zero,
        ),
        GButton(
          icon: FontAwesomeIcons.circleUser,
          borderRadius: BorderRadius.zero,
          text: "Profile",
        ),
      ],
    );
  }
}
