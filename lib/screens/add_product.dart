import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/main.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/screens/homepage.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  TextEditingController _imageUrlController = TextEditingController();

  Future saveProduct() async{
   final response = await http.post(Uri.parse("http://192.168.1.12:80/api/products"),body: {
     "name":_nameController.text,
     "description":_descriptionController.text,
     "price":_priceController.text,
     "image_url":_imageUrlController.text
   });
   print(response.body);

   return json.decode(response.body);
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukan Nama Produk";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukan Deskripsi Produk";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Price"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Masukan Harga Produk";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
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
                      saveProduct().then((value) {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DataTampil()));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Produk Berhasil Ditambah"),
                        ));
                      });
                    }
                  },
                  child: Text("Save"))
            ],
          ),
        ));
  }
}
