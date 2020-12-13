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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(
                  flex: 1,
                ),
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
                    '',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Text(widget.task['description']),
            Spacer(
              flex: 4,
            )
          ],
        ),
      )),
    );
  }
}
