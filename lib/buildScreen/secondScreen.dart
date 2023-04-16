import 'package:flutter/material.dart';
import 'package:flutter_application_1/buildWidget/widgetPublic.dart';


Widget buildSecondScreen(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 0.0),
              height: 60,
              // color: Colors.white30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  <Widget>[
                  const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                      ),
                  ),
                   Text(
                    'Cuộc gọi',
                    style: Theme.of(context).textTheme.titleLarge,

                  ),
                  Wrap(
                    spacing: 15.0,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black12,
                          ),
                          padding: const EdgeInsets.all(0),
                          margin: const EdgeInsets.all(0),
                          width: 30,
                          height: 30,
                          child:const Center(
                            child: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.call),
                              iconSize: 18,
                              padding: EdgeInsets.all(0),
                              color: Colors.black,
                            ),
                        )
                      ),
                      Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black12,
                        ),
                        width: 30,
                        height: 30,           
                        child: const Center(
                          child: IconButton(
                          onPressed: null,
                          icon: Icon(Icons.video_call_sharp),
                          iconSize: 18,
                          padding: EdgeInsets.all(0),
                          color: Colors.black,
                        ),
                      )
                    ),
                  ],
                )
              ],
            ),
          ),
            Expanded(
              child: ListView(
              shrinkWrap: true,
              children: [
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi đi', '9/10', null, Icons.video_call_sharp, Icons.video_call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi đi', '9/10', null, Icons.video_call_sharp, Icons.video_call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi đi', '9/10', null, Icons.video_call_sharp, Icons.video_call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
                buildListCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'Hoang', 'Cuộc gọi nhỡ', '9/10', null, Icons.call, Icons.call),
              ],
            ),
            ),
          ],
        ),
      ),
       
    );
  }
