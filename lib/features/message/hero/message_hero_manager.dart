import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soulhealer/core/logger/log.dart';
import 'package:soulhealer/data_sources/message/models/messages_response.dart';
import 'package:soulhealer/data_sources/message/models/models.dart';
import 'package:soulhealer/data_sources/socket/models/models.dart';
import 'package:soulhealer/data_sources/socket/socket_source.dart';
import 'package:soulhealer/di/injection.dart';

class MessageHeroManager {
  MessageHeroManager._();
  factory MessageHeroManager() {
    return _instance;
  }
  static final _instance = MessageHeroManager._();

  Log log = Log("MessageHeroStateManager");

  final ISocketService _socketService = injection<ISocketService>();

  init() {
    /* 
        - Initialize Socket [done]
        - Subscribe New Message [done]
    */

    _socketService.init();

    _socketService.subscribeToNewMessage((d) {
      log.d("SUSCRIBED TO MESSAGE $d");
    }).listen(_newMessageHandler);
  }

// TODO close
  StreamController _newMessagesController = StreamController<bool>.broadcast();
  Stream<bool> get newMessageListener => _newMessagesController.stream;

// -- conversations // START ----

  List<HeroConversationResponseModel> _recentConversations;
  List<HeroConversationResponseModel> get recentConversations =>
      _recentConversations;

  addRecentConversations(List<HeroConversationResponseModel> rc) {
    _recentConversations = rc;
  }

// -- conversations // END ----

  List<MessageItemResponseModel> _messages;
  List<MessageItemResponseModel> get messages => _messages;

  HeroConversationResponseModel _currentlyChatting;
  HeroConversationResponseModel get currentlyChatting => _currentlyChatting;
  setCurrentlyChatting(HeroConversationResponseModel currentlyChatting) =>
      _currentlyChatting = currentlyChatting;
  removeCurrentlyChatting() {
    _currentlyChatting = null;
    _messages = null;
  }

  void addPreviousMessages(List<MessageItemResponseModel> messages) {
    _messages = messages;
  }

  _newMessageHandler(SocketResponseModel newMessage) {
    log.d(newMessage.toJson().toString());

    if (_messages != null 
       )
      _messages.add(MessageItemResponseModel(
        sId: newMessage.sId,
        message: newMessage.message,
        sender: SenderResponseModel(
          sId: newMessage.sender,
        ),
        createdAt: newMessage.createdAt,
      ));

    _newMessagesController.add(true);

    if (_messages == null || _currentlyChatting == null) {
      showNotification({
        "notification": {
          "title": "New Message Received",
          "body": newMessage.message,
        }
      });
    }
  }

  addNewMessageByMe(SocketResponseModel newMessage) {
    _messages.add(MessageItemResponseModel(
      sId: newMessage.sId,
      message: newMessage.message,
      sender: SenderResponseModel(
        sId: newMessage.sender,
      ),
      createdAt: newMessage.createdAt,
    ));
    _newMessagesController.add(true);
  }
}

void showNotification(message) async {
  var messageNotification = message['notification'];
  print('Show Notification $messageNotification');
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('app_icon');

  var initializationSettingsIOS = new IOSInitializationSettings();

  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  FlutterLocalNotificationsPlugin().initialize(
    initializationSettings,
    onSelectNotification: (payload) async {
      print("Notification Selected Payload $payload");
      // _serialiseAndNavigate(message);
    },
  );

  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    Platform.isAndroid ? 'com.semproject.soulhealer' : 'com.semproject.soulhealer',
    'semProjectChannel',
    'semProjectDescriptionDescription',
    playSound: true,
    icon: "app_icon",
    channelShowBadge: true,
    enableVibration: true,
    importance: Importance.Max,
    priority: Priority.High,
    color: Colors.orangeAccent,
  );

  var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
    presentSound: true,
    presentAlert: true,
    presentBadge: true,
  );

  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

  try {
    await FlutterLocalNotificationsPlugin().show(
      0,
      messageNotification['title'].toString(),
      messageNotification['body'].toString(),
      platformChannelSpecifics,
      payload: jsonEncode(messageNotification),
    );
  } catch (e) {
    print(e);
  }
}
