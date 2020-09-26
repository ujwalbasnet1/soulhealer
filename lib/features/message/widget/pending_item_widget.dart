import 'package:flutter/material.dart';
import 'package:soulhealer/data_sources/message/models/pending_conversation_response.dart';

class PendingItemWidget extends StatelessWidget {
  final HeroConversationResponseModel model;
  final Widget actions;

  const PendingItemWidget({Key key, @required this.model, this.actions})
      : super(key: key);

  Widget _getNameWidget() {
    String _text = (model?.user?.name ?? "SH");
    if (_text.length < 2) {
      _text += "  ";
    }

    return Container(
      width: (actions != null) ? 64 : 44,
      height: (actions != null) ? 64 : 44,
      decoration: BoxDecoration(
        color: Color(0xFF055762),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Center(
        child: Text(
          _text[0].toUpperCase() + _text[1].toUpperCase(),
          style: TextStyle(
              fontSize: (actions != null) ? 16 : 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEEEEEE)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: (actions != null) ? (64 + 16.0) : (44 + 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getNameWidget(),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  model.recentMessage,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEEEEEE),
                  ),
                ),
                SizedBox(height: (actions != null) ? 8 : 0),
                actions ?? SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
