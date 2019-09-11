import 'dart:math';
import 'package:http/http.dart' as http;

class OtpUtil {
  var response;
  String finalUrl = '';
  String otpContent =
      ' is your verification code to get access to the Sathyabama App ';
  String url =
      'http://cloudportal.sathyabama.ac.in/mobileappsms/test.php?sender=';
  concatUrl(_phnNumber, _randomOtp) {
    return url +
        "$_phnNumber" +
        "&" +
        "content=" +
        "$_randomOtp" +
        otpContent.toString();
  }

  getRandomOtp() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    print(rndnumber);
    return rndnumber;
  }

  getOtp(String url) async {
    final response = await http.post(url);
    return response.statusCode;
  }

  checkGetOtp(finalUrl) {
    try {
      response = getOtp(finalUrl);
      return response;
    } catch (e) {
      print(e.code);
    }
  }
}
