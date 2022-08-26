import 'package:card_hive/utils/const_keys.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBService {

  static Future<void> get init async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
  }

  ///cartalarni db ga saqlash
  static Future<void> setData(List<Cards> cards) async {
    List<Map<String, dynamic>> list = cards.map((card) => card.toJson()).toList();//datani json ga otkazish, dastur tuhsunmaganligi uchun
    Box box = await Hive.openBox(ConstKeys.db);// dasturga db ornatish uchun
    await box.put(ConstKeys.cards, list);// dasturdagi db ga malumot joylash
  }

  /// cartalarni db dan oqib beradi
  static Future<List<Cards>> get getData async {
    Box box = await Hive.openBox(ConstKeys.db);
    List<dynamic>? noParsedCards = await box.get(ConstKeys.cards);
    List<Map<String, dynamic>> json = [];
    if (noParsedCards == null) return [];
    for (var card in noParsedCards) {
      json.add(Map.from(card));
    }
    return json.map((e) => Cards.fromJson(e)).toList();
  }
}






