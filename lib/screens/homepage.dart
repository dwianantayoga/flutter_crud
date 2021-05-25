import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DataTampil extends StatefulWidget {
  @override
  _DataTampilState createState() => _DataTampilState();
}

class _DataTampilState extends State<DataTampil> {
  //inget ganti yang isi 192.168.1.3 ini sesuaikan sama IP punya mu yang di IPConfig
  final String url = "http://192.168.1.12/api/products";
  Future getInput() async {
    var response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }

  Future deleteData(String dataId) async {
    final String url = "http://192.168.1.12/api/products" + dataId;
    var response = await http.delete(Uri.parse(url));

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: getInput(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Card(
                                  elevation: 8,
                                  child: ListTile(
                                    leading: Image.network(snapshot.data['data'][index]['image_url']),
                                    
                                    title: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Nama : " +
                                                  snapshot.data['data'][index]['name']),
                                              IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    // yang ini diemin ya ini untuk hapus datanya
                                                    // jadi index yang di ambil itu dari ID datanya misalkan ID 1 berarti data ke 1 yang di hapus
                                                    deleteData(snapshot.data['data'][index]['id']
                                                            .toString())
                                                        .then((value) {
                                                      setState(() {});
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                              content: Text("Data sudah dihapus")));
                                                    });
                                                  })
                                            ],
                                          ),
                                          Text("Description :" + snapshot.data['data'][index]['description']),
                                          Text("price :" + snapshot.data['data'][index]['price'].toString()),
                                          
                                        ],
                                      ),
                                    ),
                                  )));
                        });
                  } else {
                    return Text("Error");
                  }
                }),
          ],
        ),
      ),
    );
  }
}