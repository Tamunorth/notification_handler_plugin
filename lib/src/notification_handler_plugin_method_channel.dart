import 'dart:math';

import 'package:flutter/services.dart';

import '../notification_handler_plugin.dart';
import 'notification_handler_plugin_platform_interface.dart';

/// An implementation of [NotificationHandlerPluginPlatform] that uses method channels.
class MethodChannelNotificationHandlerPlugin
    extends NotificationHandlerPluginPlatform {
  final _tapEventChannel = const EventChannel("notification_tap_event");

  final _initialMessageMethod =
      const MethodChannel("notificaiton_plugin_channel");

  @override
  Stream<NotificationData> get onTap =>
      _tapEventChannel.receiveBroadcastStream().map(
          (data) => NotificationData.fromJson(Map<String, dynamic>.from(data)));

  @override
  Future<NotificationData?> get initialMessage async {
    return _initialMessageMethod
        .invokeMethod<Map>("get_initial_message")
        .then<NotificationData?>((data) => NotificationData.fromInitialMessage(
            Map<String, dynamic>.from(data ?? {})))
        .onError((_, __) async => null);
  }

  @override
  Future<String?> get initialMessageText async {
    return _initialMessageMethod
        .invokeMethod<Map>("get_initial_message")
        .then<String?>((data) => data.toString())
        .onError((_, __) async => null);
  }
}
