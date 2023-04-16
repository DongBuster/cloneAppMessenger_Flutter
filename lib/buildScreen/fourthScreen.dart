import 'package:flutter/material.dart';
import 'package:flutter_application_1/buildWidget/widgetPublic.dart';

Widget buildFourthScreen(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            height: 60,
            // color: Colors.white30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU'),
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Tin',
                      style: Theme.of(context).textTheme.titleLarge,
                    ))
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const Positioned(
                          top: 8,
                          left: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 25,
                            ),
                          )),
                      const Positioned(
                        left: 15,
                        bottom: 10,
                        child: Text(
                          'Thêm vào tin',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17),
                        ),
                      )
                    ],
                  ),
                ),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
                buildNews(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    'Hoàng girl',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                    context),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
