import 'package:flutter/material.dart';

class Facebook extends StatelessWidget {
  const Facebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1629197521865-4946b4acd2b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF2eSUyMGJsdWV8ZW58MHx8MHx8&w=1000&q=80',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.26),
              const Text("Coming soon...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
