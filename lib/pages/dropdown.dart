import 'package:TestLaTech/models/cart_model.dart';
import 'package:TestLaTech/models/categorie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDropdownOptions extends StatefulWidget {
  final Categories myArgument; // Define the argument you want to pass

  // Constructor to receive the argument
  MyDropdownOptions({required this.myArgument});
  @override
  _MyDropdownOptionsState createState() => _MyDropdownOptionsState(myArgument);
}

class _MyDropdownOptionsState extends State<MyDropdownOptions> {
  final Categories myArgument; // Argument received from the widget

  // Constructor to receive the argument
  _MyDropdownOptionsState(this.myArgument);

  List<String> options = [];
  Map<String, List<Product>> products = {}; // Corrected variable name

  String selectedOption = 'Foods'; // Default selected option

  @override
  void initState() {
    super.initState();
    // Initialization logic goes here
    for (Category title in myArgument.categories) {
      print(title.title);
      options.add(title.title);
      products[title.title] = title.products; // Corrected variable name
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Changed from Center to Column
      children: [
        Container(
          padding: EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: options.map((option) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOption = option;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: option == selectedOption
                            ? Color(0xfffa4a0c)
                            : Colors.transparent,
                        width:
                            2.0, // Adjust the space between text and underline
                      ),
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontFamily: 'SF-Pro-Rounded-Regular',
                      fontSize: 16.0,
                      color:
                          option == selectedOption ? Color(0xfffa4a0c) : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        _dietSection(context, products), // Corrected variable name
      ],
    );
  }

  Column _dietSection(context, Map<String, List<Product>> map) {
    // Corrected variable name
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 240,
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      map[selectedOption]![index].photo,
                      width: 100, // Set your desired width
                      height: 100, // Set your desired height
                      fit: BoxFit
                          .cover, // Adjust the fit based on your layout requirements
                    ),
                    // Corrected variable name
                    Column(
                      children: [
                        Text(
                          map[selectedOption]![index]
                              .name, // Corrected variable name
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        Text(
                          map[selectedOption]![index].price.toStringAsFixed(3) +
                              "DT", // Corrected variable name
                          style: const TextStyle(
                              color: Color(0xfffa4a0c),
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),

                    // Corrected variable name
                    Center(
                      // Corrected variable name
                      child: Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Color(0xfffa4a0c),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<CartModel>(context, listen: false)
                                    .removeItemFromCart(
                                        map[selectedOption]![index]);
                                setState(() {
                                  if (map[selectedOption]![index].count > 0) {
                                    map[selectedOption]![index].count--;
                                  }
                                });
                                print("Add icon clicked");
                              },
                              child: Icon(Icons.remove, color: Colors.white),
                            ),
                            Text(
                              '${map[selectedOption]![index].count}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<CartModel>(context, listen: false)
                                    .addItemToCart(map[selectedOption]![index]);
                                setState(() {
                                  map[selectedOption]![index].count++;
                                });
                                print("Add icon clicked");
                              },
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 30,
            ),
            itemCount:
                map[selectedOption]?.length ?? 0, // Corrected variable name
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20, right: 20),
          ),
        ),
      ],
    );
  }
}
