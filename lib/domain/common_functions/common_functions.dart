import 'package:fluttertoast/fluttertoast.dart';
import 'package:wegrow_task_flutter/core/utils/color_constant.dart';

class CommonFunctions {
  void showToast({required String message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: ConfigColors.lightGrey,
        textColor: ConfigColors.grayWhite,
        fontSize: 16.0);
  }
}
