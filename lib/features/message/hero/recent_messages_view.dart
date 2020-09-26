import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:soulhealer/features/message/hero/message_hero_view_model.dart';
import 'package:soulhealer/features/message/widget/pending_item_widget.dart';

class RecentMessagesView extends ProviderWidget<MessageHeroViewModel> {
  @override
  Widget build(BuildContext context, MessageHeroViewModel model) {
    return _buildBody(model);
  }

  _buildBody(MessageHeroViewModel model) {
    if (model.loadingRecent) {
      return Center(child: _buildLoading());
    }

    if (model.recentError != null) {
      return Center(
        child: _buildError(model.recentError, model.getRecentConversations),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await model.getRecentConversations(refresh: true);
        return null;
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: model?.recentConversations?.length ?? 0,
        separatorBuilder: (_, __) => Divider(height: 6, color: Color(0xFF012b33).withOpacity(0.25)),
        itemBuilder: (context, index) {
          final _conversation = model.recentConversations[index];
          return InkWell(
            onTap: () => model.onRecentChatItemPressed(_conversation),
            child: PendingItemWidget(model: _conversation),
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
