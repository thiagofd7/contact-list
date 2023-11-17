import 'package:flutter/material.dart';

class ShowDailog {
  Future showdailogg({
    required BuildContext context,
    required String contact,
    required PageRoute page,
  }) {
    var height = MediaQuery.sizeOf(context).height;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          contact,
          textAlign: TextAlign.center,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'O que deseja fazer:',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: height * 0.03,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.black,
        actions: [
          ElevatedButton(
              onPressed: () {
                // ignore: unrelated_type_equality_checks
                Navigator.pushReplacement(context, page) == false;
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.edit), Text('Editar Contato')],
              )),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.delete_forever), Text('Excluir Contato')],
              )),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.close_rounded), Text('Cancelar')],
              ))
        ],
      ),
    );
  }
}
