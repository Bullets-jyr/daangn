import 'package:easy_localization/easy_localization.dart';
import 'package:fast_app_base/common/dart/extension/num_extension.dart';

final decimalFormat = NumberFormat.decimalPattern("en");

extension IntExt2 on int {
  String toWon() {
    return "${toComma()}원!!!";
  }
}
