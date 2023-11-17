import 'package:flutter/material.dart';

class ListIsempt extends StatelessWidget {
  const ListIsempt({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_call,
            color: Colors.black,
            size: height * 0.1,
          ),
          Text(
            'Lista de contatos vazia no momento!',
            style: TextStyle(
                color: Colors.black,
                fontSize: height * 0.023,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
