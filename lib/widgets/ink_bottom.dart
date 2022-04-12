import 'package:creative_app/constants/colors.dart';
import 'package:creative_app/constants/styles.dart';

import 'package:flutter/material.dart';

Widget buildListTile(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white,
      gradient: LinearGradient(
        stops: [0.015, 0.015],
        colors: [MyColors.yellowIcon, Colors.white],
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [boxShadow(MyColors.greyBorder)],
    ),
    width: MediaQuery.of(context).size.width,
    child: ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.panorama_fish_eye,
          color: Colors.red,
          size: 24,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         UpdateScreen(
          //             title: data[index]['title'],
          //             date: data[index]['date'],
          //             state: data[index]['state'],
          //             time: data[index]['time'],
          //             id: data[index]['id']),
          //   ),
          // );
        },
        icon: Icon(
          Icons.edit,
          size: 18,
          color: Colors.blue,
        ),
      ),
      title: Row(
        children: [
          Text(
            '08.00 PM',
            style: TextStyle(color: MyColors.textGrey, fontSize: 12),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              'text oooo ooooooo oooooooooo oooooooooooooooooooooooo',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}
// Container(
// margin: EdgeInsets.fromLTRB(20, 5, 20, 15),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// SizedBox(
// width: 0.2,
// ),
// Container(
// width: 7,
// height: 55,
// decoration: BoxDecoration(
// color: Colors.green,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(10),
// bottomLeft: Radius.circular(10)),
// ),
