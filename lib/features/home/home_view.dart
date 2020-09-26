import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:soulhealer/common/k_toast.dart';
import 'package:soulhealer/common/user_data_service.dart';
import 'package:soulhealer/core/navigation/navigation_service.dart';
import 'package:soulhealer/core/navigation/routes.gr.dart';
import 'package:soulhealer/data_sources/auth/models/models.dart';
import 'package:soulhealer/di/injection.dart';
import 'package:soulhealer/features/home/quote_item_widget.dart';
import 'package:soulhealer/features/message/user_bot/user_bot_view.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModelBuilder: () => HomeViewModel(),
        disposeViewModel: true,
        onModelReady: (model) => model.init(),
        builder: (context, HomeViewModel model, child) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: _appBar(),
              body: _body(model),
              floatingActionButton: (UserDataService().user.userType ==
                      UserType.USER)
                  ? FloatingActionButton(
                      onPressed: () {
                        injection<NavigationService>().navigate(UserBotView());
                      },
                      child: Icon(Icons.message),
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  : null,
              bottomNavigationBar: _bottomNavBar(context),
            ),
          );
        });
  }

  Widget _body(HomeViewModel model) {
    if (model.loading) {
      return Center(child: _buildLoading());
    }

    if (model.hasFailure) {
      return Center(child: _buildError(model.failure, model.init));
    }

    return TabBarView(
      physics: BouncingScrollPhysics(),
      children: [
        RefreshIndicator(
          onRefresh: () async {
            await model.init();
            return null;
          },
          child: ListView(
            children: <Widget>[
              Container(
                height: 364,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (_, __) => QuoteItemWidget(),
                  separatorBuilder: (_, __) => SizedBox(width: 16),
                ),
              ),
            ],
          ),
        ),
        RefreshIndicator(
          onRefresh: () async {
            await model.init();
            return null;
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: BouncingScrollPhysics(),
            itemCount: getMusics().length,
            itemBuilder: (context, index) => Card(
              child: InkWell(
                onTap: () async {
                  final url =
                      "https://www.youtube.com/watch?v=${getMusics()[index].id}";
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    KToast.e('Could not play the music');
                  }
                },
                child: Row(
                  children: <Widget>[
                    Image.network(
                      "https://img.youtube.com/vi/${getMusics()[index].id}/default.jpg",
                      height: 72,
                      width: 72,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        getMusics()[index].name,
                        style: TextStyle(
                          color: Color(0xFF303030),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (_, __) => SizedBox(height: 8),
          ),
        ),
      ],
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

  Widget _bottomNavBar(BuildContext context) {
    return InkWell(
      onTap: () {
        injection<NavigationService>().navigateToRoute(Routes.messageRoute);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF0A6C79),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Messages",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Icon(Icons.keyboard_arrow_up, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Image.asset(
        'assets/images/soulhealer.png',
        fit: BoxFit.cover,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.lock, color: Colors.black),
          onPressed: () {
            injection<NavigationService>().navigateToRoute(Routes.loginRoute);
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(64),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(48),
          ),
          child: TabBar(
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Color(0XFF055762),
              borderRadius: BorderRadius.circular(48),
            ),
            tabs: [
              Tab(child: Text('Quotes', style: TextStyle(fontSize: 19))),
              Tab(child: Text('Music', style: TextStyle(fontSize: 19))),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicItem {
  final String id;
  final String name;

  MusicItem(this.id, this.name);
}

List<MusicItem> getMusics() => [
      MusicItem(
        "lFcSrYw-ARY",
        "Beautiful Relaxing Music for Stress Relief",
      ),
      MusicItem(
        "77ZozI0rw7w",
        "Relaxing Piano Music: Sleep Music, Water Sounds, Relaxing Music, Meditation Music",
      ),
      MusicItem(
        "mXw2aAforhg",
        "BRAIN CALMING MUSIC || Stress Relief & Nerve Regeneration",
      ),
      MusicItem(
        "2OEL4P1Rz04",
        "Beautiful Relaxing Music for Stress Relief • Meditation Music",
      ),
      MusicItem(
        "pjtsGzQjFM4",
        "Bamboo water fountain healing music",
      ),
      MusicItem(
        "JLJqUipWRWk",
        "Instant Relief From Anxiety & Stress Peaceful Meditation Music, Deep Relaxing & Healing Music",
      ),
      MusicItem(
        "bP9gMpl1gyQ",
        "Relaxing Sleep Music + Insomnia - Stress Relief",
      ),
      MusicItem(
        "mXw2aAforhg",
        "BRAIN CALMING MUSIC || Stress Relief & Nerve Regeneration",
      ),
      MusicItem(
        "mXw2aAforhg",
        "BRAIN CALMING MUSIC || Stress Relief & Nerve Regeneration",
      ),
    ];
