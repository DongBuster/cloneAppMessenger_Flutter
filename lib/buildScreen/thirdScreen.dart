import 'package:flutter/material.dart';
import 'package:flutter_application_1/buildWidget/widgetPublic.dart';

Widget buildThirdScreen(BuildContext context){
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
              children: <Widget>[
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU'),
                ),
                 Text(
                  'Danh bạ',
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
                        padding:  const EdgeInsets.all(0),
                        margin:  const EdgeInsets.all(0),
                        width: 30,
                        height: 30,
                        child: const  Center(
                          child: IconButton(
                            onPressed:null,
                            icon: Icon(Icons.list_alt_sharp),
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
            Row(
              children: [
                Container(
                  
                  margin: const EdgeInsets.only(left: 20,top: 20),
                  child: const Text('Đang hoạt động (10)'),
                ),
                
              ],
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                  buildListPhoneCall('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU', 'dongbuster', Icons.circle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }
