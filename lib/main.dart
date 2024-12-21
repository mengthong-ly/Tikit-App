import 'package:event_with_thong/models/classification.dart';
import 'package:event_with_thong/models/gender.dart';
import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/option_type.dart';
import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/models/payment.dart';
import 'package:event_with_thong/models/payment_type.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/models/stock.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/models/user_role_model.dart';
import 'package:event_with_thong/models/vendor.dart';
import 'package:event_with_thong/view/operator/operator_provider.dart';
import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:event_with_thong/viewModels/cart_provider.dart';
import 'package:event_with_thong/viewModels/classification_provider.dart';
import 'package:event_with_thong/viewModels/order_provider.dart';
import 'package:event_with_thong/viewModels/payment_provider.dart';
import 'package:event_with_thong/viewModels/product_provider.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:event_with_thong/viewModels/stock_provider.dart';
import 'package:event_with_thong/viewModels/taxon_provider.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/tikit_app.dart';
import 'package:event_with_thong/viewModels/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await laodGlobalData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => OperatorProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductVariantProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ClassificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TaxonModelProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthenticationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => StockProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => VendorProvider(),
        ),
      ],
      child: const TikitApp(),
      // child: const SignUpPage(),
    ),
  );
}

Future<void> laodGlobalData() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(GenderAdapter());
  Hive.registerAdapter(UserRoleModelAdapter());
  Hive.registerAdapter(OptionTypeModelAdapter());
  Hive.registerAdapter(ProductTaxonModelAdapter());
  Hive.registerAdapter(LineItemModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.registerAdapter(PaymentTypeModelAdapter());
  Hive.registerAdapter(PaymentModelAdapter());
  Hive.registerAdapter(ProductVariantModelAdapter());
  Hive.registerAdapter(StockModelAdapter());
  Hive.registerAdapter(TaxonModelAdapter());
  Hive.registerAdapter(VendorModelAdapter());

  var roles = await Hive.openBox('roles');
  if (roles.isOpen) {
    await roles.put('user', UserRoleModel.user);
    await roles.put('admin', UserRoleModel.admin);
    await roles.put('vendor', UserRoleModel.vendor);
  }

  var gender = await Hive.openBox('genders');
  if (gender.isOpen) {
    await gender.put('male', Gender.male);
    await gender.put('female', Gender.female);
    await gender.put('other', Gender.other);
  }
}
