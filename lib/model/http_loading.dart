import 'package:flutter/cupertino.dart';

class HttpLoadingModel extends ChangeNotifier {

  var loadingData = {
  };

  getOne(path) {
    return loadingData[path] ?? false;
  }
  setCurrent(path, data) {
    loadingData[path] = data;
    notifyListeners();
  }

}
