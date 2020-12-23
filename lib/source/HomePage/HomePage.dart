import 'package:finalproject_1712061/API/APIServer.dart';
import 'package:finalproject_1712061/source/Model/ListCourses.dart';
import 'package:finalproject_1712061/source/Model/User.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../Model/Course.dart';
import '../CoursePage/DetailCoursePage.dart';
import '../CoursePage/ListCoursePage.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget{
  static String tag = 'home-page';
  @override
  _HomePage createState() => new _HomePage();

}

//
// Widget continueHorizionList = new Container (
//     child: CarouselSlider(
//       options: CarouselOptions(),
//       items: listCourse.map((itemCourse) => Container(
//         height: 180,
//         margin: EdgeInsets.all(5.0),
//         child: Column(
//             children: <Widget>[
//               Image.asset(itemCourse.imageUrl,fit: BoxFit.cover, width:300.0,height: 160.0),
//               Text(itemCourse.title,style: TextStyle(fontSize: 18.0))
//             ]
//         ),
//       )).toList(),
//     )
// );


class _HomePage extends State<HomePage> {
 //http.Response responseRecommendCourse = APIServer().getRecommendCourse();

  // var listCourseRegister = getListCourseOfUser();
  @override
  Widget build(BuildContext context) {

    //print(listCourseRegister);
    // createData();
    // print("user " + myUser.registeredCourse.length.toString());
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    return Consumer<ListCourses>(
        builder: (context,listCourses,child) =>Scaffold(
          body: Container(
              padding: EdgeInsets.only(left: 10.0, top: 10.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                // itemCount: listCourseRegister.length + 4,
                itemCount: listCourses.myCourses.length + 4,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    List<Course> listRate = listCourses.getListCourseRate();
                    return Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            autoPlay: true,
                          ),
                          items: listRate.map((item) =>
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (_) =>
                                            ChangeNotifierProvider.value(value: Provider.of<ListCourses>(context,listen: false),
                                                child: DetailCoursePage(dataCourse: item))
                                    )
                                    );
                                  },
                                  child: Container(
                                      child: Container(
                                        margin: EdgeInsets.all(5.0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            child: Stack(
                                              children: <Widget>[
                                                Image.asset(item.promoVidUrl,
                                                    fit: BoxFit.cover, width: 350.0,height: 500),
                                                //  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                                                Positioned(
                                                  bottom: 0.0,
                                                  left: 0.0,
                                                  right: 0.0,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Color.fromARGB(
                                                              200, 0, 0, 0),
                                                          Color.fromARGB(0, 0, 0, 0)
                                                        ],
                                                        begin: Alignment.bottomCenter,
                                                        end: Alignment.topCenter,
                                                      ),
                                                    ),
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 20.0),
                                                    child: Text(item.title,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      )
                                  )
                              )
                          ).toList(),
                        )
                    );
                  }
                  else if (index == 1)
                    return Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      child: Text('Continue?', style: TextStyle(fontSize: 18.0,color: Colors.indigo,fontWeight: FontWeight.bold)),
                    );
                  else if (index == 2)
                    return Container (
                      child: GestureDetector(
                          onTap: () {

                          },
                          child: CarouselSlider(
                            options: CarouselOptions(),
                            items: listCourses.listCourse.map((item) => Container(
                              height: 200,
                              margin: EdgeInsets.all(10.0),
                              child: Column(
                                  children: <Widget>[
                                    Image.asset(item.promoVidUrl,fit: BoxFit.cover, width:300.0,height: 180.0),
                                    Text(item.title,style: TextStyle(fontSize: 18.0))
                                  ]
                              ),
                            )).toList(),
                          )
                      ),
                    );
                  else if (index == 3)
                    return Text('My Courses', style: TextStyle(fontSize: 18.0, color: Colors.indigo,fontWeight: FontWeight.bold));
                  else
                    return Container(padding: EdgeInsets.all(2),
                        height: 100,
                        child: (listCourses.myCourses.length == 0)? Container (
                          alignment: Alignment.center,
                          child: Text(
                            'There are no  courses!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),):
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (_) =>
                                      ChangeNotifierProvider.value(value: Provider.of<ListCourses>(context,listen: false),
                                          child: DetailCoursePage(dataCourse: listCourses.myCourses[index-4]))
                              )
                              );
                            },
                            child: Card(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Image.asset(listCourses.myCourses[index-4].promoVidUrl,width: 125),
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(listCourses.myCourses[index-4].title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                Text('Total Hours: ' + listCourses.myCourses[index-4].totalHours.toString()),
                                                Text('Total clip: '+ listCourses.myCourses[index-4].videoNumber.toString()),
                                                // RatingBox(),
                                              ],
                                            )
                                        )
                                    )
                                  ]
                              ),
                            )
                        )
                    );
                },
              )

          ),
        )
    );
  }
}