import 'package:fast_app_base/common/dart/extension/num_duration_extension.dart';
import 'package:fast_app_base/screen/main/tab/tab_item.dart';
import 'package:fast_app_base/screen/main/tab/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/common.dart';
import 'fab/w_floating_daangn_button.dart';
import 'w_menu_drawer.dart';

final currentTabProvider = StateProvider<TabItem>((ref) => TabItem.home);

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends ConsumerState<MainScreen> with SingleTickerProviderStateMixin {

  // final tabs = [TabItem.home, TabItem.favorite];
  final tabs = TabItem.values;

  // final List<GlobalKey<NavigatorState>> navigatorKeys = [];
  final List<GlobalKey<NavigatorState>> navigatorKeys =
      TabItem.values.map((e) => GlobalKey<NavigatorState>()).toList();

  // TabItem get _currentTab => ref.read(currentTabProvider);
  TabItem get _currentTab => ref.watch(currentTabProvider);
  int get _currentIndex => tabs.indexOf(_currentTab);

  GlobalKey<NavigatorState> get _currentTabNavigationKey =>
      navigatorKeys[_currentIndex];

  bool get extendBody => true;

  static double get bottomNavigationBarBorderRadius => 30.0;
  static const bottomNavigationBarHeight = 95.0;

  bool isFabExpanded = false;

  @override
  void initState() {
    super.initState();
    // initNavigatorKeys();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Material(
        // Stack: 내부에는 Material이 없기 때문에 Material위젯으로 감싸야합니다.
        child: Stack(
          children: [
            // Scaffold: 내부에는 Material이 이미 적용되어있습니다.
            Scaffold(
              extendBody: extendBody, //bottomNavigationBar 아래 영역 까지 그림
              drawer: const MenuDrawer(),
              body: Container(
                color:
                    context.appColors.seedColor.getMaterialColorValues[200],
                padding: EdgeInsets.only(
                    bottom: extendBody
                        ? 60 - bottomNavigationBarBorderRadius
                        : 0),
                child: SafeArea(
                  bottom: !extendBody,
                  child: pages,
                ),
              ),
              bottomNavigationBar: _buildBottomNavigationBar(context),
            ),
            // if (_currentTab != TabItem.chat)
            AnimatedOpacity(
              opacity: _currentTab != TabItem.chat ? 1 : 0,
              child: FloatingDaangnButton(),
              duration: 300.ms,
            ),
          ],
        ),
      ),
    );
  }

  IndexedStack get pages => IndexedStack(
      index: _currentIndex,
      children: tabs
          .mapIndexed((tab, index) => Offstage(
                offstage: _currentTab != tab,
                child: TabNavigator(
                  navigatorKey: navigatorKeys[index],
                  tabItem: tab,
                ),
              ))
          .toList());

  Future<bool> _handleBackPressed() async {
    final isFirstRouteInCurrentTab =
        (await _currentTabNavigationKey.currentState?.maybePop() == false);
    if (isFirstRouteInCurrentTab) {
      if (_currentTab != TabItem.home) {
        _changeTab(tabs.indexOf(TabItem.home));
        return false;
      }
    }
    // maybePop 가능하면 나가지 않는다.
    return isFirstRouteInCurrentTab;
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: bottomNavigationBarHeight,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(bottomNavigationBarBorderRadius),
          topRight: Radius.circular(bottomNavigationBarBorderRadius),
        ),
        child: BottomNavigationBar(
          items: navigationBarItems(context),
          currentIndex: _currentIndex,
          selectedItemColor: context.appColors.text,
          unselectedItemColor: context.appColors.iconButtonInactivate,
          onTap: _handleOnTapNavigationBarItem,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> navigationBarItems(BuildContext context) {
    // final currentTab = ref.watch(currentTabProvider);
    // final currentIndex = tabs.indexOf(currentTab);
    return tabs
        .mapIndexed(
          (tab, index) => tab.toNavigationBarItem(
            context,
            // isActivated: currentIndex == index,
            isActivated: _currentIndex == index,
          ),
        )
        .toList();
  }

  void _changeTab(int index) {
    ref.read(currentTabProvider.notifier).state = tabs[index];
    // setState(() {
    //   _currentTab = tabs[index];
    // });
  }

  BottomNavigationBarItem bottomItem(bool activate, IconData iconData,
      IconData inActivateIconData, String label) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(label),
          activate ? iconData : inActivateIconData,
          color: activate
              ? context.appColors.iconButton
              : context.appColors.iconButtonInactivate,
        ),
        label: label);
  }

  void _handleOnTapNavigationBarItem(int index) {
    final oldTab = _currentTab;
    final targetTab = tabs[index];
    if (oldTab == targetTab) {
      final navigationKey = _currentTabNavigationKey;
      popAllHistory(navigationKey);
    }
    _changeTab(index);
  }

  void popAllHistory(GlobalKey<NavigatorState> navigationKey) {
    final bool canPop = navigationKey.currentState?.canPop() == true;
    if (canPop) {
      while (navigationKey.currentState?.canPop() == true) {
        navigationKey.currentState!.pop();
      }
    }
  }

// void initNavigatorKeys() {
//   for (final _ in tabs) {
//     navigatorKeys.add(GlobalKey<NavigatorState>());
//   }
// }
}
