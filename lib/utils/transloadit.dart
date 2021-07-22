import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transloadit/transloadit.dart';
import 'package:transloadit_recipes/defs/food.dart';
import 'package:transloadit_recipes/defs/response.dart';

import '../main.dart';
import 'food_list.dart';

class Transloadit {
  static Future<File> _imageToFile(
      {required String path, required String name}) async {
    var bytes = await rootBundle.load(path);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$name.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  static Future<void> sendToTransloadit({
    required List<Food> foodList,
    required Function() onCompleteUpload,
  }) async {
    isLoading.value = true;
    FoodList.foodList.forEach(
      (food) async {
        TransloaditAssembly assembly = client.newAssembly(
          params: {
            'notify_url':
                'https://us-central1-transloadit-recipes.cloudfunctions.net/receivePOST?name=${food.title}&token=$token',
          },
        );
        assembly.addFile(
          file: await _imageToFile(
            path: food.image,
            name: food.title,
          ),
        );
        assembly.addStep(
          food.title,
          food.subtitle,
          Map<String, dynamic>.from(food.ingredients),
        );

        Future<TransloaditResponse> future = assembly.createAssembly(
          onComplete: onCompleteUpload,
        );
        TransloaditResponse response = await future;
        results.value = List.from(results.value)
          ..add(Response(response: response.data, name: food.title));
      },
    );
  }
}
