import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';
import 'package:creative_app/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) => Add_Task_Screen(
            textController: TextEditingController(),
          ),
        );
      },
      backgroundColor: MyColors.trashRed,
      elevation: 5,
      child: Container(
        child: Container(
          child: Image.asset(
            'assets/images/fab-add.png',
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          boxShadow: [boxShadow(MyColors.purpleShadow)],
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              MyColors.purpleLight,
              MyColors.purpleDark,
            ],
          ),
        ),
      ),
    );
  }
}
