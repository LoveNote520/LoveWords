import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'socket_state.dart';

class SocketLogic extends GetxController {
  final SocketState state = SocketState();
  final channel = IOWebSocketChannel.connect('ws://localhost:1234');


  SocketLogic(){
    channel.stream.listen((message) {
      channel.sink.add('received!');
      channel.sink.close(status.goingAway);
    });
  }

}
