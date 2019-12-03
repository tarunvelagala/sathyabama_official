import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:sathyabama_official/screens/admission_enquiry.dart';
import 'package:sathyabama_official/screens/bus_routes.dart';
import 'package:sathyabama_official/screens/complain_us.dart';
import 'package:sathyabama_official/screens/learn_online.dart';
import 'package:sathyabama_official/screens/circulars.dart';
import 'package:sathyabama_official/screens/staff_circulars_login.dart';
import 'package:sathyabama_official/services/shared_prefs_service.dart';

SharedPrefs sharedPrefs = SharedPrefs();

Map<String, List> socialIcon = {
  'Facebook': [
    "https://www.facebook.com/SathyabamaOfficial/",
    LineAwesomeIcons.facebook
  ],
  'Twitter': ["https://twitter.com/SathyabamaSIST", LineAwesomeIcons.twitter],
  'Instagram': [
    "https://www.instagram.com/sathyabama.official/",
    LineAwesomeIcons.instagram
  ],
  'YouTube': [
    "https://www.youtube.com/channel/UCkBMqT83pxjwPhh8mUpZ0hQ/featured",
    LineAwesomeIcons.youtube
  ],
  'Reach Us': [
    "https://www.google.com/maps/place/Sathyabama+Institute+Of+Science+And+Technology+admission+office/@12.8732477,80.2198827,17z/data=!4m8!1m2!2m1!1sSathyabama+Institute+Of+Science+And+Technology!3m4!1s0x3a525ba20ad20ce7:0x106c443419e3ebb8!8m2!3d12.8729996!4d80.2218877",
    LineAwesomeIcons.map_marker
  ],
  "Contact Us":[
    "http://www.sathyabama.ac.in/sitepagethree.php?mainref=23",
    LineAwesomeIcons.phone

  ]
};
Map<String, List> browserData = {
  "Academic Calendar": [
    "http://www.sathyabama.ac.in/sitepagetwo.php?mainref=0&firstref=197&secondref=0",
    LineAwesomeIcons.calendar,
    'Academic\nCalendar',
    false
  ],
  "Bus Information": [
    BusRoute(),
    LineAwesomeIcons.bus,
    "Bus\nInformation",
    true
  ],
  "Complain Us": [
    ComplainUs(),
    LineAwesomeIcons.exclamation_circle,
    "Complain\nUs",
    true
  ],
  "Entrance Exam Portal": [
    "https://www.sathyabama.ac.in/online_entrance_home.php",
    LineAwesomeIcons.pencil_square,
    "Entrance\nExam Portal",
    false
  ],
  "Exam Result": [
    "http://www.sathyabama.ac.in/sitepagetwo.php?mainref=0&firstref=28&secondref=0",
    LineAwesomeIcons.graduation_cap,
    "Exam\nResult",
    false
  ],
  "Exam Timetable": [
    "http://www.sathyabama.ac.in/sitepagetwo.php?mainref=0&firstref=24&secondref=0",
    LineAwesomeIcons.table,
    "Exam\nTimetabale",
    false,
  ],
  "Feedback": [
    "http://www.sathyabama.ac.in/feedback.php",
    LineAwesomeIcons.comment,
    "Feedback\n",
    false
  ],
  "Help Desk": [
    "http://www.sathyabama.ac.in/news_detail.php?newsref=1348&newspage=archive",
    LineAwesomeIcons.question_circle,
    "Help\nDesk",
    false,
  ],
  "Learn Online": [
    LearnOnline(),
    LineAwesomeIcons.play_circle,
    "Learn\nOnline",
    true
  ],
  "Academic Syllabus": [
    "http://cloudportal.sathyabama.ac.in/syllabus2019/syllabus.php",
    LineAwesomeIcons.book,
    "Academic\nSyllabus",
    false
  ],
  "Secured Student Portal": [
    "http://cloudportal.sathyabama.ac.in/mobileappsms/api/index.html",
    LineAwesomeIcons.unlock,
    "Student\nPortal",
    false
  ],
  "Students Development Cell": [
    "http://www.sathyabama.ac.in/sitepagetwo.php?mainref=34",
    LineAwesomeIcons.users,
    "Students Development\nCell",
    false
  ],
};
getIsstaff() async {
  print(await sharedPrefs.getIsStaff());
  return await sharedPrefs.getIsStaff();
}

Map circulars = {
  "Admission\nEnquiry": [
    LineAwesomeIcons.bullhorn,
    AdmissionEnquiry(),
    AdmissionEnquiry(),
    false,
  ],
  "Staff\nCircular": [
    LineAwesomeIcons.clipboard,
    StaffCirculars(),
    Circulars(
      isStaff: "0",
    ),
    true,
  ],
  "Student\nCircular": [
    LineAwesomeIcons.file_text,
    Circulars(
      isStaff: "1",
    ),
    Circulars(
      isStaff: "1",
    ),
    true,
  ],
};

List<String> states = [
  'Tamil Nadu',
  'Andhra Pradesh',
  'Telangana',
  'Andaman and Nicobar',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chandigarh',
  'Chattisgarh',
  'Dadra and Nagar Haveli',
  'Daman and Diu',
  'Delhi',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jammu and Kashmir',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Lakshadweep',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Puducherry',
  'Punjab',
  'Sikkim',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal'
];

List<String> courses = [
  'B.A',
  'B.A. LL .B.',
  'B.Arch',
  'B.B.A',
  'B.B.A. LL .B.',
  'B.Com',
  'B.Com. LL .B.',
  'B.D.S',
  'B.E',
  'B.Pharm',
  'B.Sc',
  'B.Sc Nursing',
  'B.Tech',
  'D.Pharm',
  'LL . B',
  'M.A',
  'M.B.A',
  'M.D.S',
  'M.Phil',
  'M.Sc',
  'Ph.D'
];
Map<String, List> youTubeData = {
  'School of Computing': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobezo4FJtXJ24CcD8ak7iavAb',
    LineAwesomeIcons.laptop,
  ],
  'School of Law': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobezRKCOIKclxZCj5ISZEyRll',
    LineAwesomeIcons.balance_scale
  ],
  'School of Building and Environment': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobexhaaUIDtA29IKfatb6EmZh',
    LineAwesomeIcons.building_o
  ],
  'School of BIO & CHEM': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobexHZaZOsiD5czSN5d0hnce0',
    LineAwesomeIcons.flask
  ],
  'School of Electrical and Electronics': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobewb93KwRdfdsy3J2KjjoK4k',
    LineAwesomeIcons.lightbulb_o
  ],
  'School of Science and Humanities': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobewqEKRky94qPuBYMcEz2V5s',
    LineAwesomeIcons.globe
  ],
  'School of Electical and Electronics Engineering': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobezeI1nQlP6qoqiUs9RcS6ap',
    LineAwesomeIcons.plug
  ],
  'School of Mechanical Engineering': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobex_C4YRJjfNMVmpooBRYKN1',
    LineAwesomeIcons.gears
  ],
  'School of Management': [
    'https://www.youtube.com/playlist?list=PLUGY8WCcobex6B_C_F62okNtBCMZMzzbK',
    LineAwesomeIcons.group
  ],
};
