import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivedatabase/createTask.dart';
import 'package:hivedatabase/productScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController tabcontroller;
  final task = Hive.box('tasks');
  final doneTask = Hive.box('doneTasks');
  final date = DateTime.now();

  @override
  void initState() {
    tabcontroller = TabController(length: 3, vsync: this);
    // TODO: implement initState
    super.initState();
    String datetime = '${date.month}/${date.day}/${date.year}';
    String time =
        formatDate(DateTime(2019, 08, 1, DateTime.now().hour), [hh]).toString();
    // print(time);
    pendingTasks.clear();
    for (var i in task.keys) {
      String a = task.get(i)['time'];
      int b = int.parse(a.substring(0, 2));
      if (datetime == task.get(i)['date'] && b >= int.parse(time)) {
        print('tasks are pending');
        pendingTasks.add(task.get(i));
      }
    }
  }

  List pendingTasks = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent.withOpacity(0.8),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return CreateTask();
          }));
        },
        child: Text('+'),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        title: Text(
          'Do it',
          style: TextStyle(),
        ),
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
        bottom: TabBar(
          indicatorColor: Colors.purple,
          controller: tabcontroller,
          tabs: [
            Tab(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/feather-pen_icon-icons.com_64932 (1).png',
                    color: Colors.white,
                    scale: 1.5,
                  ),
                  Text(
                    'To Do',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/refresh-page-arrow-button_icon-icons.com_53909.png',
                    color: Colors.white,
                    scale: 1.5,
                  ),
                  Text(
                    'Doing',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/workdone_87219 (2).png',
                    color: Colors.white,
                    scale: 1.5,
                  ),
                  Text(
                    'Done',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: tabcontroller, children: [
        WatchBoxBuilder(
          box: task,
          builder: (BuildContext context, Box<dynamic> box) => ListView.builder(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            itemCount: task.length,
            itemBuilder: (BuildContext context, int index) {
              if (task.length == 0) {
                return Container();
              }
              Map abc = task.getAt(index);
              print(abc);
              Color priority;
              switch (abc['priority']) {
                case 'urgent':
                  priority = Colors.red;
                  break;
                case 'later':
                  priority = Colors.green;
                  break;
                case 'future':
                  priority = Colors.blue;
                  break;
                default:
                  priority = Colors.white;
                  break;
              }
              return Dismissible(
                onDismissed: (DismissDirection direction) {
                  doneTask.add(abc);
                  task.deleteAt(index);
                },
                key: UniqueKey(),
                background: Container(),
                secondaryBackground: slideRightBackground(),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext coxtext) => ProductScreen(
                              task: abc,
                            )));
                  },
                  child: Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 80,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade300,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                                blurRadius: 10)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(abc['title']),
                          Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(abc['time']),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 10),
                                height: 20,
                                width: size.width * 0.2 - 10,
                                child: Center(
                                    child: Text(
                                  abc['priority'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                                decoration: BoxDecoration(
                                    color: priority,
                                    borderRadius: BorderRadius.circular(20)),
                              )
                            ],
                          )
                        ],
                      )),
                ),
              );
            },
          ),
        ),
        ListView.builder(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
          itemCount: pendingTasks.length,
          itemBuilder: (BuildContext context, int index) {
            if (pendingTasks.length == 0) {
              return Container();
            }

            Color priority;
            switch (pendingTasks[index]['priority']) {
              case 'urgent':
                priority = Colors.red;
                break;
              case 'later':
                priority = Colors.green;
                break;
              case 'future':
                priority = Colors.blue;
                break;
              default:
                priority = Colors.white;
                break;
            }
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                pendingTasks.removeAt(index);
              },
              key: UniqueKey(),
              background: Container(),
              secondaryBackground: slideRightBackground(),
              child: Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 80,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            offset: Offset(0, 0),
                            blurRadius: 12)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pendingTasks[index]['title']),
                      Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(pendingTasks[index]['time']),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            height: 20,
                            width: size.width * 0.2 - 10,
                            child: Center(
                                child: Text(
                              pendingTasks[index]['priority'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            decoration: BoxDecoration(
                                color: priority,
                                borderRadius: BorderRadius.circular(20)),
                          )
                        ],
                      )
                    ],
                  )),
            );
          },
        ),
        WatchBoxBuilder(
          box: doneTask,
          builder: (context, doneTask) => ListView.builder(
            padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            itemCount: doneTask.length,
            itemBuilder: (BuildContext context, int index) {
              Map abc = doneTask.getAt(index);
              print(abc);
              Color priority;
              switch (abc['priority']) {
                case 'urgent':
                  priority = Colors.red;
                  break;
                case 'later':
                  priority = Colors.green;
                  break;
                case 'future':
                  priority = Colors.blue;
                  break;
                default:
                  priority = Colors.white;
                  break;
              }
              return Dismissible(
                onDismissed: (DismissDirection direction) {
                  doneTask.deleteAt(index);
                },
                key: UniqueKey(),
                background: Container(),
                secondaryBackground: slideRightBackground(),
                child: Container(
                    padding: EdgeInsets.only(left: 20),
                    height: 80,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              offset: Offset(0, 0),
                              blurRadius: 12)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(abc['title']),
                        Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Text(abc['time']),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 10),
                              height: 20,
                              width: size.width * 0.2 - 10,
                              child: Center(
                                  child: Text(
                                abc['priority'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                              decoration: BoxDecoration(
                                  color: priority,
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        )
                      ],
                    )),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget slideRightBackground() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.5),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
