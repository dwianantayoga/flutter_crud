import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/main.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/screens/homepage.dart';

class EditProduct extends StatefulWidget {
  final Map product;

  EditProduct({@required this.product});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  TextEditingController _imageUrlController = TextEditingController();

  Future updateProduct() async {
    final response = await http.put(
        Uri.parse("http://192.168.1.12:80/api/products/" +
            widget.product['id'.toString()]),
        body: {
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": _priceController.text,
          "image_url": _imageUrlController.text
        });
    print(response.body);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController..text = widget.product['name'],
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukan Nama Produk";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController
                  ..text = widget.product['description'],
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukan Deskripsi Produk";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController..text = widget.product['price'],
                decoration: InputDecoration(labelText: "Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukan Harga Produk";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController..text = widget.product['image_url'],
                decoration: InputDecoration(labelText: "Image_url"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukan Url Gambar";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      updateProduct().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DataTampil()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Produk Berhasil Diupdate"),
                        ));
                      });
                    }
                  },
                  child: Text("Update"))
            ],
          ),
        ));
  }
}
