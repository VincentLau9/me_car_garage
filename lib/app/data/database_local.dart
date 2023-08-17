import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseLocal {
  DatabaseLocal._privateConstructor();

  static final DatabaseLocal _instance = DatabaseLocal._privateConstructor();

  static DatabaseLocal get instance => _instance;

  Future<void> saveRefeshToken(String refeshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("GR-refeshToken", refeshToken);
  }


  Future<String?> getRefeshToken() async {
    await Future.delayed(Duration(seconds: 3));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('GR-refeshToken');
  }

  Future<void> setJwtToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('GR-accessToken', accessToken);
  }

  Future<void> removeJwtToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('GR-accessToken');
    await prefs.remove('GR-refeshToken');
  }
}
