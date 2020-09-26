import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:soulhealer/di/injection.dart';

import 'message_hero_view_model.dart';
import 'pending_messages_view.dart';
import 'recent_messages_view.dart';

class MessageHeroView extends StatefulWidget {
  @override
  _MessageHeroViewState createState() => _MessageHeroViewState();
}

class _MessageHeroViewState extends State<MessageHeroView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  MessageHeroViewModel _messageHeroViewModel;

  @override
  void initState() {
    _messageHeroViewModel = injection<MessageHeroViewModel>();

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _messageHeroViewModel.changeTab(_tabController.index);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<MessageHeroViewModel>.withConsumer(
        viewModelBuilder: () => _messageHeroViewModel,
        disposeViewModel: true,
        onModelReady: (model) => model.init(),
        builder: (context, MessageHeroViewModel model, child) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Color(0xFF0A6C79),
              appBar: _appBar(),
              body: TabBarView(
                controller: _tabController,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  RecentMessagesView(),
                  PendingMessagesView(),
                ],
              ),
            ),
          );
        });
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(48),
          ),
          child: TabBar(
            unselectedLabelColor: Color(0xFFAAAAAA),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Color(0XFF055762),
              borderRadius: BorderRadius.circular(48),
            ),
            controller: _tabController,
            tabs: [
              Tab(child: Text('Messages', style: TextStyle(fontSize: 17))),
              Tab(child: Text('Pendings', style: TextStyle(fontSize: 17))),
            ],
          ),
        ),
      ),
    );
  }
}
