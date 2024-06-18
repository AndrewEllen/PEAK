import 'package:flutter/cupertino.dart';
import 'package:peak/pages/home/home_page.dart';
import 'package:peak/pages/post/new_post_page.dart';
import 'package:peak/pages/profile/profile_page.dart';
import 'package:peak/pages/search/search_page.dart';

class NavigationProvider with ChangeNotifier {

  final pages = [
    const HomePage(),
    const SearchPage(),
    const NewPostPage(),
    const ProfilePage(),
  ];

  late bool _navigationBarCache = true;
  bool get navigationBarCache => _navigationBarCache;

  final double defaultScale = 0.9;
  final double defaultBackScale = 1.1;

  late double _transitionScaleFactor = defaultScale;

  double get transitionScaleFactor => _transitionScaleFactor;

  late bool _dataLoadingFromSplashPage = true;

  bool get dataLoadingFromSplashPage => _dataLoadingFromSplashPage;

  late bool _caloriesCalculated = false;

  bool get caloriesCalculated => _caloriesCalculated;

  Widget _pageWidget = const HomePage();
  List<Widget> _pageWidgetCache = [const HomePage()];
  int _pageWidgetCacheIndex = 0;
  int _navbarIndex = 0;

  Widget get pageWidget => _pageWidget;
  List<Widget> get pageWidgetCache => _pageWidgetCache;
  int get pageWidgetCacheIndex => _pageWidgetCacheIndex;
  int get navbarIndex => _navbarIndex;

  late bool _confirmation = false;

  bool get confirmation => _confirmation;

  void setCaloriesCalculated(bool _dataLoaded) {

    _caloriesCalculated = _dataLoaded;

    notifyListeners();
  }

  void setDataLoadingStatus(bool _dataLoaded) {

    _dataLoadingFromSplashPage = _dataLoaded;

    notifyListeners();
  }

  void changePageRemovePreviousCache({required Widget newPage}) {

    if (_navigationBarCache) {
      _navigationBarCache = false;
      _pageWidgetCache = [_pageWidget];
    }

    setTransitionScale(defaultScale);

    _pageWidget = newPage;

    _pageWidgetCache.add(_pageWidget);
    _pageWidgetCache.removeAt(_pageWidgetCache.length-2);

    _pageWidgetCacheIndex = _pageWidgetCache.length - 1;

    debugPrint(_pageWidgetCache.toString());
    notifyListeners();
  }

  void navigatorBarNavigationReset({required int navigatorIndex}) {

    setTransitionScale(defaultBackScale);

    _navigationBarCache = true;

    _pageWidgetCache = pages;
    _pageWidgetCacheIndex = navigatorIndex;
    _navbarIndex = navigatorIndex;

    _pageWidget = pages[navigatorIndex];

    debugPrint(_pageWidgetCache.toString());
    notifyListeners();
  }



  void changePageClearCache({required Widget newPage}) {

    if (_navigationBarCache) {
      _navigationBarCache = false;
      _pageWidgetCache = [_pageWidget];
    }

    setTransitionScale(defaultBackScale);
    _confirmation = false;
    _pageWidget = newPage;

    _pageWidgetCache = [_pageWidget];
    _pageWidgetCacheIndex = 0;

    debugPrint(_pageWidgetCache.toString());
    notifyListeners();
  }

  void changePageCache({required Widget newPage}) {

    if (_navigationBarCache) {
      _navigationBarCache = false;
      _pageWidgetCache = [_pageWidget];
    }

    setTransitionScale(defaultScale);

    _pageWidget = newPage;

    if (_pageWidgetCache.isEmpty) {
      _pageWidgetCache.add(_pageWidget);
      _pageWidgetCacheIndex = _pageWidgetCache.length-1;
    } else if (newPage != _pageWidgetCache.last) {
      _pageWidgetCache.add(newPage);
      _pageWidgetCacheIndex = _pageWidgetCache.length-1;
      //if (_pageWidgetCache.length > 5) {
      //  _pageWidgetCache.removeAt(0);
      //  _pageWidgetCacheIndex = _pageWidgetCache.length-1;
      //}
    }

    debugPrint("Page Widget Cache");
    debugPrint(_pageWidgetCache.toString());
    notifyListeners();
  }

  void setTransitionScale(double scale) {

    _transitionScaleFactor = scale;
    notifyListeners();

  }

  void backPage() {

  setTransitionScale(defaultBackScale);

    _confirmation = false;
    _pageWidgetCache.removeLast();
    _pageWidgetCacheIndex = _pageWidgetCache.length-1;

    if (_pageWidgetCache.isEmpty) {
      debugPrint("Returning to home page");
      _pageWidgetCache.addAll(pages);
      _pageWidgetCacheIndex = 0;
      _navbarIndex = 0;
      _navigationBarCache = true;
    }

    debugPrint(_pageWidgetCache.toString());
    notifyListeners();

  }
}
