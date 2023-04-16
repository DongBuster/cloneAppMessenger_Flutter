import 'package:flutter/material.dart';
import 'package:flutter_application_1/buildWidget/widgetPublic.dart';
import 'package:flutter_application_1/model/chatUser.dart';
import 'package:flutter_application_1/screenRouter/screenSendMessage.dart';

class chatUserCard extends StatefulWidget {
  final ChatUser user;
  const chatUserCard({super.key, required this.user});

  @override
  State<chatUserCard> createState() => _chatUserCardState();
}

class _chatUserCardState extends State<chatUserCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ChatScreen(
                user: widget.user,
              ))),
      child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.fromLTRB(20, 10, 0, 0),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  buildAvartar(widget.user.image, widget.user.isOnline),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      const Text(
                        'ok',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.black45),
                      ),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.circle,
                  size: 15,
                  color: Colors.blue,
                ),
              )
            ],
          )
          // ListTile(
          //   leading:
          //       // CachedNetworkImage(
          //       //   imageUrl: widget.user.image,
          //       //   fit: BoxFit.fill,
          //       //   errorWidget: (context, url, error) => const CircleAvatar(
          //       //     child: Icon(Icons.person),
          //       //   ),
          //       // ),

          //       buildCircleImage(widget.user.image, null),
          //   title: Padding(
          //     padding: const EdgeInsets.only(bottom: 10),
          //     child: Text(
          //       widget.user.name,
          //     ),
          //   ),
          //   // subtitle: Text('$message    $timeDate'),
          //   trailing: const Icon(
          //     Icons.circle,
          //     size: 15,
          //     color: Colors.blue,
          //   ),
          // ),
          ),
    );
  }
}
