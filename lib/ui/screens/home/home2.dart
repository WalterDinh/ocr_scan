import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_app/configs/colors.dart';

class Home2Screen extends StatelessWidget {
  final _listScanFolder = [1, 2, 3, 4, 5];
  final _listScanHistory = [1, 2, 3, 4, 5];

  Home2Screen({super.key});

  Widget _buildSearchCard() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter keywords..."),
                  ),
                ),
                Icon(Icons.search),
              ],
            ),
          ),
        ),
      );

  Widget _buildSectionScanFolderHeader() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("My scan folder"),
        Text("See more"),
      ]));

  Widget _buildListScanFolder() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Container(
        height: 56.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _listScanFolder.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                color: AppColors.pink,
                width: 56.0,
                child: Text("Item ${_listScanFolder[index]}"));
          },
        ),
      ));

  Widget _buildSectionScanHistoryHeader() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Scan history"),
        Text("See more"),
      ]));

  Widget _buildListScanHistory() => Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Container(
        height: 300.0,
        child: ListView.builder(
          itemCount: _listScanHistory.length,
          itemBuilder: (context, index) {
            return cartItems(index);
            // return Container(
            //     color: AppColors.pink,
            //     height: 56.0,
            //     child: Text("Item ${_listScanHistory[index]}"));
          },
        ),
      ));

  // fixme: re-decoration
  Widget cartItems(int index) {
    return Container(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      height: 130,
      child: Row(
        children: <Widget>[
          Container(
            width: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/logo_flutter.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "Item 1" + index.toString(),
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                      Container(
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            print("Button Pressed");
                          },
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          iconSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Price: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$200',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Sub Total: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text('\$400',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.orange,
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Ships Free",
                        style: TextStyle(color: Colors.orange),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          InkWell(
                            // onTap: () {},
                            splashColor: Colors.redAccent.shade200,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('2'),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            // onTap: () {},
                            splashColor: Colors.lightBlue,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scanner")),
      body: Column(
        children: [
          _buildSearchCard(),
          _buildSectionScanFolderHeader(),
          _buildListScanFolder(),
          _buildSectionScanHistoryHeader(),
          _buildListScanHistory()
        ],
      ),
    );
  }
}
