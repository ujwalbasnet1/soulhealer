import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:soulhealer/features/message/hero/message_hero_view_model.dart';
import 'package:soulhealer/features/message/widget/pending_item_widget.dart';

class PendingMessagesView extends ProviderWidget<MessageHeroViewModel> {
  @override
  Widget build(BuildContext context, MessageHeroViewModel model) {
    return _buildBody(model);
  }

  _buildBody(MessageHeroViewModel model) {
    if (model.loadingPending) {
      return Center(child: _buildLoading());
    }

    if (model.pendingError != null) {
      return Center(
        child: _buildError(model.pendingError, model.getPendingConversations),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await model.getPendingConversations(refresh: true);
        return null;
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: model?.pendingConversations?.length ?? 0,
        separatorBuilder: (_, __) =>
            Divider(height: 6, color: Color(0xFF012b33).withOpacity(0.25)),
        itemBuilder: (context, index) {
          final _conversation = model.pendingConversations[index];
          final bool _accepting =
              ((model?.accepting?.compareTo(_conversation.sId) ?? -1) == 0);

          return PendingItemWidget(
            model: _conversation,
            actions: Container(
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xFF055762),
                borderRadius: BorderRadius.circular(48),
              ),
              child: RaisedButton(
                color: Colors.transparent,
                elevation: 0,
                child: _accepting
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      )
                    : Text("Accept",
                        style: TextStyle(color: Color(0xFFEEEEEE))),
                onPressed: _accepting
                    ? null
                    : () {
                        model.acceptConversation(_conversation);
                      },
              ),
            ),
          );
        },
      ),
    );
  }

  _buildLoading() => CircularProgressIndicator();

  _buildError(String message, Function tryAgain) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(message,
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          OutlineButton(
            child: Text("Try Again"),
            onPressed: tryAgain,
          )
        ],
      );
}
