//import 'dart:html';
import 'package:customer_ledger/blocs/app_blocs.dart';
import 'package:customer_ledger/blocs/app_events.dart';
import 'package:customer_ledger/blocs/app_state.dart';
import 'package:customer_ledger/detailedWidget.dart';
import 'package:customer_ledger/briefview.dart';
import 'package:customer_ledger/rep/repo.dart';
import 'package:customer_ledger/searchentriesPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './get.dart';
import 'searchkey.dart';
// import './briefview.dart';
// //import 'buffer.dart';
// import 'detailedWidget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RepositoryProvider(
      create: (context) => LoadData(),
      child: const HomePageBloc(),
    ));
  }
}

class HomePageBloc extends StatefulWidget {
  const HomePageBloc({Key? key}) : super(key: key);

  @override
  State<HomePageBloc> createState() => _HomePageBlocState();
}

class _HomePageBlocState extends State<HomePageBloc> {
  var x = 1;
  var l = [];
  var selected = "";
  void changeState(List<User> user) {
    setState(() {
      x = 0;
    });
    l = user;
  }

  void changeback() {
    setState(() {
      x = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (x == 1)
        ? BlocProvider(
            create: (context) =>
                UserBloc(RepositoryProvider.of<LoadData>(context), 0)
                  ..add(LoaderUserEvent()),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text("Customer Ledger"),
              ),
              body: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is UserLoadedState) {
                    List<User> usr = state.users;

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7.5),
                      color: const Color.fromARGB(255, 217, 224, 227),
                      child: Column(
                        children: [
                          Container(
                            // padding: EdgeInsets.only(
                            //     left: MediaQuery.of(context).size.width * 0.1),
                            // // alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // color: Colors.white,
                                  margin: EdgeInsets.only(top: 6, bottom: 5),
                                  alignment: Alignment.centerLeft,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (c) {
                                              return SearchPage(usr);
                                            }));
                                          },
                                          child: const Text(
                                            "Search",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (c) {
                                              return SearchPage(usr);
                                            }));
                                          },
                                          icon: const Icon(Icons.search)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: DropdownButton<String>(
                                    items: <String>['name', 'username', 'email']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (n) {
                                      setState(() {
                                        selected = n!;
                                      });
                                      if (n == "name") {
                                        usr.sort((a, b) =>
                                            (a.name).compareTo(b.name));
                                      }
                                      if (n == "username") {
                                        usr.sort((a, b) =>
                                            (a.username).compareTo(b.username));
                                      }
                                      if (n == "email") {
                                        usr.sort((a, b) =>
                                            (a.email).compareTo(b.email));
                                      }
                                      changeState(usr);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.77,
                            child: ListView.builder(
                                itemCount: usr.length,
                                itemBuilder: (_, index) => InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (c) {
                                          return DetailedWidget(usr[index].id);
                                        }));
                                      },
                                      child: Briefview(
                                          usr[index].id,
                                          usr[index].name,
                                          usr[index].username,
                                          usr[index].email),
                                    )),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is UserErrorState) {
                    return Center(
                      child: Text(state.msg),
                    );
                  }
                  return Container();
                },
              ),
            ),
          )
        //return
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text("Customer Ledger")),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7.5),
              color: const Color.fromARGB(255, 217, 224, 227),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // color: Colors.white,
                          margin: EdgeInsets.only(top: 6, bottom: 5),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (c) {
                                      return SearchPage(l as List<User>);
                                    }));
                                  },
                                  child: const Text(
                                    "Search",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  )),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (c) {
                                      return SearchPage(l as List<User>);
                                    }));
                                  },
                                  icon: const Icon(Icons.search)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: DropdownButton<String>(
                            elevation: 10,
                            value: selected,
                            items: <String>['name', 'username', 'email']
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
                                l.sort((a, b) =>
                                    (a.username).compareTo(b.username));
                              }
                              if (n == "email") {
                                l.sort((a, b) => (a.email).compareTo(b.email));
                              }
                              changeState(l as List<User>);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                        itemCount: l.length,
                        itemBuilder: (_, index) => InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (c) {
                                  return DetailedWidget(l[index].id);
                                }));
                              },
                              child: Briefview(l[index].id, l[index].name,
                                  l[index].username, l[index].email),
                            )),
                  ),
                ],
              ),
            ),
          );
  }
}
