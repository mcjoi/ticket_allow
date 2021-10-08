import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> main() async {
  // 01. firestore 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainOperation(),
  ));
}

class MainOperation extends StatefulWidget {
  const MainOperation({Key? key}) : super(key: key);

  @override
  State<MainOperation> createState() => _MainOperationState();
}

class _MainOperationState extends State<MainOperation> {
  //PassWord Form
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  //first Text before input password. after input password, it will change to password.
  String passtxt = 'not yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.text_fields),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: bts,
            barrierColor: Colors.black,
          );
        },
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            //local_elevatedbutton(txt: 'from local package'),
            Text(
              passtxt,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget bts(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text('Enter your parents passWord. it is 4-Digit words.'),
        const SizedBox(height: 30),
        Form(
          key: _formkey,
          child: PinCodeTextField(
            appContext: context,
            controller: _textEditingController,
            autoFocus: true,
            keyboardType: TextInputType.number,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            length: 4,
            autoDisposeControllers: false,
            onChanged: (newtxt) {},
            onCompleted: (newtxt) {
              // TODO: setstate 없애고, 처리해주세요.
              setState(() {
                passtxt = newtxt;
              });
              // TODO: 비밀번호 체크항목 수정해주세요.
              if (newtxt == '7256') {
                _textEditingController.clear();
                Navigator.of(context).pop();
              } else {
                Fluttertoast.showToast(
                  msg: 'Password is not $newtxt, Password is incorrect',
                  textColor: Colors.white,
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.red,
                );

                _textEditingController.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
