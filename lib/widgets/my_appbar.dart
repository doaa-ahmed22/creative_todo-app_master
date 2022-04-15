import 'package:creative_app/bloc/bloc_state.dart';
import 'package:creative_app/bloc/cubit.dart';
import 'package:creative_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

Widget appBarNotification(BuildContext context) {
  return BlocConsumer<AppCubit, AppStates>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      AppCubit cubit = AppCubit.get(context);
      return NewGradientAppBar(
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomPaint(
              painter: CircleOne(),
            ),
            CustomPaint(
              painter: CircleTwo(),
            ),
          ],
        ),
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello Doaa!',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                'You have ${AppCubit.get(context).data.length} tasks',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/photo.jpg',
              ),
            ),
          )
        ],
        elevation: 5,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MyColors.headerBlueDark, MyColors.headerBlueLight],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Container(
            height: 115,
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: MyColors.headerGreyLight,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Today Reminder',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        '${cubit.data[0]['title']}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'task time: ${cubit.data[0]['time']}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 75,
                  ),
                  width: MediaQuery.of(context).size.width / 2.9,
                  child: Image.asset(
                    'assets/images/bell-left.png',
                    scale: .2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 80,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.clear,
                      color: MyColors.greyBorder,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget myAppBar() {
  return NewGradientAppBar(
    flexibleSpace: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomPaint(
          painter: CircleOne(),
        ),
        CustomPaint(
          painter: CircleTwo(),
        ),
      ],
    ),
    title: Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Hello Doaa!',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Text(
            'Today you have no tasks',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'assets/images/photo.jpg',
          ),
        ),
      )
    ],
    elevation: 5,
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [MyColors.headerBlueDark, MyColors.headerBlueLight],
    ),
  );
}

class CircleOne extends CustomPainter {
  late Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = MyColors.headerCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(30, 0.0), 100, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  late Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = MyColors.headerCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 60.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
