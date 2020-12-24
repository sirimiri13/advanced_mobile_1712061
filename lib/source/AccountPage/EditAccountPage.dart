import 'package:finalproject_1712061/API/APIServer.dart';
import 'package:finalproject_1712061/source/AccountPage/AccountPage.dart';
import 'package:finalproject_1712061/source/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/User.dart';
import 'package:http/http.dart' as http;


TextEditingController editNameController = new TextEditingController();
TextEditingController editPwController = new TextEditingController();
TextEditingController editPhoneController = new TextEditingController();

class EditAccountPage extends StatefulWidget{
  static String tag = 'edit-account-page';
  Future<UserMe> user;
  EditAccountPage(this.user);
  @override
  _EditAccountPage createState() => new _EditAccountPage();
}

class _EditAccountPage extends State<EditAccountPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EDIT'),
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: FutureBuilder<UserMe>(
              future: widget.user,
              builder: (context, snap) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextField(
                        controller: editNameController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: snap.data.payload.name == null
                              ? "Name"
                              : snap.data.payload.name,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: editPhoneController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: snap.data.payload.phone,
                          ),
                        )
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        width: 150,
                        height: 60,
                        child: RaisedButton(
                          onPressed: () async {
                            print('tapped');
                            if (editPhoneController.text.isEmpty &&
                                editNameController.text.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Update Information'),
                                      content: Text('Please type information'),
                                      actions: [
                                        new FlatButton(
                                            child: const Text('OK',
                                                style: TextStyle(
                                                    color: Colors.indigo)),
                                            onPressed: () {
                                              Navigator.of(context).popAndPushNamed(AccountPage.tag);
                                            }),
                                      ],
                                    );
                                  });
                            }
                            else {
                              var name = editNameController.text.isNotEmpty
                                  ? editNameController.text
                                  : "";
                              var phone = editPhoneController.text.isNotEmpty
                                  ? editPhoneController.text
                                  : user.payload.phone;
                              var avatar = user.payload.avatar;
                              print(name);
                              print(phone);
                              print(avatar);
                              http.Response response = await APIServer()
                                  .updateUserInfo(name, avatar, phone);
                              print(response.body);
                              if (response.statusCode == 200) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Update Information'),
                                        content: Text('Update successful'),
                                        actions: [
                                          new FlatButton(
                                              child: const Text('OK',
                                                  style: TextStyle(
                                                      color: Colors.indigo)),
                                                onPressed: () {
                                                print('tapp');
                                                  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                                                      builder: (context) => BottomNavigation(), maintainState: false));
                                              }),
                                        ],
                                      );
                                    }
                                );
                              }
                              else if (response.statusCode == 400) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Update Information'),
                                        content: Text(response.body),
                                        actions: [
                                          new FlatButton(
                                              child: const Text('OK',
                                                  style: TextStyle(
                                                      color: Colors.indigo)),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      );
                                    }
                                );
                              }
                            }
                          },
                          child: Text(
                            'SAVE', style: TextStyle(color: Colors.white),),
                          color: Colors.indigo,
                        )
                    ),
                    Container(
                        width: 200,
                        padding: EdgeInsets.all(20),
                        child: OutlineButton(
                          borderSide: BorderSide.none,
                          child: Text('Change password',style: TextStyle(color: Colors.indigo,decoration:TextDecoration.underline)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new AlertDialog(
                                      titleTextStyle : TextStyle(color: Colors.indigo),
                                     // contentPadding: const EdgeInsets.all(16.0),
                                      content:Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextField(
                                                controller: editPwController,
                                                autofocus: true,
                                                decoration: new InputDecoration(
                                                    labelText: 'Old Password',
                                                    hintText: 'Type old password...',
                                                    labelStyle: TextStyle(color: Colors.indigo)
                                                ),
                                              ),
                                        TextField(
                                                controller: editPwController,
                                                autofocus: true,
                                                decoration: new InputDecoration(
                                                    labelText: 'New Password',
                                                    hintText: 'Type new password...',
                                                    labelStyle: TextStyle(color: Colors.indigo)
                                                ),
                                              )
                                        ],
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                            child: const Text('CANCEL',style: TextStyle(color: Colors.indigo)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        new FlatButton(
                                            child: const Text('DONE',style: TextStyle(color: Colors.indigo)),
                                            onPressed: () async {
                                              var email = editPwController.text;
                                            }),
                                      ]
                                  );
                                }
                            );
                          },
                        )
                    )
                  ],
                );
              }
          ),
        )
    );
  }

}