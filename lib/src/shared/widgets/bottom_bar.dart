import 'package:alhomaidhi_customer_app/main.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/providers/products_provider.dart';
import 'package:alhomaidhi_customer_app/src/shared/providers/loading_provider.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
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
      await navigateToCart(context);
    } else if (index == 3) {
      context.go("/profile");
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return GNav(
    //   padding: const EdgeInsets.all(15),
    //   selectedIndex: _index,
    //   onTabChange: (currentIndex) {
    // setState(() {
    //   _index = currentIndex;
    // });
    //     goToScreen(currentIndex);
    //   },
    //   backgroundColor: Theme.of(context).primaryColor,
    //   tabBackgroundColor: Theme.of(context).highlightColor,
    //   tabBorderRadius: 5,
    //   gap: 10,
    //   iconSize: 20,
    //   color: Theme.of(context).highlightColor,
    //   activeColor: Theme.of(context).colorScheme.onBackground,
    //   tabs: const [
    //     GButton(
    //       icon: FontAwesomeIcons.house,
    //       text: "Home",
    //       borderRadius: BorderRadius.zero,
    //     ),
    //     GButton(
    //       icon: FontAwesomeIcons.magnifyingGlass,
    //       text: "Search",
    //       borderRadius: BorderRadius.zero,
    //     ),
    //     GButton(
    //       icon: FontAwesomeIcons.cartShopping,
    //       text: "Cart",
    //       borderRadius: BorderRadius.zero,
    //     ),
    //     GButton(
    //       icon: FontAwesomeIcons.circleUser,
    //       borderRadius: BorderRadius.zero,
    //       text: "Profile",
    //     ),
    //   ],
    // );
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      padding: const EdgeInsets.all(8.0),
      child: BottomBarFloating(
        iconSize: 18,
        borderRadius: BorderRadius.circular(10),
        items: const [
          TabItem(icon: FontAwesomeIcons.house, title: "Home"),
          TabItem(icon: FontAwesomeIcons.magnifyingGlass, title: "Search"),
          TabItem(icon: FontAwesomeIcons.cartShopping, title: "Cart"),
          TabItem(icon: FontAwesomeIcons.circleUser, title: "Profile"),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        color: Colors.white,
        colorSelected: Colors.amber,
        onTap: (index) {
          setState(() {
            _index = index;
          });
          goToScreen(index);
        },
        indexSelected: _index,
      ),
    );
  }
}

Future<void> navigateToCart(BuildContext context) async {
  globalContainer.read(isLoadingProvider.notifier).state = true;
  context.go("/cart");
  try {
    // ignore: unused_result
    await globalContainer.refresh(myCartProvider.future);
    // ignore: empty_catches
  } catch (err) {
  } finally {
    globalContainer.read(isLoadingProvider.notifier).state = false;
  }
}
