import 'dart:convert';
import 'package:http/http.dart' as http;


  getrequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        return jsonResponse['tadabor'];
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

getrequestRe(String url,text) async {
  try {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      return jsonResponse[text];
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}
