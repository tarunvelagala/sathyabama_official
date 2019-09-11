import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String requiredNumber;
  String isstaff;
  saveValues(_phnNumber) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('phone_number', _phnNumber);
  }

  getValues() async {
    final prefs = await SharedPreferences.getInstance();
    requiredNumber = prefs.getString("phone_number");
    return requiredNumber;
  }

  saveLengthofApi(_length) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('api_length', _length);
  }

  updateSharedPrefsStaff() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("is_staff", "0");
  }

  getIsStaff() async {
    final prefs = await SharedPreferences.getInstance();
    isstaff = prefs.getString("is_staff");
    return isstaff;
  }
}
