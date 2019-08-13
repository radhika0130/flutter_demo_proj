import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_project_name/NewsArticle.dart';
import 'package:my_project_name/Webservice.dart';
import 'package:my_project_name/widgets/Connectivity_checker.dart';
import 'package:my_project_name/widgets/ImagePickers.dart';
import 'package:my_project_name/widgets/List_view_model.dart';
import 'package:my_project_name/widgets/AlertDialogDemo.dart';

class NewsListState extends State<NewsList> with WidgetsBindingObserver {
  List<NewsArticle> _newsArticles = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _populateNewsArticles();
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all).then((newsArticles) => {
          setState(() => {_newsArticles = newsArticles})
        });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    /* _connectivity.disposeStream();*/

    //this method not called when user press android back button or quit
    print('dispose');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //print inactive and paused when quit
    print(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
      print("went to background");
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground

      print("come back to foreground");
    }
  }

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: Text(Projectlist[index]['title']),
      onTap: () => {
        if (index == 0)
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImagePickers()),
            ),
          }
        else if (index == 1)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Connectivity_checker(),
              ),
            ),
          }else{
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlertDialogDemo(),
              ),
            ),

          }
      },
    );
/*    return ListTile(
        title: _newsArticles[index].urlToImage == null
            ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL)
            : Image.network(_newsArticles[index].urlToImage),
        subtitle:
            Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
        onTap: () => {
              if (index == 1)
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImagePickers()),
                  ),
                }
              else
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Connectivity_checker(),
                    ),
                  ),
                }
            });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List of flutter demo project'),
        ),
        body: ListView.builder(
          itemCount: Projectlist.length,
          itemBuilder: _buildItemsForListView,
        ));
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState();
}
