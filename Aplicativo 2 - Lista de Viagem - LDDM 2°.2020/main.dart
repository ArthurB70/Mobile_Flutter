import 'package:Lista/views/Item.List_view.view.dart';
import 'package:flutter/material.dart';
import 'package:Lista/models/Item.models.dart';

void main() {
  runApp(MaterialApp(
    title: 'Trip List',
    debugShowCheckedModeBanner: false,
    home: ItemListView(),
  ));
}