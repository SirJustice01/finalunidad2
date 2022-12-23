import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_login/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseurl = 'flutter-varios-3da55-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  File? newPictureFile;

  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    //Pasero del URL para consumir el api
    final url = Uri.https(_baseurl, 'products.json');
    final resp = await http.get(url);
    //decodificar el URL para convertirlo en mapa
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    //Una vez teniendo el mapa lo convertiremos a lista para usarlo de mejor manera con el forEach
    productsMap.forEach((key, value) {
      final tempProdcut = Product.fromMap(value);
      tempProdcut.id = key;
      products.add(tempProdcut);
    });
    //Una vez que pase toda la verificacion ponemos el loading en false, para cargar los productos
    isLoading = false;
    notifyListeners();

    return products;
  }

  Future saveOrCreateProducts(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //es necesario crear
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseurl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());

    final decodedData = resp.body;

    final index = products.indexWhere((element) => element.id == product.id);

    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseurl, 'products.json');
    final resp = await http.post(url, body: product.toJson());

    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    products.add(product);

    return product.id!;
  }

  void updateSelectedImage(String path) {
    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    isSaving = true;
    notifyListeners();
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/ddntutcjv/image/upload?upload_preset=eh1s7bks');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo asi mal pipipi');
      return null;
    }

    newPictureFile = null;

    final decodeData = json.decode(resp.body);

    return decodeData['secure_url'];
  }
}
