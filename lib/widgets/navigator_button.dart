import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/screens/myhome_page.dart';
import 'package:creative_app/screens/mytask_page.dart';
import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  final int intIndex;
  final BuildContext context;
  const NavigatorButton(
      {Key? key, required this.intIndex, required this.context})
      : super(key: key);

  void onTaped(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return (index == 1) ? MyTaskPage() : MyHomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedFontSize: 10,
      selectedLabelStyle: TextStyle(color: MyColors.blueDark),
      selectedItemColor: MyColors.blueDark,
      unselectedFontSize: 10,
      type: BottomNavigationBarType.fixed,
      currentIndex: intIndex,
      onTap: onTaped,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/images/home.png',
              color: intIndex == 0 ? MyColors.blueDark : MyColors.textGrey,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Image.asset(
              'assets/images/task.png',
              color: intIndex == 1 ? MyColors.blueDark : MyColors.textGrey,
            ),
          ),
          label: 'Task',
        ),
      ],
    );
  }
}
