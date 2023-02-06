import 'package:flutter/material.dart';


Widget buildToast(String message, double toastWidth, double fSize) {
  return Container(
    width: toastWidth,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black87
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Image.asset("assets/logos/app_icon_round.png"),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Text(
            message,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.blue, fontSize: fSize, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
          ),
        )
      ],
    ),
  );
}