import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;

  void connect() {
    socket = io.io(
      'http://your-server-url',
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();
    socket.onConnect((_) {
      // print("✅ Connected to socket");
    });

    socket.onDisconnect((_) {
      // print("❌ Disconnected");
    });
  }

  void listen(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void disconnect() {
    socket.dispose();
  }
}
