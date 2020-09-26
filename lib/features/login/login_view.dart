import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: ViewModelProvider<LoginViewModel>.withConsumer(
          viewModelBuilder: () => LoginViewModel(),
          disposeViewModel: true,
          builder: (context, LoginViewModel model, child) {
            return Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/tree.jpg"),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(1.0), BlendMode.plus),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black12,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.52,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      Text(
                        'SOUL HEALER',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.teal,
                          fontFamily: 'CormorantGaramond',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        '- Way to share feelings',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                            fontFamily: 'DancingScript'),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.6),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(color: Colors.teal, width: 1)),
                        textColor: Colors.teal,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                        color: Colors.white70,
                        onPressed: model.loading
                            ? null
                            : () {
                                model.googleLogin();
                              },
                        child: Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.google),
                            SizedBox(
                              width: 16,
                            ),
                            Text(' Continue with google'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                            side: BorderSide(width: 1, color: Colors.teal)),
                        textColor: Colors.teal,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                        color: Colors.white70,
                        onPressed: model.loading
                            ? null
                            : () {
                                model.loginHidden();
                              },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            SizedBox(
                              width: 16,
                            ),
                            Text(' Continue Anonymously'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       'Already have an account? ',
                    //       style: TextStyle(
                    //           color: Colors.black54,
                    //           fontFamily: 'CormorantGaramond',
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     Text(
                    //       'Sign In ',
                    //       style: TextStyle(
                    //           color: Colors.teal,
                    //           fontFamily: 'CormorantGaramond',
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                model.loading ? _loader(context) : SizedBox.shrink(),
              ],
            );
          }),
    );
  }

  Widget _loader(context) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black38,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
}
