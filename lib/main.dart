import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gladdy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


// List in reverse Order
List<String> images = [
  "assets/images/4.jpg",
  "assets/images/3.jpg",
  "assets/images/2.jpg",
  "assets/images/1.jpg"
];

List<String> title = [
  "Explore city",
  "New experience",
  "Morocco visit",
  "Perfect day",  
];

List<String> uppertitle = [
  "December, 24",
  "December, 23",
  "December, 22",
  "December, 21",  
];

class _HomePageState extends State<HomePage> {
  var currentPage = images.length - 1.0;
  @override
  Widget build(BuildContext context) {
    PageController controller =  PageController(initialPage: images.length - 1);
    controller.addListener( () {
      setState(() {
        currentPage = controller.page;
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.0, top: 50.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/logo.gif")
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.tune, color: Color(0xff19343e),),
                      SizedBox(height: 10.0,),
                      Icon(Icons.add, color: Colors.blue,),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
                child: Text(
                  "Good morning, Shivam\nWhat's your mood today?",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                    color: Color(0xff19343e)
                  ),
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: images.length,
                    controller: controller,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return Container();
                    }
                  )
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit, color: Colors.blue,),
            title: Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline, color: Color(0xff19343e),),
            title: Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Color(0xff19343e),),
            title: Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_comment, color: Color(0xff19343e),),
            title: Text('')
          ),
        ],
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for(var i = 0; i< images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding + max(
            primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1),
            0.0
          );

          var cardItem= Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3.0, 6.0),
                      blurRadius: 10.0
                    )
                  ]
                ),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(images[i], fit: BoxFit.cover),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      uppertitle[i],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      title[i],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                )
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        ); 
      }),
    );
  }
}