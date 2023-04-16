
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> setDatabase() async {
  var collection = FirebaseFirestore.instance.collection('DriverList');
  var querySnapshot = await collection.get(); 
  
}