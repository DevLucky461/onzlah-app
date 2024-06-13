import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/live_page.dart';

class UserCount extends StatelessWidget {
  final LiveEvent cur_event;

  UserCount(this.cur_event);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  cur_event.usercount != null ? cur_event.usercount.toString() : '0',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  cur_event.stickercount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
