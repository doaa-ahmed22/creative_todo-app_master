import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';
import 'package:flutter/material.dart';

Widget buildListView(BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(20, 5, 20, 15),
    child: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 0.2,
          ),
          Container(
            width: 7,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.check_circle,
                    size: 20,
                    color: Colors.green,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    '08.00 AM',
                    style: TextStyle(color: MyColors.textGrey, fontSize: 12),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Send project file',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notification_add,
                      size: 20,
                      color: MyColors.greyBorder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    width: MediaQuery.of(context).size.width,
    height: 55,
    decoration: BoxDecoration(
      color: Colors.white,
      gradient: LinearGradient(
        stops: [0.015, 0.015],
        colors: [MyColors.yellowIcon, Colors.white],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [boxShadow(MyColors.greyBorder)],
    ),
  );
}
