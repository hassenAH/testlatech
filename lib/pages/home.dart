import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:TestLaTech/models/cart_model.dart';
import 'package:TestLaTech/models/categorie.dart';

import 'package:TestLaTech/pages/cart.dart';
import 'package:TestLaTech/pages/dropdown.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Categories cat;

  @override
  void initState() {
    super.initState();
    _getInitialInfo();
  }

  Future<void> _getInitialInfo() async {
    Categories categories =
        await readCategoriesFromJsonFile('assets/data/data.json');
    setState(() {
      cat = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20,
          ),
          child: appBar(context),
        ),
      ),
      backgroundColor: const Color(0xfffbfbfb),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 40, top: 40),
            child: Text(
              'Delicious\nfood for you',
              style: TextStyle(
                fontFamily: "SF Pro Rounded",
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _searchField(),
          const SizedBox(
            height: 40,
          ),
          MyDropdownOptions(myArgument: cat),
          const SizedBox(
            height: 40,
          ),
          // Add other widgets as needed
        ],
      ),
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 40, right: 40),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xffefeeee).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Color(0xff787777),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset('assets/icons/Search.svg'),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  AppBar appBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: Container(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/menu.svg',
              height: 30, // Adjust the height as needed
              width: 30, // Adjust the width as needed
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CartPage();
                  },
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/card.svg',
                height: 30,
                width: 30,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
