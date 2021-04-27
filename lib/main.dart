import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampuShop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Accueil'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List imgNews = [
    "image/camp1.jpg",
    "image/camp2.jpg",
    "image/camp3.jpg",
    "image/camp4.jpg",
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("Bienvenue"),
        centerTitle: true,
        leading: IconButton(
            icon: new Image.asset("image/facebook2.png"),
            onPressed: () =>
                _lienVer("https://www.facebook.com/campushop2020/")),
        actions: <Widget>[
          IconButton(
              icon: new Image.asset("image/Instagram3.png"),
              onPressed: () =>
                  _lienVer("https://www.instagram.com/campushop_officielle/"))
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 150,
              height: 150,
              child: ClipOval(
                child: CircleAvatar(
                  child: Image.asset("image/camp_logo.jpg"),
                ),
              ),
            ),
            //  Text(""),
            Container(
              child: defilement(),
            ),
            Center(
              child: RaisedButton(
                onPressed: _launchURL,
                child: Text('Accéder à la boutique'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: footer(),
    );
  }
  /******************** */

  _launchURL() async {
    const url = 'http://shop-campus.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _lienVer(String url) async {
    //const url = 'http://shop-campus.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget footer() {
    return new BottomNavigationBar(items: [
      new BottomNavigationBarItem(
        icon: new IconButton(
            icon: Icon(Icons.phone),
            onPressed: () => _lienVer("tel:+221779552488")),
        title: new Text("Contact"),
      ),
      new BottomNavigationBarItem(
        icon: new IconButton(
            icon: new Image.asset("image/Whatsapp-icon3.png"),
            onPressed: () => _lienVer(
                "whatsapp://send?phone=+221763939789")), //  "https://wa.me/c/221781579356"
        title: new Text(
          "message",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      new BottomNavigationBarItem(
        icon: new IconButton(
            icon: Icon(
              Icons.email,
              color: Colors.blue,
            ),
            onPressed: () => _lienVer("mailto:campusshopp@gmail.com")),
        title: new Text(
          "mail",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ]);
  }

  Widget defilement() {
    return Column(children: <Widget>[
      Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              height: 250,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imgNews.map(
              (url) {
                return Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      child: IconButton(
                          iconSize: 230,
                          icon: new Image.asset(
                            url,
                            fit: BoxFit.fill,
                            height: 250,
                          ),
                          tooltip:
                              url == "image/camp4.jpg" ? 'voir Catalogue' : '',
                          onPressed: () {
                            if (url == "image/camp4.jpg") {
                              _lienVer("https://wa.me/c/221781579356");
                            }
                          }),
                      /*
                      child: Image.asset(
                        url,
                        fit: BoxFit.fill,
                        height: 250,
                      ),*/
                    ),
                  ],
                ));
              },
            ).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 210),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(imgNews, (index, url) {
                return Container(
                  width: 6.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index ? Colors.red : Colors.blueGrey,
                  ),
                );
              }),
            ),
          ),
        ],
      )
    ]);
  }

  /******************** */
}
