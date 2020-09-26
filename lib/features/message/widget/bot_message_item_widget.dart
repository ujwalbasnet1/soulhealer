import 'package:flutter/material.dart';
import 'package:soulhealer/data_sources/message/models/chat_bot_message_item_model.dart';

class BotMessageItemWidget extends StatelessWidget {
  final ChatBotMessageItemModel model;
  final ChatBotMessageItemModel pastModel;

  bool get byMe => (model?.sender?.compareTo("USER") ?? 1) == 0;
  bool get pastByMe => (pastModel?.sender?.compareTo("USER") ?? 1) == 0;

  const BotMessageItemWidget({
    Key key,
    @required this.model,
    this.pastModel,
  }) : super(key: key);

  Widget _getNameWidget() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 16,
      child: Center(
        child: Text("SH",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                textAlign: TextAlign.start,
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
