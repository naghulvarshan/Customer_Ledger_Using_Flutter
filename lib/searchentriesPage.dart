import 'package:customer_ledger/briefview.dart';
import 'package:customer_ledger/detailedWidget.dart';
import 'package:customer_ledger/searchkey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'get.dart';

class SearchPage extends StatefulWidget {
  final List<User> l;
  //const SearchPage({super.key});
  const SearchPage(this.l, {super.key});

  @override
  State<SearchPage> createState() => _SearchPageState(l);
}

class _SearchPageState extends State<SearchPage> {
  final _searchkey = TextEditingController();
  final List<User> l;
  _SearchPageState(this.l);
  List<User> lst = [];
  var x = 0;
  void submit(String val) {
    lst = [];
    if (_site == 'name') {
      lst = l
          .where((m) =>
              m.name.toString().toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    } else if (_site == 'username') {
      lst = l
          .where((m) =>
              m.username.toString().toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    } else if (_site == 'email') {
      lst = l
          .where((m) =>
              m.email.toString().toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    } else {
      lst = l
          .where((m) =>
              m.name.toString().toLowerCase().startsWith(val.toLowerCase()))
          .toList();
    }
    setState(() {
      x = 1;
    });
  }

  var _site = 'name';
  String sometxt = "";
  var selected = " ";
  void changeState(List<User> user) {
    setState(() {
      x = 1;
    });
    lst = user;
  }

  void changefilter(String val, String v) {
    setState(() {
      _site = v;
      x = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("HI");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Customer Ledger")),
      body: x == 0
          ? Column(children: [
              Container(
                child: TextField(
                  decoration: InputDecoration(labelText: "Search key"),
                  // onChanged: ((value) {
                  //   sometxt = value;
                  // }),
                  controller: _searchkey,
                  onChanged: (val) => submit(val),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        "Search by: ",
                        style: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        elevation: 10,
                        value: _site,
                        items: <String>['name', 'username', 'email']
                            .map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _site = value!;
                          //submit(_searchkey.text);
                          x = 0;
                          _searchkey.text = "";
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Sort by:",
                        style: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        elevation: 10,
                        value: selected,
                        items: <String>[' ', 'name', 'username', 'email']
                            .map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (n) {
                          setState(() {
                            selected = n!;
                          });
                          if (n == "name") {
                            l.sort((a, b) => (a.name).compareTo(b.name));
                          }
                          if (n == "username") {
                            l.sort(
                                (a, b) => (a.username).compareTo(b.username));
                          }
                          if (n == "email") {
                            l.sort((a, b) => (a.email).compareTo(b.email));
                          }
                          changeState(l as List<User>);
                        },
                      ),
                    ],
                  )
                ],
              )
            ])
          : Column(children: [
              Container(
                  child: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchkey.clear();
                        setState(() {
                          x = 0;
                        });
                      },
                      icon: Icon(Icons.clear),
                    )),
                onSubmitted: ((value) => submit(value)),
                onChanged: (val) => submit(val),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        "Search by: ",
                        style: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        elevation: 10,
                        value: _site,
                        items: <String>['name', 'username', 'email']
                            .map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          _site = value!;
                          x = 0;
                          _searchkey.text = "";
                        }),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Sort by:",
                        style: TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.bold),
                      ),
                      DropdownButton<String>(
                        elevation: 10,
                        value: selected,
                        items: <String>[' ', 'name', 'username', 'email']
                            .map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (n) {
                          setState(() {
                            selected = n!;
                          });
                          if (n == "name") {
                            lst.sort((a, b) => (a.name).compareTo(b.name));
                          }
                          if (n == "username") {
                            lst.sort(
                                (a, b) => (a.username).compareTo(b.username));
                          }
                          if (n == "email") {
                            lst.sort((a, b) => (a.email).compareTo(b.email));
                          }

                          changeState(lst as List<User>);
                        },
                      ),
                    ],
                  )
                ],
              ),
              Container(
                child: (lst.isEmpty == true)
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Center(
                            child: Text(
                          "No data Found",
                          style: TextStyle(fontSize: 22),
                        )))
                    : SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView.builder(
                              itemCount: lst.length,
                              itemBuilder: (_, index) => InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (c) {
                                        return DetailedWidget(lst[index].id);
                                      }));
                                    },
                                    child: Briefview(
                                        lst[index].id,
                                        lst[index].name,
                                        lst[index].username,
                                        lst[index].email),
                                  )),
                        ),
                      ),
              ),
            ]),
    );
  }
}
