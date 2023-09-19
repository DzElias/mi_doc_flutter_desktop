import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget();

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: const Text('Buscar Paciente', style: TextStyle(color: Colors.grey, fontSize: 18),),
          ),
    
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Icon(Icons.search, color: Colors.grey,),
          )
        ],
      ),
    );
  }
}