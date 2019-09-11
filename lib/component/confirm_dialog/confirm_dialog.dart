
import 'package:flutter/material.dart';

showConfirmDialog({
  context,
  Widget content,
  handleOk,
  handleCancel,
}) {
  handleCancel ??= () async {};
  handleOk ??= () async {};
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: content,
      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          onPressed: () async {
            await handleCancel();
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('确认'),
          onPressed: () async {
            var okRes = (await handleOk()) ?? true;
            if (okRes) {
              Navigator.of(context).pop();
            } else {
            }
          },
        ),
      ],
    ),
  );
}
