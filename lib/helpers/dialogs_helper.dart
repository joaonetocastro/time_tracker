import 'package:flutter/material.dart';
import 'package:time_tracker/models/category.dart';
import 'package:time_tracker/services/category_data_service.dart';

Future<Category> showChooseCategoriesDialog(BuildContext context, startTimer) async{
  void _exitDialog(context, category){
    if(category != null) startTimer(category);
    Navigator.of(context).pop();
  }
  
  return showDialog<Category>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('What are you goeing to focus on?'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 130.0,
            child: FutureBuilder<List<Category>>(
                future: CategoryDataService.getAll(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    List gridArray = arrayToGridArray(snapshot.data);

                    return Column(
                    children: <Widget>[
                      for(var row in gridArray)
                        Row(children: <Widget>[
                          for(var category in row)  
                            FlatButton(
                              child: Text(category.name),
                              color: Colors.amber,
                              onPressed: (){
                                // return category;
                                _exitDialog(context, category);
                              },
                              onLongPress: (){
                                debugPrint("This is my category ${category.toString()}");
                                _exitDialog(context, null);
                                confirmDeleteCategory(context, category);
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
                            child: Text("Add new Category"),
                            color: Colors.blueAccent,
                            onPressed: (){
                              _exitDialog(context, null);
                              showAddCategorysDialog(context, startTimer);
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
Future<Category> showAddCategorysDialog(BuildContext context, startTimer) async{
  final nameController = TextEditingController();
  
  void _exitDialog(context, category){
    // startTimer(category);
    Navigator.of(context).pop();
  }
  
  return showDialog<Category>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('What are you going to focus on?'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 130.0,
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'What\'s the new category?'
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
                              String categoryName = nameController.text;
                              Category category = Category(categoryName);
                              int category_id = await CategoryDataService.add(category);
                              category = await CategoryDataService.find(category_id);
                              startTimer(category);
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
Future<Category> confirmDeleteCategory(BuildContext context, category) async{
  void _exitDialog(context, wantsToDelete){
    if(wantsToDelete){
      CategoryDataService.delete(category.id);
    }
    Navigator.of(context).pop();
  }
  
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Are you sure you want to delete the category ${category.name}?'),
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