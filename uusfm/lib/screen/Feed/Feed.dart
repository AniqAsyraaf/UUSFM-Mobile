import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uusfm/viewmodel/feedviewmodel.dart';
import 'package:uusfm/model/feedmodel.dart';
import 'package:uusfm/partial/SideNavBar.dart';
import 'package:uusfm/viewmodel/userviewmodel.dart';

class Feed extends StatefulWidget {
  final UserViewmodel _userviewmodel;
  Feed({userviewmodel}) : _userviewmodel = userviewmodel;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  List<Tab> _tabList = [
    Tab(
      child: Text("Announcement"),
    ),
    Tab(
      child: Text("Promotion"),
    ),
    Tab(
      child: Text("Notice"),
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
      drawer: SideNavBar(),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: true,
        title: Text(
          'Feed',
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
                  future: viewfeed(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          FeedModel feedmodel = snapshot.data[index];

                          return Card(
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (feedmodel.feedCategory == "Announcement")
                                  Text(
                                    '${feedmodel.feedTitle}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                if (feedmodel.feedCategory == "Announcement")
                                  Text('${feedmodel.feedDesc}'),
                                if (feedmodel.feedCategory == "Announcement")
                                  Text(
                                    '${DateFormat.yMMMEd().format(feedmodel.createdAt)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                              ],
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
                  future: viewfeed(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          FeedModel feedmodel = snapshot.data[index];

                          return Card(
                            elevation: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (feedmodel.feedCategory == "Promotion")
                                  Text(
                                    '${feedmodel.feedTitle}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                if (feedmodel.feedCategory == "Promotion")
                                  Text('${feedmodel.feedDesc}'),
                                if (feedmodel.feedCategory == "Promotion")
                                  Text(
                                    '${DateFormat.yMMMEd().format(feedmodel.createdAt)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                              ],
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
                  future: viewfeed(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          FeedModel feedmodel = snapshot.data[index];

                          return Card(
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                if (feedmodel.feedCategory == "Notice")
                                  Text(
                                    '${feedmodel.feedTitle}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                if (feedmodel.feedCategory == "Notice")
                                  Text('${feedmodel.feedDesc}'),
                                if (feedmodel.feedCategory == "Notice")
                                  Text(
                                    '${DateFormat.yMMMEd().format(feedmodel.createdAt)}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
