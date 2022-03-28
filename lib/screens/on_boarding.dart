import 'package:creative_app/constantes/styles.dart';
import 'package:creative_app/screens/no_task.dart';
import 'package:flutter/material.dart';

import '../constantes/colors.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // width: double.infinity,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Hero(
                  child: Image.asset('assets/images/Clipboard.png'),
                  tag: 'dodo',
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text('Reminders made simple', style: title),
                    SizedBox(height: 15),
                    Text(
                      'Notes is an intuitive, lightweight notepad application that allows you to capture and organize your ideas. Supports import/export, pattern screen lock features.',
                      style: subTitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoTask(),
                      ),
                    );
                  },
                  textColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          MyColors.greenLight,
                          MyColors.greenDark,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        boxShadow(MyColors.greenShadow),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
