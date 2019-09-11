import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sathyabama_official/services/crud.dart';

class OtpCrud {
  CrudMethods crudObj = CrudMethods();

  addPhoneNumberToDB(_phnNumber, _randomOtp) {
    Map<String, String> phnData = {
      'phone_number': _phnNumber,
      'otp': _randomOtp,
    };
    crudObj.addPhoneNumber(phnData);
  }

  updateOtpInDb(docs, _randomOtp) {
    crudObj
        .updatePhoneNumber(docs.documents[0].documentID, {'otp': _randomOtp});
  }

  verifyPhoneNumberInDB(_phnNumber, _randomOtp) {
    try {
      crudObj.getPhoneNumber(_phnNumber).then((QuerySnapshot docs) {
        if (docs.documents.isEmpty || docs.documents == null) {
          addPhoneNumberToDB(_phnNumber, _randomOtp);
        } else {
          updateOtpInDb(docs, _randomOtp);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
