import 'package:arobisca_online_store_app/utility/utility_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cart/flutter_cart.dart';
import '../../../../core/data/data_provider.dart';
import '../../../../models/product.dart';
import '../../../../utility/snack_bar_helper.dart';


class ProductDetailProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailProvider(this._dataProvider);

  void addToCart(Product product) {
    double? price = 5000;
    flutterCart.addToCart(
      cartModel: CartModel(
          productId: '${product.sId}',
          productName: '${product.name}',
          productImages: ['${product.images?.safeElementAt(0)?.url}'],
          variants: [ProductVariant(price: price ?? 0, color: selectedVariant)],
          productDetails: '${product.description}'),
    );
    selectedVariant = null;
    SnackBarHelper.showSuccessSnackBar('Item Added');
    notifyListeners();
  }


  //? to update UI
  void updateUI() {
    notifyListeners();
  }
}
