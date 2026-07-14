import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lesson_flutter/model/post_model.dart';

class ApiRequest extends StatefulWidget {
  const ApiRequest({super.key});

  @override
  State<ApiRequest> createState() => _ApiRequestState();
}

class _ApiRequestState extends State<ApiRequest> {
  get urlFull => "https://jsonplaceholder.typicode.com";

  List<Post> parseUser(String jsonString){
    List<Post> userList =[];
    try {
      List users = json.decode(jsonString);
      userList = users.map((user)=> Post.fromJson(user)).toList();
    } catch (e){
      print("Error parsing JSON: $e");
    }
    return userList;
  }
  Future<List<Post>> fetchPosts(http.Client client) async {
    var url = Uri.parse('$urlFull/posts?userId=5');
    http.Response response = await http.get(
      url,
      headers: {
        'User-Agent': 'Mozilla/5.0',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return parseUser(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(title: Text("API Request Homework"), ),
    body: _buildBody(),
    );
  }
  
_buildBody() {
    return FutureBuilder<List<Post>>(
      future: fetchPosts(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return _buildListView(snapshot.data!);
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

 _buildListView(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.green[400],
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ListTile(
            title: Text(
              'Title: ${posts[index].title}',
              style: TextStyle(fontSize: 22.0),
            ),
            subtitle: Text(posts[index].body),
          ),
        );
      },
    );
  }

}
