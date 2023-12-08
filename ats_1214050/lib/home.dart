import 'package:flutter/material.dart';

class MyInput extends StatefulWidget {
  const MyInput({super.key});
  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widget'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              const Text("ASESMEN AKHIR SEMESTER",
                  style: TextStyle(
                    fontSize: 16.0, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  )),
              const Text("PEMROGRAMAN IV",
                  style: TextStyle(
                    fontSize: 16.0, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 20.0),
              Center(child: Image.asset('images/ulbi.png')),
              const SizedBox(height: 40.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 2.0, // Border width
                            ),
                            borderRadius:
                                BorderRadius.circular(20.0), // Border radius
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              'images/dani.jpeg',
                              fit: BoxFit
                                  .cover, // You can adjust the BoxFit as needed
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama  : Dani Ferdinan",
                            style: TextStyle(
                              fontSize: 16.0, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "NPM   : 1214050",
                            style: TextStyle(
                              fontSize: 16.0, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Kelas : 3B D4-TI",
                            style: TextStyle(
                              fontSize: 16.0, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
