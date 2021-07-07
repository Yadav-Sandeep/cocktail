import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //var api = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=cocktail";

  var url = Uri.parse(
      "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=cocktail");

  var res, drinks;

  @override
  void initState() {
    super.initState();

    print("test");
    fetchData();
  }

  fetchData() async {
    res = await http.get(url);
    print(res.body);
    drinks = jsonDecode(res.body)["drinks"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("Cocktail App"),
      ),
      body: Center(
        child: res != null ? ListView.builder(
            itemCount: drinks.length,
            itemBuilder: (context, index) {
              var drink = drinks[index];
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(
                  drink["strDrinkThumb"]
                ),),
                title: Text(
                  "${drink["strDrink"]}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),
                subtitle: Text(
                  "${drink["idDrink"]}",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              );
            }
        ): CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
