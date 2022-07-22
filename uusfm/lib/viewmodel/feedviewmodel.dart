import 'package:uusfm/globalvariable.dart';

import '../model/feedmodel.dart';
import 'package:http/http.dart' as http;

Future<List<FeedModel>> viewfeed() async {
  var url = "http://" + GlobalVariables.IPAddress + "/MobileAPI/viewfeed.php";
  // var url = "http://localhost:8080/MobileAPI/login.php?cEmail=" +
  //     cEmail +
  //     "&&cPassword=" +
  //     cPassword;
  print(url);
  var result = await http.get(Uri.parse(url));
  print(result.body);
  if (result.body == "failed") return null;

  // final json = jsonDecode(result.body);
  // final _submission = json.map((e) => Feed.fromJson(e)).toList();
  return feedModelFromJson(result.body);
}
