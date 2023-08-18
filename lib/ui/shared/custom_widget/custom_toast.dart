import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testofcourse/core/enums/message_type.dart';
import 'package:testofcourse/ui/shared/colors.dart';
import 'package:testofcourse/ui/shared/extension_sizebox.dart';

class CustomToast {
  static showMessage(
      {required Size size,
      required String message,
      MessageType? messageType = MessageType.INFO}) {
    String imageName = 'info';
    Color shadowColor = AppColors.mainBlueColor;
    switch (messageType) {
      case MessageType.REJECTED:
        imageName = 'rejected-01';
        shadowColor = AppColors.mainRedColor;
        break;
      case MessageType.SUCCESS:
        imageName = 'approved1-01';
        shadowColor = Colors.green;
        break;
      case MessageType.WARNING:
        imageName = 'warning';
        shadowColor = Colors.orange;
        break;
      default:
        break;
    }
    BotToast.showCustomText(
        duration: const Duration(seconds: 3),
        toastBuilder: (value) {
          return Container(
            padding: EdgeInsets.only(top: 5),
            width: size.width * 0.75,
            decoration: BoxDecoration(
                color: AppColors.textColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'images/$imageName.svg',
                  width: size.width * 0.17,
                  height: size.width * 0.17,
                ),
                15.ph,
                Text(
                  message,
                  style: TextStyle(fontSize: size.width * 0.050),
                  textAlign: TextAlign.center,
                ),
                15.ph,
              ],
            ),
          );
        });
  }
}
