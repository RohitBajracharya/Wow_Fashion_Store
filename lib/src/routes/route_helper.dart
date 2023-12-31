import 'package:admin_side/src/data/view/auth/login_screen.dart';
import 'package:admin_side/src/data/view/features/categories/add_categories_screen.dart';
import 'package:admin_side/src/data/view/features/categories/categories_screen.dart';
import 'package:admin_side/src/data/view/features/categories/edit_categories_screen.dart';
import 'package:admin_side/src/data/view/features/customers/customer_screen.dart';
import 'package:admin_side/src/data/view/features/homeNsplash/home_screen.dart';
import 'package:admin_side/src/data/view/features/homeNsplash/splash_screen.dart';
import 'package:admin_side/src/data/view/features/orders/order_screen.dart';
import 'package:admin_side/src/data/view/features/products/add_product_screen.dart';
import 'package:admin_side/src/data/view/features/products/edit_product_screen.dart';
import 'package:admin_side/src/data/view/features/products/product_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String loginPage = "/login-page";
  static const String homePage = "/home-page";
  //categories page
  static const String categoriesPage = "/categories-page";
  static const String addCategoriesPage = "/add-categories-page";
  static const String editCategoriesPage = "/edit-categories-page";
  //product page
  static const String productPage = "/product-page";
  static const String addProductPage = "/add-product-page";
  static const String editProductPage = "/edit-product-page";
  //order page
  static const String orderPage = "/order-page";
  //customer page
  static const String customerPage = "/customer-page";

  static String getInitial() => initial;
  static String getLoginPage() => loginPage;
  static String getHomePage() => homePage;
  //category page
  static String getCategoriesPage() => categoriesPage;
  static String getAddCategoriesPage() => addCategoriesPage;
  static String getEditCategoriesPage() => editCategoriesPage;
  //product page
  static String getProductPage() => productPage;
  static String getAddProductPage() => addProductPage;
  static String getEditProductPage() => editProductPage;
  //order page
  static String getOrderPage() => orderPage;
  //customer page
  static String getCustomerPage() => customerPage;

  static List<GetPage> routes = [
    //splash screen
    GetPage(name: initial, page: () => const SplashScreen()),
    //login screen
    GetPage(name: loginPage, page: () => const LoginScreen()),
    //home screen
    GetPage(name: homePage, page: () => const HomeScreen()),
    //category section
    //categories screen
    GetPage(name: categoriesPage, page: () => const CategoriesScreen()),
    //add category screen
    GetPage(name: addCategoriesPage, page: () => const AddCategoriesScreen()),
    //edit category screen
    GetPage(name: editCategoriesPage, page: () => const EditCategoriesScreen()),
    //product section
    //product screen
    GetPage(name: productPage, page: () => const ProductScreen()),
    //add product screen
    GetPage(name: addProductPage, page: () => const AddProductScreen()),
    //edit product screen
    GetPage(name: editProductPage, page: () => const EditProductScreen()),
    //order section
    //order screen
    GetPage(name: orderPage, page: () => const OrderScreen()),
    //customer section
    //customer screen
    GetPage(name: customerPage, page: () => const CustomerScreen()),
  ];
}
