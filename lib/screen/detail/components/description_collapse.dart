import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';

class CollapseDescription extends StatefulWidget {
  final Function callbackFunction;
  const CollapseDescription({
    Key? key,
    required this.text,
    required this.callbackFunction,
  }) : super(key: key);

  final String text;

  @override
  State<CollapseDescription> createState() => _CollapseDescriptionState();
}

bool showAll = false;

class _CollapseDescriptionState extends State<CollapseDescription> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get Apple TV+ free for a year',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          !showAll ? '${widget.text.substring(0, 70)}...' : widget.text,
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        GestureDetector(
          onTap: () {
            setState(() {
              showAll = !showAll;
            });
            widget.callbackFunction();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                !showAll ? 'Full description' : 'Show less',
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: kPrimary,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Icon(
                !showAll ? Icons.arrow_forward : null,
                size: 18,
                color: kPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
