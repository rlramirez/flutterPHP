import 'package:flutter/material.dart';
import 'package:flutter_9nov24/users/fragments/home_fragment_screen.dart';
import 'package:flutter_9nov24/users/fragments/order_fragment_screen.dart';
import 'package:flutter_9nov24/users/fragments/profile_fragment_screen.dart';
import 'package:flutter_9nov24/users/userPreferences/current_user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DashboardOfFragments extends StatelessWidget {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
  List<Widget> _fragmentScreen = [
    HomeFragmentScreen(),
    OrderFragmentScreen(),
    ProfileFragmentScreen(),
  ];

  List _navigationButtonsProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_max_outlined,
      "label": "home",
    },
    {
      "active_icon": FontAwesomeIcons.boxOpen,
      "non_active_icon": FontAwesomeIcons.box,
      "label": "home",
    },
    {
      "active_icon": FontAwesomeIcons.person,
      "non_active_icon": FontAwesomeIcons.personArrowUpFromLine,
      "label": "Profime",
    },
  ];

  RxInt _indexNumber = 0.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currentState) {
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Obx(() => _fragmentScreen[_indexNumber.value]),
            ),
            bottomNavigationBar: Obx(
              () => BottomNavigationBar(
                currentIndex: _indexNumber.value,
                onTap: (value) {
                  _indexNumber.value = value;
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: Colors.white,
                unselectedItemColor: Color.fromRGBO(112, 112, 112, 1),
                backgroundColor: Color(0xFF3D3D3D),
                items: List.generate(3, (index) {
                  var navBtnProperty = _navigationButtonsProperties[index];
                  return BottomNavigationBarItem(
                    // backgroundColor: Color.fromARGB(255, 226, 230, 4),
                    icon: Icon(
                      navBtnProperty["non_active_icon"],
                    ),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"],
                  );
                }),
              ),
            ));
      },
    );
  }
}
