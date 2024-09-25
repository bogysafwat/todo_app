

import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {required this.controller, required this.onCancel, required this.onSave});

  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

        content: Form(
          key: _formKey,
          child: TextFormField(
            style: TextStyle(color: Colors.white),
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Add a new task',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white),),

            ),
            validator:(value) {
              if(value==null || value.isEmpty){
                return 'Please enter your task';
              }else{
                return null;
              }
            } ,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        actions: [
          Row(
              children: [
                Expanded(child:
                ElevatedButton(
                    onPressed: onCancel,
                    child: Text('cancel',)
                )
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed:(){
                          if(_formKey.currentState?.validate()==true){
                            onSave();
                          }
                        },
                        child: Text('save',)
                    )
                )
              ]

          )

        ]

    );
  }
}
