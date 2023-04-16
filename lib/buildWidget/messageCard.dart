import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/apis.dart';
import 'package:flutter_application_1/helper/my_date_util.dart';
import 'package:flutter_application_1/model/messageModel.dart';
import 'package:flutter/widgets.dart';

class MessageCard extends StatefulWidget {
  MessageCard({super.key, required this.messages});
  late Messages messages;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.me.id == widget.messages.senderID
        ? _receiverMessage()
        : _sendMessage();
  }

  Widget _sendMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 10),
            child: Row(
              children: [
                Text(
                  MyDateUtil.getFormattedTime(
                      context: context, time: widget.messages.sent),
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                ),
                const SizedBox(width: 5),
                if (widget.messages.read.isNotEmpty)
                  const Icon(
                    Icons.done_all_outlined,
                    color: Colors.blueAccent,
                    size: 14,
                  )
              ],
            )),
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 245, 255),
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Text(
            widget.messages.message,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _receiverMessage() {
    if (widget.messages.read.isEmpty) {
      APIs.updateMessageReadStatus(widget.messages);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 150),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 245, 176),
              border: Border.all(color: Colors.lightGreen),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Text(
            widget.messages.message,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
          child: Text(
            MyDateUtil.getFormattedTime(
                context: context, time: widget.messages.sent),
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}
