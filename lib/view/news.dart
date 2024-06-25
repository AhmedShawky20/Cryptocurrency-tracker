import 'dart:convert';
import 'package:Cryptocurrency/model/news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends GetWidget {
  Future getData() async {
    final url =
        Uri.parse("https://min-api.cryptocompare.com/data/v2/news/?lang=EN");
    var response = await http.get(url);
    print('the requst $response');
    if (response.statusCode == 200) {
      try {
        print('try to get data');
        print(response);
        var jsonResponse = json.decode(response.body);
        return News.fromJson(jsonResponse);
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("news"),
        centerTitle: true,

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<dynamic>(
            future: getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                return Center(
                  child: Text("No data available"),
                );
              } else {
                List<Data> dataList = snapshot.data!.data;

                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Components(dataList[index]);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
