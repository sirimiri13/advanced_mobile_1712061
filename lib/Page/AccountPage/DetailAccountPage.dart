import 'package:finalproject_1712061/Model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class DetailAccountPage extends StatefulWidget {
  static String tag = 'detail-account-page';
  Future<UserMe> user;
  DetailAccountPage(this.user);
  @override
  _DetailAccountPage createState() => new _DetailAccountPage();
}

class _DetailAccountPage extends State<DetailAccountPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'PROFILE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.indigo,
        ),
        body: Container(
          child: FutureBuilder<UserMe>(
            future: widget.user,
            builder: (context,snap){
              if (snap.hasData){
                return
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            print('Tapped Avatar');
                          },
                          child: Column(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(10.0),
                                        width: MediaQuery.of(context).size.width/2,
                                        height: MediaQuery.of(context).size.width/2,
                                        decoration:BoxDecoration(
                                            border: Border.all(color: Colors.indigo, width: 4),
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(snap.data.payload.avatar),
                                              // read: lấy dữ liệu 1 lần
                                              // watch: lấy và luôn lắng nghe sự thay đổi
                                              // selector: lên đọc tài liệu, watch trên 1 property thay vì cả class

                                            )
                                        )
                                    ),
                                    Column(
                                        children : [
                                          Container(
                                            padding: EdgeInsets.only(top: 10,bottom: 10),
                                            child: Text(
                                            snap.data.payload.name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Text(
                                          snap.data.payload.type,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 20, bottom: 20),
                                            height: 110,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(

                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'DOWNLOADED',
                                                        style: TextStyle(
                                                          color: Colors.indigo,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(snap.data.payload.favoriteCategories.length.toString())
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'COURSES',
                                                        style: TextStyle(
                                                          color: Colors.indigo,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(snap.data.payload.favoriteCategories.length.toString())
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ]
                                    ),
                                  ]
                              )
                          )

                    ],
                  );
              }
              else if (snap.hasError){
                print(snap.error);
              }
               return CircularProgressIndicator();
            },
          )
        )
    );
  }
}