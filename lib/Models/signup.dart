import 'package:http/http.dart' as http;

signup(username, password, score) async {
  var url = 'https://flutter-database.herokuapp.com/users';
  var response = await http.post(url,
      body: {"username": username, "password": password, "score": score});
  print(response.body);
}
