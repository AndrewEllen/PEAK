import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peak/pages/home/home_page.dart';
import 'package:peak/pages/post/new_post_page.dart';
import 'package:peak/pages/profile/profile_page.dart';
import 'package:peak/pages/search/search_page.dart';
import 'package:peak/providers/navigation/navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';

import '../../constants.dart';
import 'front_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey navigationBarKey = GlobalKey();

  int pageIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NewPostPage(),
    ProfilePage(key: UniqueKey()),
  ];

  List<NavigationDestination> navigationDestinationsList = [
    const NavigationDestination(
      icon: Icon(
        Icons.home_outlined,
        color: appTertiaryColour,
      ),
      label: "Home",
      selectedIcon: Icon(
        Icons.home,
        color: appTertiaryColour,
      ),
    ),
    const NavigationDestination(
      icon: Icon(
        Icons.search,
        color: appTertiaryColour,
      ),
      label: "Search",
    ),
    const NavigationDestination(
      icon: Icon(
        Icons.add_box_outlined,
        color: appTertiaryColour,
      ),
      label: "New Post",
      selectedIcon: Icon(
        Icons.add_box,
        color: appTertiaryColour,
      ),
    ),
    const NavigationDestination(
      icon: Icon(
        Icons.person_outline,
        color: appTertiaryColour,
      ),
      label: "Profile",
      selectedIcon: Icon(
        Icons.person,
        color: appTertiaryColour,
      ),
    ),
  ];

  Future<bool> _onBackKey() async {
    if (context.read<NavigationProvider>().pageWidgetCacheIndex == 0 && context.read<NavigationProvider>().navigationBarCache) {
      debugPrint("Opening quit dialogue");
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: appTertiaryColour,
              titleTextStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
              contentTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              title: const Text('Are you sure?'),
              content: const Text('Do you want to close the app?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("No"),
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text("Yes"),
                ),
              ],
            ),
          )) ??
          false;
    } else {
      if (context.read<NavigationProvider>().pageWidgetCacheIndex != 0 && context.read<NavigationProvider>().navigationBarCache) {

        context.read<NavigationProvider>().navigatorBarNavigationReset(navigatorIndex: 0);
        return false;

      } else {

        debugPrint("Going back a page");
        context.read<NavigationProvider>().backPage();
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PopScope(
            onPopInvoked: (value) => _onBackKey(),
            canPop: false,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              bottomNavigationBar: NavigationBar(
                key: navigationBarKey,
                destinations: navigationDestinationsList,
                selectedIndex: context.read<NavigationProvider>().navbarIndex,
                onDestinationSelected: (int index) {
                  context.read<NavigationProvider>().navigatorBarNavigationReset(navigatorIndex: index);
                },
              ),
              body: ScaleIndexedStack(
                duration: const Duration(milliseconds: 100),
                beginScale: context.read<NavigationProvider>().transitionScaleFactor,
                endScale: 1,
                index: context.watch<NavigationProvider>().pageWidgetCacheIndex,
                children: context.read<NavigationProvider>().pageWidgetCache,
              ),
            ),
          );
        } else {
          return const FrontPage();
        }
      },
    );
  }
}
