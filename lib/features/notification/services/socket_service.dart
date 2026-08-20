import 'package:socket_io_client/socket_io_client.dart' as iio;
import 'package:untitled1/features/notification/modules/notification_model.dart';

class SocketService {
  late iio.Socket socket;

  Function(NotificationModel)? onNotification;

  bool _isConnected = false;

  void connect(String userId) {
    if (_isConnected) return;

    socket = iio.io(
      "https://crm-8vyz.onrender.com",
      iio.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      // print("Connected");

      _isConnected = true;

      socket.emit("identify", userId);

      // print("identify emitted");
    });

    socket.onDisconnect((_) {
      // print("Disconnected");

      _isConnected = false;
    });

    socket.onConnectError((e) {
      // print(e);
    });

    socket.on("notification", (data) {
      // print('$data khedr');

      final notification = NotificationModel.fromJson(data);

      onNotification?.call(notification);
    });
  }

  void disconnect() {
    socket.disconnect();

    socket.dispose();

    _isConnected = false;
  }
}
