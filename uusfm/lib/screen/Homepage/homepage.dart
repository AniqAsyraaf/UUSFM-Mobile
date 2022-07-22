import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uusfm/model/bookingmodel.dart';
import 'package:uusfm/screen/Booking/Booking.dart';
import 'package:uusfm/screen/Feed/Feed.dart';
import 'package:uusfm/model/membershipmodel.dart';
import 'package:uusfm/viewmodel/bookingviewmodel.dart';
import 'package:uusfm/viewmodel/membershipviewmodel.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class Homepage extends StatefulWidget {
  final UserViewmodel _userviewmodel;
  Homepage(userviewmodel) : _userviewmodel = userviewmodel;

  var temp = DateTime.now();

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          'Homepage',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Container(
          //     child: FutureBuilder(
          //         future: viewMembership(widget._userviewmodel.user.id),
          //         builder: (context, snapshot) {
          //           if (snapshot.hasData) {
          //             return ListView.builder(
          //               itemCount: snapshot.data.length,
          //               shrinkWrap: true,
          //               itemBuilder: (BuildContext context, index) {
          //                 MembershipModel Membershipmodel =
          //                     snapshot.data[index];
          //                 print(Membershipmodel.cId);

          //                 return Card(
          //                   elevation: 5,
          //                   child: InkWell(
          //                     onTap: () {
          //                       // Navigator.of(context).push(MaterialPageRoute(
          //                       //   builder: (context) => BookingForm2(
          //                       //     widget._userViewmodel,
          //                       //     snapshot.data[index],
          //                       //   ),
          //                       // ));
          //                     },
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: <Widget>[
          //                         Text(
          //                             'Welcome ' +
          //                                 widget._userviewmodel.user.cName,
          //                             textAlign: TextAlign.center),
          //                         Text(''),
          //                         Text('Your UTM Gym membership:  ',
          //                             textAlign: TextAlign.center),
          //                         Column(
          //                           children: [
          //                             Text(''),
          //                           ],
          //                         ),
          //                         Row(
          //                           mainAxisAlignment: MainAxisAlignment.center,
          //                           children: [
          //                             if (Membershipmodel.membershipEntry !=
          //                                 null)
          //                               Row(
          //                                 children: [
          //                                   Text('Entry left :'),
          //                                   Text(
          //                                     '${Membershipmodel.membershipEntry}',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.bold),
          //                                   ),
          //                                 ],
          //                               ),

          //                             //you can add today's date here
          //                             if (Membershipmodel.membershipExpired !=
          //                                 null)
          //                               Row(
          //                                 children: [
          //                                   Text('Valid until: '),
          //                                   Text(
          //                                     '${DateFormat("dd-MM-yyyy").format(DateTime.parse(Membershipmodel.membershipExpired))}',
          //                                     style: TextStyle(
          //                                         fontWeight: FontWeight.bold),
          //                                   ),
          //                                 ],
          //                               ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 );
          //               },
          //             );
          //           }
          //           return Container(
          //               child: Center(child: CircularProgressIndicator()));
          //         }),
          //   ),
          // ),
          Text(''),
          Text('Hello, ' + widget._userviewmodel.user.cName),
          Text(''),
          Text('Incoming Booked Sessions',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewBooking(widget._userviewmodel.user.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          BookingModel Bookingmodel = snapshot.data[index];

                          return Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => BookingForm2(
                                //     widget._userViewmodel,
                                //     snapshot.data[index],
                                //   ),
                                // ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Text(''),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${Bookingmodel.sessionType}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(''),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.calendar_month),
                                              Text(
                                                ' ${DateFormat("dd-MM-yyyy").format(Bookingmodel.bookDate)}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(Icons.watch_later),
                                              Text(
                                                ' ${Bookingmodel.bookTime}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
