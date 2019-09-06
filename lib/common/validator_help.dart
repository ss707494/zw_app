
import 'package:flutter/material.dart';

enum HelpValidatorType {
  require
}

class HelpValidatorDescription {

  final HelpValidatorType type;
  final Function dealMsg;

  HelpValidatorDescription({this.type, this.dealMsg});
}

FormFieldValidator<String> helpValidator({
  List<HelpValidatorDescription> types = const []
}) {

  return (String value) {
    return types.fold('', (pre, HelpValidatorDescription e) {
      if (pre != '') {
        return pre;
      }
      if (e.type == HelpValidatorType.require) {
        if (value == '' || value?.trim() == '') {
          return pre + e.dealMsg();
        }
      }
      return '';
    });
  };
}
