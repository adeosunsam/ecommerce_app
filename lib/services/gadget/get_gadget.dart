import 'dart:async';
import 'dart:io';

import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/services/authservice/genericHttpRequest/httprequesthandler.dart';
import 'package:ecommerce_store/utility/exception.dart';

class GadgetService {
  List<Product> _products = [];
  static final _shared = GadgetService._sharedInstance();
  GadgetService._sharedInstance() {
    _gadgetStreamController = StreamController<List<Product>>.broadcast(
        onListen: () => _gadgetStreamController.sink.add(_products));
  }

  factory GadgetService() => _shared;

  late final StreamController<List<Product>> _gadgetStreamController;
  Stream<List<Product>> get allGadget => _gadgetStreamController.stream;

  Future<List<String>> categories() async {
    var getProduct = await getGadgets().then((value) => value.data);
    return getProduct.map((e) => e.category).toList();
  }

  Future cacheGadget() async {
    var getProduct = await getGadgets().then((value) => value.data);
    _products = getProduct;
  }

  Future<GadgetData> getGadgets() async {
    try {
      final jsonData = await apiRequest(
        '/Gadget/all-product',
        RequestMethod.get,
      );
      var gadgets = gadgetDataFromJson(jsonData);
      _gadgetStreamController.add(gadgets.data);
      return gadgets;
    } on SocketException catch (_) {
      throw BadOrNoNetworkException();
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
