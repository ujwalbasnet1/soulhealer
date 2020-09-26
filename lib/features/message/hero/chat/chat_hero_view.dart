import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:soulhealer/data_sources/message/models/pending_conversation_response.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/features/message/widget/message_item_widget.dart';

import 'chat_hero_view_model.dart';

class ChatHeroView extends StatefulWidget {
  final HeroConversationResponseModel item;

  const ChatHeroView({Key key, @required this.item}) : super(key: key);

  @override
  _ChatHeroViewState createState() => _ChatHeroViewState();
}

class _ChatHeroViewState extends State<ChatHeroView> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ChatHeroViewModel>.withConsumer(
        viewModelBuilder: () => injection<ChatHeroViewModel>(),
        onModelReady: (model) {
          model.init(widget.item);
        },
        disposeViewModel: true,
        builder: (context, ChatHeroViewModel model, child) {
          return Scaffold(
            backgroundColor: Color(0xFF0A6C79),
            appBar: AppBar(title: Text("Messages"), elevation: 0),
            body: _buildBody(model),
          );
        });
  }

  _buildBody(ChatHeroViewModel model) {
    if (model.loading) {
      return Center(child: _buildLoading());
    }

    if (model.hasFailure) {
      return Center(child: _buildError(model.failure, model.getMessages));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await model.getMessages(refresh: true);
        return null;
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: model.reverseMessages.length + 1,
        separatorBuilder: (_, __) => SizedBox(height: 8),
        reverse: true,
        itemBuilder: (context, index) {
          if (index == 0) return _buildChatField(context, model);
          return MessageItemWidget(
            model: model.reverseMessages[index - 1],
            pastModel:
                ((index - 2) >= 0 && (index - 2) < model.reverseMessages.length)
                    ? model.reverseMessages[index - 2]
                    : null,
          );
        },
      ),
    );
  }

  _buildChatField(BuildContext context, ChatHeroViewModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Color(0xFF055762),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: _controller,
              cursorColor: Colors.white,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: "Write your message here",
                  
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white30)),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              model.sendMessage(_controller?.text?.trim() ?? null);
              setState(() => _controller.text = "");
            },
          ),
        ],
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
