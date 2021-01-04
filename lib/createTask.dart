import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedatabase/ColorProvider.dart';
import 'package:provider/provider.dart';

import 'DTPicker.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DtPicker pickers = Provider.of<DtPicker>(context, listen: false);
    pickers.init();
  }

  String setDate;
  String setTime;
  String priority;
  final title = TextEditingController();
  final description = TextEditingController();
  int selectedindex = 0;
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SelectedCategory colorchange = Provider.of<SelectedCategory>(context);
    Size size = MediaQuery.of(context).size;
    DtPicker picker = Provider.of<DtPicker>(context);
    setDate = picker.dateController.text;
    setTime = picker.timeController.text;
    priority = 'urgent';
    final task = Hive.box('tasks');
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.purpleAccent,
      body: SafeArea(
        child: Form(
          child: ListView(
            children: [
              Container(
                height: size.height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.chevron_left),
                            onPressed: () => Navigator.of(context).pop())
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Create a New Task',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: size.height - size.height * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Titles'),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(hintText: 'Title of task'),
                      style: TextStyle(),
                    ),
                    Text('Description'),
                    TextFormField(
                      controller: description,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Description',
                      ),
                    ),
                    Text('Due Date'),
                    InkWell(
                      onTap: () => picker.selectDate(context),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: picker.dateController,
                        onSaved: (String val) {
                          setDate = val;
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            // labelText: 'Time',
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                    Text('Time'),
                    InkWell(
                      onTap: () => picker.selectTime(context),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: picker.timeController,
                        onSaved: (String val) {
                          setTime = val;
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            // labelText: 'Time',
                            contentPadding: EdgeInsets.only(top: 0.0)),
                      ),
                    ),
                    Text('Priority'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            selectedindex =
                                colorchange.selectedCategory(0, selectedindex);
                            priority = 'urgent';
                          },
                          child: Container(
                            child: Center(child: Text('urgent')),
                            width: size.width / 4,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectedindex != null &&
                                          selectedindex == 0
                                      ? Colors.black
                                      : Colors.grey,
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            priority = 'future';
                            selectedindex =
                                colorchange.selectedCategory(1, selectedindex);
                          },
                          child: Container(
                            child: Center(child: Text('future')),
                            width: size.width / 4,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectedindex != null &&
                                          selectedindex == 1
                                      ? Colors.black
                                      : Colors.grey,
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            priority = 'later';
                            selectedindex =
                                colorchange.selectedCategory(2, selectedindex);
                          },
                          child: Container(
                            child: Center(child: Text('later')),
                            width: size.width / 4,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectedindex != null &&
                                          selectedindex == 2
                                      ? Colors.black
                                      : Colors.grey,
                                )),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          if (title.text != '' && description.text != '') {
                            task.add({
                              'title': title.text,
                              'description': description.text,
                              'date': picker.dateController.text.toString(),
                              'time': picker.timeController.text.toString(),
                              'priority': priority
                            });
                            print('Data added');
                            Navigator.of(context).pop();
                          } else {
                            // task.deleteAt(0);
                            // task.deleteAt(1);
                            print(picker.dateController.text);
                            print(picker.timeController.text);
                            globalKey.currentState.showSnackBar(SnackBar(
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              content: Text('Fill all boxes'),
                            ));
                          }
                        },
                        child: Container(
                          width: size.width - 20,
                          height: 60,
                          child: Center(
                              child: Text(
                            'Create a Task',
                            style: TextStyle(color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    title.dispose();
    description.dispose();
    priority = "";
  }
}
