import 'package:flutter/material.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:soulhealer/features/splash/splash_view_model.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelProvider<SplashViewModel>.withConsumer(
          viewModelBuilder: () => SplashViewModel(),
          onModelReady: (model) => model.initialize(),
          disposeViewModel: true,
          staticChild: Container(color: Theme.of(context).primaryColor),
          builder: (context, SplashViewModel model, child) {
            return child;
          }),
    );
  }
}
