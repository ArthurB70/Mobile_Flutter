import 'package:flutter/material.dart';
import 'package:iFreeze/repositories/iFreeze.MQTT.repository.dart';

enum MQTTAppConnectionState { connected, disconnected, connecting }
class MQTTController with ChangeNotifier{
  MQTTAppConnectionState _appConnectionState = MQTTAppConnectionState.disconnected;
  String _receivedText = '';
  String _historyText = '';
  MQTTRepository manager;

  void setReceivedText(String text) {
    _receivedText = text;
    _historyText = _historyText + '\n' + _receivedText;
    notifyListeners();
  }
  void setAppConnectionState(MQTTAppConnectionState state) {
    _appConnectionState = state;
    notifyListeners();
  }
  void disconnect(){
    this._receivedText = '';
    this._historyText = '';
    this.setAppConnectionState(MQTTAppConnectionState.disconnected);
    manager.disconnect();
    
  }

  String get getReceivedText => _receivedText;
  String get getHistoryText => _historyText;
  MQTTAppConnectionState get getAppConnectionState => _appConnectionState;

}