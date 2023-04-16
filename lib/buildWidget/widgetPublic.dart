import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screenRouter/screenVideoNews.dart';

// can use package: cached_network_image when image is error
Widget buildAvartar(String link, String isOnline) {
  if (isOnline == 'false') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CachedNetworkImage(
        height: 40,
        width: 40,
        imageUrl: link,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) => const CircleAvatar(
          child: Icon(
            Icons.person,
            size: 20,
          ),
        ),
      ),
    );
    // Container(
    //     height: 40,
    //     width: 40,
    //     clipBehavior: Clip.antiAlias,
    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    //     child: CachedNetworkImage(
    //       imageUrl: link,
    //       errorWidget: (context, url, error) {
    //         return const CircleAvatar(
    //           child: Icon(Icons.person),
    //         );
    //       },
    //     ));
  } else {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            height: 40,
            width: 40,
            imageUrl: link,
            fit: BoxFit.fill,
            errorWidget: (context, url, error) => const CircleAvatar(
              child: Icon(
                Icons.person,
                size: 20,
              ),
            ),
          ),
        ),
        const Positioned(
          right: 3,
          bottom: 0,
          child: Icon(
            Icons.circle,
            size: 13,
            color: Colors.green,
          ),
        )
      ],
    );
  }
}

Widget buildListCall(String image, String title, String subtitle,
    String timeDate, IconData? icon1, IconData iconSub, IconData icon2) {
  return Card(
    color: Colors.transparent,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    elevation: 0.0,
    child: ListTile(
        // leading: buildCircleImage(image, icon1),
        title: Padding(
            padding: const EdgeInsets.only(bottom: 10), child: Text(title)),
        subtitle: Row(children: [
          Icon(
            iconSub,
            size: 15,
          ),
          Text(' $subtitle . $timeDate')
        ]),
        trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.black12,
            ),
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            width: 30,
            height: 30,
            child: Center(
              child: IconButton(
                onPressed: null,
                icon: Icon(icon2),
                iconSize: 18,
                padding: const EdgeInsets.all(0),
                color: Colors.black,
              ),
            ))),
  );
}

Widget buildListPhoneCall(String linkImage, String title, IconData icon) {
  return Card(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
    color: Colors.transparent,
    elevation: 0.0,
    child: ListTile(
      // leading: buildCircleImage(linkImage, icon),
      title: Text(title),
    ),
  );
}

Widget buildNews(String linkImage, String title, String linkImageUser,
    BuildContext context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(routeVideoNews()),
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(linkImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 4, color: Colors.blue)),
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(linkImage),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 10,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          )
        ],
      ),
    ),
  );
}
