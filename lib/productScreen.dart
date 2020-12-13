import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  final Map task;

  const ProductScreen({Key key, this.task}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Color priority;
    switch (widget.task['priority']) {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
          child: Container(
        height: size.height * 0.6,
        width: size.width * 0.8,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 0),
              spreadRadius: 8,
              blurRadius: 10)
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(
              flex: 1,
            ),
            Text(widget.task['title']),
            Spacer(
              flex: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.task['date']} || ${widget.task['time']}'),
                Spacer(
                  flex: 1,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  height: 20,
                  width: size.width * 0.2 - 10,
                  child: Center(
                      child: Text(
                        widget.task['priority'],
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  decoration: BoxDecoration(
                      color: priority, borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Text(widget.task['description']),
            Spacer(
              flex: 4,
            ),
            FlatButton(
                onPressed: () {},
                child: Container(
                    height: 40,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text('Done'))))
          ],
        ),
      )),
    );
  }
}
