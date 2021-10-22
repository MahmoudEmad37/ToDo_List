import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/model/database.dart';
import 'package:to_do_list/pages/add_event_page.dart';
import 'package:to_do_list/pages/add_task_page.dart';
import 'package:to_do_list/pages/event_page.dart';
import 'package:to_do_list/pages/task_page.dart';
import 'package:to_do_list/widgets/custom_button.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Database>(create: (_) => Database())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.red, fontFamily: "Montserrat"),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();

  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 35,
            color: Theme.of(context).accentColor,
          ),
          Positioned(
            right: 0,
            child: Text(
              DateTime.now().day.toString(),
              style: TextStyle(fontSize: 200, color: Color(0x10000000)),
            ),
          ),
          _mainContent(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: currentPage == 0 ? AddTaskPage() : AddEventPage(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60.0,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            DateFormat('EEEE').format(DateTime.now()),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _button(context),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            children: [
              TaskPage(),
              EventPage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () {
              _pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut,
              );
            },
            buttonText: "Tasks",
            color:
                currentPage == 0 ? Theme.of(context).accentColor : Colors.white,
            textColor:
                currentPage == 0 ? Colors.white : Theme.of(context).accentColor,
            borderColor: currentPage == 0
                ? Colors.transparent
                : Theme.of(context).accentColor,
          ),
        ),
        SizedBox(
          width: 32.0,
        ),
        Expanded(
          child: CustomButton(
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut,
              );
            },
            buttonText: "Events",
            color:
                currentPage == 1 ? Theme.of(context).accentColor : Colors.white,
            textColor:
                currentPage == 1 ? Colors.white : Theme.of(context).accentColor,
            borderColor: currentPage == 1
                ? Colors.transparent
                : Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}
