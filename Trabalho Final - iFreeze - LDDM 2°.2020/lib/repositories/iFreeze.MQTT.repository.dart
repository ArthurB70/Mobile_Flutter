import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:iFreeze/controllers/iFreeze.MQTT.controller.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTRepository{
  final MQTTController _currentState;
  MqttServerClient _client;
  final String _identifier;
  final String _host;
  final String _topic;
  
  StreamSubscription subscription;
  // Constructor
  MQTTRepository({
   @required String host,
    @required String topic,
    @required String identifier,
    @required MQTTController state
}
): _identifier = identifier, _host = host, _topic = topic, _currentState = state ;

  void initializeMQTTClient(){
    _client = MqttServerClient(_host,_identifier);
    _client.port = 1883;
    _client.keepAlivePeriod = 10;
    _client.onDisconnected = onDisconnected;
    _client.logging(on: true);
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;


    _client.connect('<USUÁRIO>', '<SENHA>');
    _client.subscribe(_topic, MqttQos.atLeastOnce);
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
      final MqttPublishMessage recMess = c[0].payload;
      final String pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
  }

  // Connect to the host
  void connect() async{
    assert(_client != null);
    try {
      print('EXAMPLE::MQTT start client connecting....');
      _currentState.setAppConnectionState(MQTTAppConnectionState.connecting);
      await _client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client.disconnect();
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (_client.connectionStatus.returnCode == MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    _currentState.setAppConnectionState(MQTTAppConnectionState.disconnected);
  }

  /// The successful connect callback
  void onConnected() {
    _currentState.setAppConnectionState(MQTTAppConnectionState.connected);
    print('EXAMPLE::MQTT client connected....');
    _client.subscribe(_topic, MqttQos.atLeastOnce);
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      _currentState.setReceivedText(pt);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }
}
