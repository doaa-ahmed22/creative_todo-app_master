import 'package:creative_app/constants/styles.dart';

import 'package:creative_app/widgets/my_appbar.dart';
import 'package:creative_app/widgets/navigator_button.dart';
import 'package:creative_app/widgets/plus_button.dart';
import 'package:flutter/material.dart';

class NoTask extends StatefulWidget {
  @override
  State<NoTask> createState() => _NoTaskState();
}

class _NoTaskState extends State<NoTask> {
  var intIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: myAppBar(),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: Hero(
                  child: Image.asset('assets/images/Clipboard-empty.png'),
                  tag: 'dodo',
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      'No Task',
                      style: title,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'You have no tasks to do.',
                      style: subTitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PlusButton(),
      bottomNavigationBar: NavigatorButton(
        context: context,
        intIndex: intIndex,
      ),
    );
  }
}
