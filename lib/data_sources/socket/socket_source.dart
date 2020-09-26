import 'dart:async';
import 'dart:convert';

import 'package:flutter_socket_io/flutter_socket_io.dart';

import 'package:injectable/injectable.dart';
import 'package:soulhealer/core/logger/log.dart';

import 'models/models.dart';

abstract class ISocketService {
  Future<void> init();

  Future<void> connect();
  Future<void> disconnect();

  Stream<SocketResponseModel> subscribeToNewMessage(Function callback);

  Future<void> unSubscribeToNewMessage(Function callback);
  Future<void> unSubscribesAll();

  Future<void> sendMessage(SocketRequestModel message, [Function callback]);
}

@Injectable(as: ISocketService)
class SocketService implements ISocketService {
  final SocketIO socketIO;
  static const String NEW_MESSAGE_EVENT = "NEW_MESSAGE";

  final Log log = Log("SocketService");

  SocketService(this.socketIO);

  @override
  Future<void> init() {
    return socketIO.init();
  }

  @override
  Future<void> connect() {
    return socketIO.connect();
  }

  @override
  Future<void> disconnect() {
    return socketIO.disconnect();
  }

  @override
  Future<void> sendMessage(SocketRequestModel message, [Function callback]) {
    return socketIO.sendMessage(
      NEW_MESSAGE_EVENT,
      jsonEncode(message.toJson()),
      callback,
    );
  }

  @override
  Stream<SocketResponseModel> subscribeToNewMessage(Function callBack) {
    init();
    StreamController messageController =
        StreamController<SocketResponseModel>();
    socketIO.subscribe(NEW_MESSAGE_EVENT, (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = jsonDecode(jsonData);

      messageController.add(SocketResponseModel.fromJson(data));
    });

    connect();
    return messageController.stream;
  }

  @override
  Future<void> unSubscribeToNewMessage(Function message) {
    return socketIO.unSubscribe(NEW_MESSAGE_EVENT, message);
  }

  @override
  Future<void> unSubscribesAll() {
    return socketIO.unSubscribesAll();
  }
}
