import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../notification_handler_plugin.dart';
import 'notification_handler_plugin_method_channel.dart';

abstract class NotificationHandlerPluginPlatform extends PlatformInterface {
  /// Constructs a NotificationHandlerPluginPlatform.
  NotificationHandlerPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NotificationHandlerPluginPlatform _instance =
      MethodChannelNotificationHandlerPlugin();

  /// The default instance of [NotificationHandlerPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNotificationHandlerPlugin].
  static NotificationHandlerPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NotificationHandlerPluginPlatform] when
  /// they register themselves.
  static set instance(NotificationHandlerPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<NotificationData> get onTap =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<NotificationData?> get initialMessage =>
      throw UnimplementedError('platformVersion() has not been implemented.');

      Future<String?> get initialMessageText =>
      throw UnimplementedError('platformVersion() has not been implemented.');
}
