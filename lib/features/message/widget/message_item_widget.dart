import 'package:flutter/material.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/data_sources/message/models/messages_response.dart';

class MessageItemWidget extends StatelessWidget {
  final MessageItemResponseModel model;
  final MessageItemResponseModel pastModel;

  bool get byMe =>
      (model?.sender?.sId?.compareTo(UserDataService().chatId) ?? 1) == 0;
  bool get pastByMe =>
      (pastModel?.sender?.sId?.compareTo(UserDataService().chatId) ?? 0) == 0;

  const MessageItemWidget({
    Key key,
    @required this.model,
    this.pastModel,
  }) : super(key: key);

  Widget _getNameWidget() {
    String _text = (model?.sender?.name ?? "SH");
    if (_text.length < 2) {
      _text += "  ";
    }

    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 16,
      child: Center(
        child: Text(_text[0].toUpperCase() + _text[1].toUpperCase(),
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model.sender == null || model.sender.sId == null) {
      return Row(
        children: <Widget>[
          Spacer(),
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFF055762),
              ),
              child: Text(
                model.message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFDDDDDD), fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Spacer(),
        ],
      );
    }

    if (byMe) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Spacer(),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFF055762),
                ),
                child: Text(
                  model.message,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Color(0xFFDDDDDD)),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: <Widget>[
        (pastByMe) ? _getNameWidget() : SizedBox(width: 32),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFF055762),
              ),
              child: Text(
                model.message,
                textAlign: TextAlign.end,
                style: TextStyle(color: Color(0xFFDDDDDD)),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
