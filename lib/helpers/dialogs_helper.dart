import 'package:flutter/material.dart';
import 'package:time_tracker/models/categorie.dart';
import 'package:time_tracker/services/categorie_data_service.dart';

Future<Categorie> showChooseCategoriesDialog(BuildContext context, startTimer) async{
  void _exitDialog(context, categorie){
    if(categorie != null) startTimer(categorie);
    Navigator.of(context).pop();
  }
  
  return showDialog<Categorie>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('What are you goeing to focus on?'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 130.0,
            child: FutureBuilder<List<Categorie>>(
                future: CategorieDataService.getAll(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    List gridArray = arrayToGridArray(snapshot.data);

                    return Column(
                    children: <Widget>[
                      for(var row in gridArray)
                        Row(children: <Widget>[
                          for(var categorie in row)  
                            FlatButton(
                              child: Text(categorie.name),
                              color: Colors.amber,
                              onPressed: (){
                                // return categorie;
                                _exitDialog(context, categorie);
                              },
                              onLongPress: (){
                                debugPrint("This is my categorie ${categorie.toString()}");
                                _exitDialog(context, null);
                                confirmDeleteCategorie(context, categorie);
                              },
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                    ],
                  );
                }else{
                  return Text("Loading data...");
                }
                }
                ),
            ),
          ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Add new Categorie"),
                            color: Colors.blueAccent,
                            onPressed: (){
                              _exitDialog(context, null);
                              showAddCategoriesDialog(context, startTimer);
                            },
                          ),FlatButton(
                            child: Text("Cancel"),
                            color: Colors.redAccent,
                            onPressed: (){
                              _exitDialog(context, null);
                            },
                          ),
                        ]
        );
        }, 
      );
    }
Future<Categorie> showAddCategoriesDialog(BuildContext context, startTimer) async{
  final nameController = TextEditingController();
  
  void _exitDialog(context, categorie){
    // startTimer(categorie);
    Navigator.of(context).pop();
  }
  
  return showDialog<Categorie>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('What are you goeing to focus on?'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 130.0,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'What\'s the new categorie?'
              ),
            ),
          ),
        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Create"),
                            color: Colors.blueAccent,
                            onPressed: () async{
                              _exitDialog(context, null);
                              String categorieName = nameController.text;
                              Categorie categorie = Categorie(categorieName);
                              int categorie_id = await CategorieDataService.add(categorie);
                              categorie = await CategorieDataService.find(categorie_id);
                              startTimer(categorie);
                            },
                          ),
                          FlatButton(
                            child: Text("Cancel"),
                            color: Colors.redAccent,
                            onPressed: (){
                              _exitDialog(context, null);
                            },
                          ),
                        ]
        );
        }, 
      );
    }
Future<Categorie> confirmDeleteCategorie(BuildContext context, categorie) async{
  void _exitDialog(context, wantsToDelete){
    if(wantsToDelete){
      CategorieDataService.delete(categorie.id);
    }
    Navigator.of(context).pop();
  }
  
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to delete the categorie ${categorie.name}?'),
        content: Container(
          height: 10
        ),
              actions:<Widget>[
                          FlatButton(
                            child: Text("Delete"),
                            color: Colors.deepOrange,
                            onPressed: (){
                              _exitDialog(context, true);
                            },
                          ),
                          FlatButton(
                            child: Text("Cancel"),
                            color: Colors.redAccent,
                            onPressed: () async{
                              _exitDialog(context, false);
                            },
                          ),
                        ]
        );
        }, 
      );
    }
List<List<dynamic>> arrayToGridArray(List<dynamic> arr){
  int count = 0;
  List last_list_item;
  List<List<dynamic>> gridArray = new List();
  for(var item in arr){
    if(count == 0){
      last_list_item = new List();
      gridArray.add(last_list_item);
    }
    last_list_item.add(item);
    count++;
    if(count == 2){
      count = 0;
    }
  }
  return gridArray;
}