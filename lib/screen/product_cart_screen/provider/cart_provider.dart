import 'dart:developer';
import 'package:arobisca_online_store_app/screen/authentication/success_screens/success_screen.dart';
import 'package:arobisca_online_store_app/screen/home_screen.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/m-pesa/m_pesa.dart';
import 'package:arobisca_online_store_app/utility/common/image_strings.dart';
import 'package:arobisca_online_store_app/utility/utility_extension.dart';
import 'package:get/get.dart';
import '../../../models/coupon.dart';
import '../../authentication/login_screen/provider/user_provider.dart';
import '../../../services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/api_response.dart';
import '../../../utility/constants.dart';
import '../../../utility/snack_bar_helper.dart';

class CartProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final box = GetStorage();
  final UserProvider _userProvider;
  var flutterCart = FlutterCart();
  List<CartModel> myCartItems = [];

  final GlobalKey<FormState> buyNowFormKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  bool isExpanded = false;

  Coupon? couponApplied;
  double couponCodeDiscount = 0;
  String selectedPaymentOption = 'Prepaid - Lipa na M-pesa';

  CartProvider(this._userProvider);

  getCartItems() {
    myCartItems = flutterCart.cartItemsList;
    notifyListeners();
  }

  void updateCart(CartModel cartItem, int quantity) {
    quantity = cartItem.quantity + quantity;
    flutterCart.updateQuantity(cartItem.productId, cartItem.variants, quantity);
    notifyListeners();
  }

  double getCartSubTotal() {
    return flutterCart.subtotal;
  }

  clearCartItems() {
    flutterCart.clearCart();
    notifyListeners();
  }

  double getGrandTotal() {
    return getCartSubTotal() - couponCodeDiscount;
  }

//---------------- Check If Coupon is valid
  checkCoupon() async {
    try {
      if (couponController.text.isEmpty) {
        SnackBarHelper.showErrorSnackBar('Enter a coupon code');
        return;
      }
      List<String> productIds =
          myCartItems.map((cartItem) => cartItem.productId).toList();
      Map<String, dynamic> couponData = {
        "couponCode": couponController.text,
        "purchaseAmount": getCartSubTotal(),
        "productIds": productIds
      };
      final response = await service.addItem(
          endpointUrl: 'couponCodes/check-coupon', itemData: couponData);
      if (response.isOk) {
        final ApiResponse<Coupon> apiResponse = ApiResponse<Coupon>.fromJson(
            response.body,
            (json) => Coupon.fromJson(json as Map<String, dynamic>));
        if (apiResponse.success == true) {
          Coupon? coupon = apiResponse.data;
          if (coupon != null) {
            couponApplied = coupon;
            couponCodeDiscount = getCouponDiscountAmount(coupon);
          }
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Coupon is valid');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to validate Coupon: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
      notifyListeners();
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

//-------------------- Get Coupon Discount Amount
  double getCouponDiscountAmount(Coupon coupon) {
    double discountAmount = 0;
    String discountType = coupon.discountType ?? 'fixed';
    if (discountType == 'fixed') {
      discountAmount = coupon.discountAmount ?? 0;
      return discountAmount;
    } else {
      double discountPercentage = coupon.discountAmount ?? 0;
      double amountAfterDiscountPercentage =
          getCartSubTotal() * (discountPercentage / 100);
      return amountAfterDiscountPercentage;
    }
  }

//---------- Add a new order
  addOrder(BuildContext context) async {
    try {
      Map<String, dynamic> order = {
        "userID": _userProvider.getLoginUsr()?.sId ?? '',
        "orderStatus": "pending",
        "items": cartItemToOrderItem(myCartItems),
        "totalPrice": getCartSubTotal(),
        "shippingAddress": {
          "phone": phoneController.text,
          "street": streetController.text,
          "city": cityController.text,
          "state": streetController.text,
          "postalCode": postalCodeController.text,
          "country": countryController.text
        },
        "paymentMethod": selectedPaymentOption,
        "couponCode": couponApplied?.sId,
        "orderTotal": {
          "subtotal": getCartSubTotal(),
          "discount": couponCodeDiscount,
          "total": getGrandTotal()
        },
      };
      // print('Logged in user info: ${_userProvider.getLoginUsr()?.email ?? ""}');
      final response =
          await service.addItem(endpointUrl: 'orders', itemData: order);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Order added');
          clearCouponDiscount();
          clearCartItems();
          Get.to(
              () => SuccessScreen(
                    image: TImages.onSucesss,
                    title: 'Order Placed Successfully',
                    showLoginText: false,
                    subtitle:
                        'You can track Your order under "My Orders" Tab in the profile screen. \n Thank you for shopping with Arobisca',
                    onPressed: () {
                      Get.to(() => const HomeScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 800));
                    },
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 800));
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add Order: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

//------ Cart Item to Order
  List<Map<String, dynamic>> cartItemToOrderItem(List<CartModel> cartItems) {
    return cartItems.map((cartItem) {
      return {
        "productID": cartItem.productId,
        "productName": cartItem.productName,
        "quantity": cartItem.quantity,
        "price": cartItem.variants.safeElementAt(0)?.price ?? 0,
        "variant": cartItem.variants.safeElementAt(0)?.color ?? "",
      };
    }).toList();
  }

//------ Submit Order
  submitOrder(BuildContext context) async {
    if (selectedPaymentOption == 'Cash On Delivery') {
      addOrder(context);
    } else {
      Get.to(
          () => MPesa(
                orderDetails: getOrderDetails(), // Pass order details
              ),
          transition: Transition.zoom,
          duration: const Duration(milliseconds: 400));
    }
  }

//------ Get Order Details for M-pesa Initialization
  Map<String, dynamic> getOrderDetails() {
    return {
      "userID": _userProvider.getLoginUsr()?.sId ?? '',
      "orderStatus": "pending",
      "items": cartItemToOrderItem(myCartItems),
      "totalPrice": getCartSubTotal(),
      "shippingAddress": {
        "phone": phoneController.text,
        "street": streetController.text,
        "city": cityController.text,
        "state": streetController.text,
        "postalCode": postalCodeController.text,
        "country": countryController.text
      },
      "paymentMethod": selectedPaymentOption,
      "couponCode": couponApplied?.sId,
      "orderTotal": {
        "subtotal": getCartSubTotal(),
        "discount": couponCodeDiscount,
        "total": getGrandTotal()
      },
    };
  }

//----- Initiate M-pesa Transaction
  Future<void> initiateMpesaTransaction(BuildContext context,
      Map<String, dynamic> orderDetails, String phone) async {
    try {
      final response = await service.addItem(
        endpointUrl: 'mpesa/stk',
        itemData: {'phone': phone, 'amount': getCartSubTotal()},
      );

      if (response.isOk) {
        // ignore: use_build_context_synchronously
        await addMpesaOrder(context, orderDetails);
      } else {
        SnackBarHelper.showErrorSnackBar(
            'MPesa payment failed: ${response.body['message']}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
    }
  }

  Future<void> addMpesaOrder(
      BuildContext context, Map<String, dynamic> orderDetails) async {
    try {
      final response =
          await service.addItem(endpointUrl: 'orders', itemData: orderDetails);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Order added');
          clearCouponDiscount();
          clearCartItems();
          Get.to(
              () => SuccessScreen(
                    image: TImages.onSucesss,
                    title: 'Order Placed Successfully',
                    showLoginText: false,
                    subtitle:
                        'You can track Your order under "My Orders" Tab in the profile screen. \n Thank you for shopping with Arobisca',
                    onPressed: () {
                      Get.to(() => const HomeScreen(),
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 800));
                    },
                  ),
              transition: Transition.fade,
              duration: const Duration(milliseconds: 800));
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add Order: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  //? to clear the coupon code and applauded price when bottom sheet is clossed
  clearCouponDiscount() {
    couponApplied = null;
    couponCodeDiscount = 0;
    couponController.text = '';
    notifyListeners();
  }

  //? for auto fill saved address initially in address form
  void retrieveSavedAddress() {
    phoneController.text = box.read(PHONE_KEY) ?? '';
    streetController.text = box.read(STREET_KEY) ?? '';
    cityController.text = box.read(CITY_KEY) ?? '';
    stateController.text = box.read(STATE_KEY) ?? '';
    postalCodeController.text = box.read(POSTAL_CODE_KEY) ?? '';
    countryController.text = box.read(COUNTRY_KEY) ?? '';
  }

  //? to update UI
  void updateUI() {
    notifyListeners();
  }
}
