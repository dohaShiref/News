import 'package:flutter/material.dart';
import 'package:news_application/api/ApiManager.dart';
import 'package:news_application/home/NewsListItem.dart';
import 'package:news_application/model/NewsResponse.dart';
import 'package:news_application/model/SouresResponse.dart';

class NewsFragment extends StatefulWidget {
  final Source source;

  NewsFragment(this.source);

  @override
  _NewsFragmentState createState() => _NewsFragmentState();
}

class _NewsFragmentState extends State<NewsFragment> {
  Future<NewsResponse> newsFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsFuture = loadNews(widget.source);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<NewsResponse>(
        future: newsFuture,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ListView.builder(
              itemBuilder: (buildContext, index) {
                return NewsListItem(snapShot.data.articles[index]);
              },
              itemCount: snapShot.data.articles.length??0,
            );
          } else if (snapShot.hasError) {
            return Text(snapShot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
