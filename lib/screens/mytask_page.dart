import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';
import 'package:creative_app/screens/my_list_tasks.dart';
import 'package:creative_app/widgets/my_appbar.dart';
import 'package:creative_app/widgets/navigator_button.dart';
import 'package:creative_app/widgets/plus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTaskPage extends StatelessWidget {
  final intIndex = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSelectTypeState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyListTasks(),
            ),
          );
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(210),
            child: appBarNotification(context),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) => Container(
                      margin: EdgeInsets.only(left: 10, top: 15, bottom: 0),
                      child: Text(
                        'Projects',
                        style: subTitle,
                      ),
                    ),
                    childCount: 1,
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: 2,
                  children: [
                    boxContainer('assets/images/icon-user.png', 'Personal',
                        '${cubit.personalCount} Task', () {
                      cubit.pickedTypeTasks('Personal');
                    }),
                    boxContainer('assets/images/icon-briefcase.png', 'Work',
                        '${cubit.workCount} Task', () {
                      cubit.pickedTypeTasks('Work');
                    }),
                    boxContainer('assets/images/icon-presentation.png',
                        'Meeting', '${cubit.meetingCount} Task', () {
                      cubit.pickedTypeTasks('Meeting');
                    }),
                    boxContainer('assets/images/icon-molecule.png', 'Study',
                        '${cubit.studyCount} Task', () {
                      cubit.pickedTypeTasks('Study');
                    }),
                    boxContainer('assets/images/icon-shopping-basket.png',
                        'Shopping', '${cubit.shoppingCount} Task', () {
                      cubit.pickedTypeTasks('Shopping');
                    }),
                    boxContainer('assets/images/icon-confetti.png', 'Free Time',
                        '${cubit.freeTimeCount} Task', () {
                      cubit.pickedTypeTasks('Free Time');
                    }),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: PlusButton(),
          bottomNavigationBar: NavigatorButton(
            context: context,
            intIndex: intIndex,
          ),
        );
      },
    );
  }
}

Widget boxContainer(
    String image, String type, String subTitleText, Function onTapped) {
  return InkWell(
    onTap: onTapped as VoidCallback,
    child: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 65,
              width: 65,
              child: Image.asset(
                image,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: MyColors.yellowBackground),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              type,
              style: title,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              subTitleText,
              style: subTitle,
            ),
          ],
        ),
      ),
      height: 150,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [boxShadow(MyColors.greyBorder)],
      ),
    ),
  );
}
