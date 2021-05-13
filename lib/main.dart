import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Future<List<User>> _getUsers() async{
    var data =  await http.get("https://earnezy.in/android_shop/getWebPosts.php"); // here i fetch data and stored in Url variable

    var jsonData =jsonDecode(data.body);
    // to store data we use for loop for that we will create another list of type user
    List<User> users =[];
    // now apply for loop
    for(var u in jsonData){
      User user = User(
          u["id"],
          u["name"],
          u["profile_pic"],
          u["user_id"] ,
          u["title"],
          u["filepath"],
          u["type"],
          u["upvote"],
          u["date"],
          u ["thumbnail"]);
     // now store to our  lis users
      users.add(user);
    }
    print(users);
    return users ;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: Container(

            child:  FutureBuilder(
              future: _getUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.data ==null){
                  return Container(
                    child: Center(
                    child: Text("loading"),
                  )
                  );
                }
else
  {
       return ListView.builder(
         itemCount:snapshot.data.length,
         itemBuilder: (BuildContext context , int index){
           return ListTile(
                title: Text(snapshot.data[index].name),
             leading: Image.network("https://earnezy.in/android_shop/" + snapshot.data[index].filepath),
              // leading: Vi.network("https://earnezy.in/android_shop/" + snapshot.data[index].filepath)

           );
         }
       );
  }


    }







            )
        )
    );
  }
}
class User{


  final String  id;
  final String  name ;
  final String profile_pic;
  final String user_id;
  final String title;
  final String filepath;
  final String type;
  final String upvote;

  final String date;
  final String thumbnail;


  User(this.id,this.name,this.profile_pic,this.user_id,this.title,this.filepath,this.type,this.upvote,this.date,this.thumbnail);

}


