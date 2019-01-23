import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namma_chennai/model/user.dart';
import 'package:namma_chennai/utils/shared_prefs.dart';

SharedPrefs _sharedPrefs = new SharedPrefs();
Firestore db = Firestore.instance;
CollectionReference collectionRef = db.collection('users');

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  User currentUser;
  String userId;
  bool isLoaded = false;

  showNGOForm() {
    print("Go to NGO");
    // Navigator.pushNamed(context, "/ngo");
  }

  getMyInfo() {
    collectionRef
        .where("user_id", isEqualTo: userId)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      List<DocumentSnapshot> docs = snapshot.documents;
      for (DocumentSnapshot doc in docs) {
        User user = new User.fromSnapShot(doc);
        currentUser = user;
      }
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _sharedPrefs.getApplicationSavedInformation("loggedinuser").then((val) {
      setState(() {
        userId = val;
        getMyInfo();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0,
          centerTitle: false,
          title: Text('My Profile'),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * .22,
                  color: Colors.redAccent,
                ),
              ],
            ),
            isLoaded
                ? Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .02,
                        right: 10.0,
                        left: 10.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: ListTile(
                                  title: Text(
                                    currentUser.userName,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  trailing: Icon(
                                    Icons.verified_user,
                                    color: Colors.green,
                                  ),
                                  subtitle: Text(currentUser.userPhoneNumber + "\nMember since: " + currentUser.userCreatedOn.toLocal().toString().substring(0, currentUser.userCreatedOn.toLocal().toString().length - 7)),
                                ),
                              ),
                              elevation: 4.0,
                            ),
                            SingleChildScrollView(
                                // child: listNGO,
                                ),
                            Expanded(child: Container()),
                            FlatButton(
                              color: Colors.red,
                              onPressed: () {
                                _sharedPrefs.removeApplicationSavedInformation(
                                    "loggedinuser");
                                Navigator.pushNamedAndRemoveUntil(context, '/start', (_) => false);
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18.0, horizontal: 98.0),
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        )),
                  )
                : Container(),
          ],
        ));
  }
}
