import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';

class CategoryBuilder extends StatefulWidget {
  const CategoryBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  List<String> category = ["Wearable", "Laptops", "Phones", "Drones"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: size.width * 0.08),
      height: size.height * 0.05,
      child: ListView.builder(
        itemCount: category.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _categorynaigator(index);
        },
      ),
    );
  }

  Padding _categorynaigator(int index) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category[index],
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                color: selectedIndex == index ? kPrimary : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 2,
              width: size.width * 0.15,
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedIndex == index ? kPrimary : Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
