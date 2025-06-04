//main
import 'package:flutter/material.dart';
import 'package:spent_it/windows/spentIt.dart';

void main(){
  runApp(MaterialApp(
    darkTheme: ThemeData.dark(),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color.fromARGB(255, 217, 236, 251),
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor:  const Color.fromARGB(255, 217, 236, 251),
      )
    ),
      title: 'Spent It App',
      debugShowCheckedModeBanner: false,
      home: SpentIt(),
      )
  );
}