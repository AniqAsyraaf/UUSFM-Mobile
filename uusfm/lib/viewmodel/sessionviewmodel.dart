import 'package:uusfm/globalvariable.dart';
import 'package:uusfm/model/sessionmodel.dart';

import 'package:http/http.dart' as http;

Future<List<SessionModel>> viewGymnasium(String sessionDay) async {
  var url = "http://" +
      GlobalVariables.IPAddress +
      "/MobileAPI/viewGymnasium.php?sessionDay='" +
      sessionDay +
      "'";

  var result = await http.get(Uri.parse(url));

  if (result.body == "failed") return null;

  return sessionModelFromJson(result.body);
}

Future<List<SessionModel>> viewStadium(String sessionDay) async {
  var url = "http://" +
      GlobalVariables.IPAddress +
      "/MobileAPI/viewStadium.php?sessionDay='" +
      sessionDay +
      "'";

  var result = await http.get(Uri.parse(url));

  if (result.body == "failed") return null;

  return sessionModelFromJson(result.body);
}

Future<List<SessionModel>> viewFootball(String sessionDay) async {
  var url = "http://" +
      GlobalVariables.IPAddress +
      "/MobileAPI/viewFootball.php?sessionDay='" +
      sessionDay +
      "'";

  var result = await http.get(Uri.parse(url));

  if (result.body == "failed") return null;

  return sessionModelFromJson(result.body);
}
