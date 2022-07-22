import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uusfm/screen/Booking/BookingForm2.dart';
import 'package:uusfm/viewmodel/sessionviewmodel.dart';
import 'package:uusfm/model/sessionmodel.dart';
import 'package:uusfm/partial/SideNavBar.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class Gymnasium extends StatefulWidget {
  UserViewmodel _userViewmodel;
  Gymnasium(userviewmodel) : _userViewmodel = userviewmodel;

  @override
  State<Gymnasium> createState() => _GymnasiumState();
}

class _GymnasiumState extends State<Gymnasium>
    with SingleTickerProviderStateMixin {
  List<Tab> _tabList = [
    Tab(
      child: Text("Mon"),
    ),
    Tab(
      child: Text("Tue"),
    ),
    Tab(
      child: Text("Wed"),
    ),
    Tab(
      child: Text("Thu"),
    ),
    Tab(
      child: Text("Fri"),
    ),
    Tab(
      child: Text("Sat"),
    ),
    Tab(
      child: Text("Sun"),
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          'Gymnasium',
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TabBar(
            indicatorColor: Colors.black,
            isScrollable: true,
            labelColor: Colors.black,
            controller: _tabController,
            tabs: _tabList,
          ),
        ),
      ),
      // body: tabs[_currentIndex],
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewGymnasium("Monday"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          SessionModel Sessionmodel = snapshot.data[index];

                          return Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingForm2(
                                    widget._userViewmodel,
                                    snapshot.data[index],
                                  ),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Sessionmodel.sessionDesc}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        ' ${Sessionmodel.sessionDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      Text(
                                        ' ${Sessionmodel.sessionTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_add_alt_1_sharp),
                                      Text(
                                        ' ${Sessionmodel.sessionCurrCap}/${Sessionmodel.sessionCapacity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewGymnasium("Tuesday"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          SessionModel Sessionmodel = snapshot.data[index];

                          return Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingForm2(
                                    widget._userViewmodel,
                                    snapshot.data[index],
                                  ),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Sessionmodel.sessionDesc}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        '${Sessionmodel.sessionDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      Text(
                                        '${Sessionmodel.sessionTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_add_alt_1_sharp),
                                      Text(
                                        '${Sessionmodel.sessionCurrCap}/${Sessionmodel.sessionCapacity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewGymnasium("Wednesday"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          SessionModel Sessionmodel = snapshot.data[index];

                          return Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingForm2(
                                    widget._userViewmodel,
                                    snapshot.data[index],
                                  ),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Sessionmodel.sessionDesc}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        '${Sessionmodel.sessionDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      Text(
                                        '${Sessionmodel.sessionTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_add_alt_1_sharp),
                                      Text(
                                        '${Sessionmodel.sessionCurrCap}/${Sessionmodel.sessionCapacity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewGymnasium("Thursday"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          SessionModel Sessionmodel = snapshot.data[index];

                          return Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingForm2(
                                    widget._userViewmodel,
                                    snapshot.data[index],
                                  ),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Sessionmodel.sessionDesc}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        '${Sessionmodel.sessionDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      Text(
                                        '${Sessionmodel.sessionTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_add_alt_1_sharp),
                                      Text(
                                        '${Sessionmodel.sessionCurrCap}/${Sessionmodel.sessionCapacity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewGymnasium("Friday"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          SessionModel Sessionmodel = snapshot.data[index];

                          return Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingForm2(
                                    widget._userViewmodel,
                                    snapshot.data[index],
                                  ),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Sessionmodel.sessionDesc}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        '${Sessionmodel.sessionDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      Text(
                                        '${Sessionmodel.sessionTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_add_alt_1_sharp),
                                      Text(
                                        '${Sessionmodel.sessionCurrCap}/${Sessionmodel.sessionCapacity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewGymnasium("Saturday"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          SessionModel Sessionmodel = snapshot.data[index];

                          return Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingForm2(
                                    widget._userViewmodel,
                                    snapshot.data[index],
                                  ),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Sessionmodel.sessionDesc}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        '${Sessionmodel.sessionDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      Text(
                                        '${Sessionmodel.sessionTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_add_alt_1_sharp),
                                      Text(
                                        '${Sessionmodel.sessionCurrCap}/${Sessionmodel.sessionCapacity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: FutureBuilder(
                  future: viewGymnasium("Sunday"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          SessionModel Sessionmodel = snapshot.data[index];

                          return Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookingForm2(
                                    widget._userViewmodel,
                                    snapshot.data[index],
                                  ),
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Sessionmodel.sessionDesc}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month),
                                      Text(
                                        '${Sessionmodel.sessionDate}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later),
                                      Text(
                                        '${Sessionmodel.sessionTime}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person_add_alt_1_sharp),
                                      Text(
                                        '${Sessionmodel.sessionCurrCap}/${Sessionmodel.sessionCapacity}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
