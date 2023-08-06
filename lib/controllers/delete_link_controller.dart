import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/user.dart';

Future<bool> deleteLink(
    {required Map<String, dynamic> body, required int? userId}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.delete(Uri.parse("$linksUrl/$userId"),
      headers: {"Authorization": "Bearer ${user.token}"});
  if (response.statusCode == 200) {
    return true;
  } else {
    return Future.error("Can not delete");
  }
}
