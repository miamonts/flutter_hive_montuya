import 'samplemodels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PostsRepository {
  Future<List<Post>> getPosts() async {
    var url = 'http://flutter-database.herokuapp.com/users';
    final response = await http.get(url);
    return postFromJson(response.body);
  }
}

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: FutureBuilder<List<Post>>(
        future: PostsRepository().getPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            AlertDialog(
              title: Text("Error"),
              content: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(snapshot.data[index].username),
                      trailing: Text(snapshot.data[index].score.toString()),
                      // subtitle: Text(
                      //   snapshot.data[index].username,
                      //   softWrap: false,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                    ));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
