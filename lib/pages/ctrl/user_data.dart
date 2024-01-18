import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sekar_fb/model/users.dart';

final inputNama = TextEditingController();
final inputHarga = TextEditingController();

final editNama = TextEditingController();
final editHarga = TextEditingController();

var isLoading = false;
var showClearNama = false;
var showClearHarga = false;
var scNama = false;
var scHarga = false;

var selectedId = '';

List<Product> produkList = [];

var isEnd = false;

XFile? pickedImage;
XFile? pickedImageUpload;
XFile? pickedImageUpdate;

Product? productDetail;

var imageUrl = '';
