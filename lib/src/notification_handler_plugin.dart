import '../notification_handler_plugin.dart';
import 'notification_handler_plugin_platform_interface.dart';

class NotificationHandlerPlugin {
  Stream<NotificationData> get onTap =>
      NotificationHandlerPluginPlatform.instance.onTap;

  Future<NotificationData?> get initialMessage =>
      NotificationHandlerPluginPlatform.instance.initialMessage;

      Future<String?> get initialMessageText =>
      NotificationHandlerPluginPlatform.instance.initialMessageText;
}
