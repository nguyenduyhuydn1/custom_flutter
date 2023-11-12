import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late final TextEditingController _textEditingController =
      TextEditingController();
  final List mess = ["1"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Flexible(
              flex: 6,
              child: ListView.builder(
                itemCount: mess.length,
                itemBuilder: (context, index) {
                  return _ReceiverMessage(mess: mess[index]);
                },
              ),
            ),
            Container(
              height: 100,
              color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: size.width - 100,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: _textEditingController,
                      autofocus: false,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
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
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: RawMaterialButton(
                      fillColor: Colors.red,
                      shape: const CircleBorder(),
                      elevation: 0,
                      onPressed: () {
                        setState(() {
                          mess.add(_textEditingController.text);
                        });
                      },
                      child: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiverMessage extends StatelessWidget {
  const _ReceiverMessage({
    required this.mess,
  });

  final String mess;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topLeft,
      widthFactor: 0.75,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  position: DecorationPosition.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 12.0),
                    child: Text(
                      mess,
                      softWrap: true,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12.0, left: 12.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('12:12:12'),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: 30,
                height: 30,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
