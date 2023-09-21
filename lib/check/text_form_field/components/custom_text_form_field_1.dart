import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      spreadRadius: 6,
                      offset: const Offset(0, 3),
                      color: Colors.black.withOpacity(0.03),
                    )
                  ]),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "search food ...",
                      hintStyle:
                          TextStyle(color: Colors.black.withOpacity(0.5)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton(onPressed: () {}, child: const Text("Submit")),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
