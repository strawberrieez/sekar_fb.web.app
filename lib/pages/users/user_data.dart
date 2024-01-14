import 'package:flutter/material.dart';
import 'package:sekar_fb/model/users.dart';

final ctrlNama = TextEditingController();
final ctrlHarga = TextEditingController();

var isLoading = false;
var showClearNama = false;
var showClearHarga = false;

var selectedId = '';

List<UserX> userList = [];

var isEnd = false;
