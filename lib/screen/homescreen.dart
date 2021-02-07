import 'package:flutter/material.dart';
import 'package:yearmap/constant/common_size.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homescreen'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                height: 100,
              ),
              ListTile(
                leading: Text('leading'),
                title: Text('title'),
                trailing: Text('hi'),
              ),
              Container(
                color: Colors.yellow,
                child: Text('data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
