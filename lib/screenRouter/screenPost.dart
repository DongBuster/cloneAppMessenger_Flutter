
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/DBHelper.dart';

class LocalDB extends StatefulWidget {
  const LocalDB({super.key});

  @override
  State<LocalDB> createState() => _LocalDBState();
}

class _LocalDBState extends State<LocalDB> {
  final TextEditingController _titlecontroller =  TextEditingController();
  final TextEditingController _desccontroller =  TextEditingController();

  List<Map<String,dynamic>> _allData = [];
  bool _isloading = false;

  
  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data; 
      _isloading = false;
    });
  }


  
  Future<void> _addData() async{
    await SQLHelper.createData(_titlecontroller.text, _desccontroller.text);
    _refreshData();
  }
    
  Future<void>  _updateData(int id) async{
    await SQLHelper.updateData(id,_titlecontroller.text, _desccontroller.text);
    _refreshData();
  }

  Future<void>  _deleteData(int id, BuildContext context) async{
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Data deleted'),
      )
    );
    _refreshData();
  }
    
  void showBottomSheet(int? id) async{
    if(id!=null){
      final existingData = 
      _allData.firstWhere((element) => element['id']==id);
      _titlecontroller.text = existingData['title'];
      _desccontroller.text = existingData['desc'];
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom +50
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titlecontroller,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "title"
              ),
            ),
            const SizedBox(height: 10,),
            TextField(
              controller: _desccontroller,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "description"
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: ElevatedButton(
                onPressed: ()async{
                  if(id == null) {
                    await _addData();
                  } else {
                    await _updateData(id);
                  }
                  _titlecontroller.text="";
                  _desccontroller.text = "";
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id==null ? 'Add data' : 'Update data',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
  
  @override
  void initState(){
     _refreshData();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          title:const Text(
            'CRUD operations',
            style: TextStyle(
              fontSize: 18
            ),
            
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.keyboard_return)
          ),
        ) ,     
        body: SafeArea(
          child: _isloading 
              ? Center(child: CircularProgressIndicator())
              :ListView.builder(
                itemCount: _allData.length,
                itemBuilder: (context, index) => 
                Card(
                  margin: EdgeInsets.all(15),
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        _allData[index]['title'],
                        style: TextStyle(fontSize: 18),
                        ),
                      ),
                    subtitle: Text(_allData[index]['desc']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showBottomSheet(_allData[index]['id']);
                          }, 
                          icon:const Icon(
                            Icons.edit,
                            color: Colors.indigo,
                            
                            )
                        ),
                        IconButton(
                          onPressed: () {
                            _deleteData(_allData[index]['id'],context);
                          }, 
                          icon:const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                            
                            )
                        )
                      ],
                    ),
                  ),

                )
              )
            ),
            floatingActionButton: FloatingActionButton(
              onPressed:()=> showBottomSheet(null),
              child: Icon(Icons.add,color: Colors.white,),
        ),
      )
    );
    
  }

}
