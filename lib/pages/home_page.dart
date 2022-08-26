import 'package:card_hive/pages/detail_page.dart';
import 'package:card_hive/service/db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
import '../view/make_cards.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cards> cards = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fillCards;
  }

  void get fillCards async {
    cards = await DBService.getData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Good Morning,",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                )),
            Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Eugene",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ))
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: Colors.black87,
              radius: 22,
              child: Image(image: AssetImage("assets/images/img2.png")),
            ),
          ),
        ],
      ),
      body: ListView(
        children: List.generate(
          cards.length,
          (index) => MakeCards(
            card: cards[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Cards? card = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => DetailPage(),
            ),
          );
          print('card: ${card?.toJson().toString()}');
          if (card != null) {
            cards.add(card);
            await DBService.setData(cards);
            setState(() {});
          }
        },
        child: const Icon(Icons.add, size: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(
            () {
              currentIndex = i;
            },
          );
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bubble_left), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.menu, size: 30), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_vert, size: 30), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}
