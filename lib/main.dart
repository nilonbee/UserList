import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/Users.dart';
import 'screens/details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users_list',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> getUsers() async {
    var url = Uri.parse('https://reqres.in/api/users?page=1');
    late http.Response response;
    List<User> users = [];

    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        Map usersData = jsonDecode(response.body);
        List<dynamic> peoples = usersData["data"];

        for (var item in peoples) {
          var id = item['id'];
          var name = item['first_name'] + " " + item['last_name'];
          var email = item['email'];
          var avatar = item['avatar'];

          User user = User(id, name, email, avatar);
          users.add(user);
        }
      } else {
        return Future.error("Something wrong, ${response.statusCode}");
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home_max),
        backgroundColor: Colors.blue,
        title: const Text(
          'Users List',
          style: TextStyle(
              fontFamily: 'Courier', fontSize: 32.0, color: Colors.black87),
        ),
      ),
      body: FutureBuilder(
        future: getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Waiting...'),
            );
          } else {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        trailing: const Icon(Icons.navigate_next),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data[index].avatar),
                        ),
                        title: Text(snapshot.data[index].name),
                        subtitle: Text(snapshot.data[index].email),
                        hoverColor: Colors.indigo[400],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetail(snapshot.data[index]),
                            ),
                          );
                        });
                  });
            }
          }
        },
      ),
    );
  }
}
