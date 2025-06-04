//main
import 'package:flutter/material.dart';
import 'package:spent_it/windows/spentIt.dart';

void main(){
  runApp(MaterialApp(
      title: 'Spent It App',
      debugShowCheckedModeBanner: false,
      home: SpentIt(),
      )
  );
}