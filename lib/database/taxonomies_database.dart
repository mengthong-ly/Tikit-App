import 'package:hive/hive.dart';
import 'package:logger/web.dart';
import 'package:flutter/cupertino.dart';
import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/models/vendor.dart';
import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/models/user_role_model.dart';
import 'package:event_with_thong/view/pages/setting_item.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/models/classification.dart';
import 'package:event_with_thong/models/option_type.dart';
import 'package:event_with_thong/models/payment.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/stock.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/models/user.dart';
import 'package:event_with_thong/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<SettingItem> otherSettings = [
  const SettingItem(iconData: Icons.feedback, label: 'Feedback'),
  const SettingItem(iconData: Icons.info_outline, label: 'About Us'),
  const SettingItem(
      iconData: Icons.travel_explore_sharp, label: 'Term & Conditions'),
];
final List<SettingItem> genralSettings = [
  SettingItem(
    iconData: Icons.translate,
    label: 'Theme',
    trailing: Consumer<ThemeProvider>(
      builder: (context, value, child) => CupertinoSwitch(
        value: context.watch<ThemeProvider>().theme == TAppTheme.lightTheme,
        onChanged: (value) {
          context.read<ThemeProvider>().triggerTheme();
        },
      ),
    ),
  ),
  const SettingItem(
    iconData: Icons.notifications_outlined,
    label: 'Notification',
  ),
  const SettingItem(iconData: Icons.favorite_outline, label: 'WishList'),
  const SettingItem(iconData: Icons.translate, label: 'Coupons'),
];

class TaxonDatabase {
  TaxonDatabase._privateConstructor();
  static final TaxonDatabase _instance = TaxonDatabase._privateConstructor();
  static TaxonDatabase get instance => _instance;

  List<TaxonModel> taxons = [
    TaxonModel(
      id: '1',
      name: 'The Voice Cambodia',
      slug: 'the-voice-cambodia',
      description: 'Live performace',
      vendorId: '1',
      image: 'assets/background/thevoice_background.jpg',
    ),
    TaxonModel(
      id: '2',
      name: 'Bun Phum',
      slug: 'Bun Phum',
      description: 'Relaxing music performances in a cozy setting.',
      vendorId: '2',
      image: 'assets/background/bunphum_background.png',
    ),
    TaxonModel(
      id: '3',
      name: 'Cambodia Got Talent',
      slug: 'Cambodia Got Talent',
      description: 'A celebration of delicious food from various cuisines.',
      vendorId: '3',
      image: 'assets/background/gottalent_background.jpg',
    ),
    TaxonModel(
      id: '4',
      name: 'The Reach Solo Concert',
      slug: 'The Reach Solo Concert',
      description: 'An event gathering tech enthusiasts and professionals.',
      vendorId: '4',
      image: 'assets/background/reach_background.jpg',
    ),
    TaxonModel(
      id: '5',
      name: 'Innex Expo',
      slug: 'Innex',
      description: 'An intense competition in various sports.',
      vendorId: '5',
      image: 'assets/background/innex_background.png',
    ),
    TaxonModel(
      id: '6',
      name: 'Book Fair',
      slug: 'book-fair',
      description: 'A gathering for book lovers and authors.',
      vendorId: '6',
      image: 'assets/background/bookfair_background.jpg',
    ),
    TaxonModel(
      id: '7',
      name: 'TEDx Talks',
      slug: 'tedx-talks',
      description: 'Inspiring talks by industry leaders and changemakers.',
      vendorId: '7',
      image: 'assets/background/tedx_background.jpg',
    ),
    TaxonModel(
      id: '8',
      name: 'Football League',
      slug: 'football-league',
      description: 'An exciting football tournament featuring top teams.',
      vendorId: '8',
      image: 'assets/background/football_background.jpg',
    ),
    TaxonModel(
      id: '9',
      name: 'Volleyball Tournament',
      slug: 'volleyball-tournament',
      description: 'A thrilling volleyball competition for sports enthusiasts.',
      vendorId: '9',
      image: 'assets/background/volleyball_background.jpg',
    ),
    TaxonModel(
      id: '10',
      name: 'Gumball Rally',
      slug: 'gumball-rally',
      description: 'A fun and adventurous car rally experience.',
      vendorId: '10',
      image: 'assets/background/gumbaleBackground.png',
    ),
    TaxonModel(
      id: '11',
      name: 'CADT Tech Expo',
      slug: 'cadt-tech-expo',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/cadt_background.jpg',
    ),
    TaxonModel(
      id: '12',
      name: 'MSC',
      slug: 'msc',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/msc_background.jpeg',
    ),
    TaxonModel(
      id: '13',
      name: 'Rodwell',
      slug: 'rodwell',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/rodwell_background.png',
    ),
    TaxonModel(
      id: '14',
      name: 'Innovation Tech WorkShop',
      slug: 'Innovation Tech WorkShop',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/inno_background.jpg',
    ),
    TaxonModel(
      id: '15',
      name: 'Run With Sai',
      slug: 'Run With Sai',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/runwithsai_background.jpg',
    ),
    TaxonModel(
      id: '16',
      name: 'M6',
      slug: 'M6',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/m5_background.jpg',
    ),
    TaxonModel(
      id: '17',
      name: 'M5',
      slug: 'M5',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/theq_background.jpg',
    ),
    TaxonModel(
      id: '18',
      name: 'Sator Cambodia',
      slug: 'Sator Cambodia',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/sator_background.jpg',
    ),
    TaxonModel(
      id: '19',
      name: 'The Q',
      slug: 'The Q',
      description: 'Showcasing innovative tech projects and startups.',
      vendorId: '11',
      image: 'assets/background/theq_background.jpg',
    ),
  ];
}

class VendorDatabase {
  VendorDatabase._privateInstance();
  static final VendorDatabase _instance = VendorDatabase._privateInstance();
  static VendorDatabase get instance => _instance;
  List<VendorModel> vendors = [
    VendorModel(
      id: "1",
      name: "Hang Meas",
      email: "hangmeas@example.com",
      contact: "+1 555-1234",
      address: "123 Silicon Valley, CA, USA",
      profile: 'assets/vendor/hangmeas.jpg',
    ),
    VendorModel(
      id: "2",
      name: "Rodwell",
      email: "rodwell@example.com",
      contact: "+1 555-5678",
      address: "456 Innovation Street, NY, USA",
      profile: 'assets/vendor/rodwell.jpg',
    ),
    VendorModel(
      id: "3",
      name: "Runwithsai",
      email: "runwithsai@example.com",
      contact: "+1 555-8765",
      address: "789 Startup Blvd, SF, USA",
      profile: 'assets/vendor/runwithsai.jpg',
    ),
    VendorModel(
      id: "4",
      name: "CADT",
      email: "cadt@example.com",
      contact: "+1 555-4321",
      address: "101 Tech Park, Phnom Penh, Cambodia",
      profile: 'assets/vendor/cadt.jpg',
    ),
    VendorModel(
      id: "5",
      name: "TedX",
      email: "tedx@example.com",
      contact: "+1 555-0000",
      address: "12 Conference Road, Austin, TX, USA",
      profile: 'assets/vendor/tedx.png',
    ),
    VendorModel(
      id: "6",
      name: "RYL",
      email: "ryl@example.com",
      contact: "+1 555-0000",
      address: "15 Creative Street, Los Angeles, CA, USA",
      profile: 'assets/vendor/ryl.png',
    ),
    VendorModel(
      id: "7",
      name: "Innex",
      email: "innex@example.com",
      contact: "+1 555-0000",
      address: "22 Industrial Avenue, Dallas, TX, USA",
      profile: 'assets/vendor/innex.jpg',
    ),
    VendorModel(
      id: "8",
      name: "BookFair",
      email: "bookfair@example.com",
      contact: "+1 555-0000",
      address: "500 Literature Lane, Boston, MA, USA",
      profile: 'assets/vendor/bookfair.jpg',
    ),
    VendorModel(
      id: "9",
      name: "Volleyball Federation",
      email: "volleyball@example.com",
      contact: "+1 555-0000",
      address: "300 Sports Complex, Denver, CO, USA",
      profile: 'assets/vendor/volleyball.jpg',
    ),
    VendorModel(
      id: "10",
      name: "M6",
      email: "m6@example.com",
      contact: "+1 555-0000",
      address: "77 Event Hall Drive, Chicago, IL, USA",
      profile: 'assets/vendor/m6.jpg',
    ),
    VendorModel(
      id: "11",
      name: "SatorCambodia",
      email: "satorcambodia@example.com",
      contact: "+1 555-0000",
      address: "88 Business Park, Phnom Penh, Cambodia",
      profile: 'assets/vendor/satorcambodia.jpg',
    ),
    VendorModel(
      id: "12",
      name: "M5",
      email: "m5@example.com",
      contact: "+1 555-0000",
      address: "99 Tech Lane, San Jose, CA, USA",
      profile: 'assets/vendor/m5.jpg',
    ),
    VendorModel(
      id: "13",
      name: "MSC",
      email: "msc@example.com",
      contact: "+1 555-0000",
      address: "55 Campus Road, Cambridge, MA, USA",
      profile: 'assets/vendor/msc.jpg',
    ),
    VendorModel(
      id: "14",
      name: "Bun Phum",
      email: "bunphum@example.com",
      contact: "+1 555-0000",
      address: "60 Market Street, Bangkok, Thailand",
      profile: 'assets/vendor/bunphum.jpg',
    ),
    VendorModel(
      id: "15",
      name: "Gumble",
      email: "gumble@example.com",
      contact: "+1 555-0000",
      address: "70 Animation Road, Tokyo, Japan",
      profile: 'assets/vendor/gumball.jpg',
    ),
    VendorModel(
      id: "16",
      name: "Football Federation",
      email: "football@example.com",
      contact: "+1 555-0000",
      address: "800 Stadium Drive, Manchester, UK",
      profile: 'assets/vendor/football.jpg',
    ),
  ];

  // Future<void> loadVendor() async {
  //   try {
  //     if (await _checkBox('Vendor')) {
  //       final myBox = await _getBox('vendor');
  //       vendors = myBox.values.toList() as List<VendorModel>;
  //     } else {
  //       final myBox = await _getBox('vendor');

  //       await myBox.putAll(vendors.asMap());
  //     }
  //   } catch (e) {
  //     Logger().d('laodVendor: $e');
  //   }
  // }

  // Future<List<VendorModel>?> getAllVendors() async {
  //   try {
  //     // final myBox = await _getBox('vendor');
  //     // vendors = myBox.values.toList() as List<VendorModel>;
  //     await loadVendor();
  //     return vendors;
  //   } catch (e) {
  //     Logger().d('getAllVendor: $e');
  //     return null;
  //   }
  // }

  VendorModel? getVendorById(String id) {
    try {
      return vendors.firstWhere((vendor) => vendor.id == id);
    } catch (e) {
      Logger().d('getVendorById: $e');
      return null;
    }
  }

  // Future<bool> addVendor(VendorModel vendor) async {
  //   vendors.add(vendor);
  //   try {
  //     final myBox = await _getBox('vendor');
  //     myBox.put(int.parse(vendor.id), vendor);
  //     await loadVendor();
  //     return true;
  //   } catch (e) {
  //     Logger().d('addVendor: $e');
  //     return false;
  //   }
  // // }

  // Future<bool> removeVendorById(String id) async {
  //   if (vendors.isEmpty) return false;
  //   final index = vendors.indexWhere((vendor) => vendor.id == id);
  //   try {
  //     final myBox = await _getBox('vendor');
  //     await myBox.deleteAt(index);
  //     await loadVendor();
  //     return true;
  //   } catch (e) {
  //     Logger().d('removeVendorById: $e');
  //     return false;
  //   }
  // }

//   Future<bool> updateVendorById(VendorModel vendor) async {
//     if (vendors.indexWhere((vendor) => vendor.id == vendor.id) == -1) {
//       return false;
//     }
//     try {
//       final mybox = await _getBox('vendor');
//       await mybox.put(int.parse(vendor.id), vendor);
//       await loadVendor();
//       return true;
//     } catch (e) {
//       Logger().d('updateVendorById: $e');
//       return false;
//     }
//   }
// }
}

class ProductDatabase {
  ProductDatabase._privateConstructor();
  static final ProductDatabase _instance =
      ProductDatabase._privateConstructor();
  static ProductDatabase get instance => _instance;

  List<ProductModel> products = [
    ProductModel(
        id: '1',
        name: 'The Voice VIPpppppppp',
        description:
            'Exclusive VIP access to The Voice with premium seating, priority check-in, and access to the artist meet-and-greet session.',
        price: 50.0,
        eventDate: DateTime(2024, 2, 15, 19, 0),
        location: 'St 230, Beoung Salang, Toul Kork, Phnom Penh'),
    ProductModel(
        id: '2',
        name: 'The Voice Premium',
        description:
            'Enjoy premium access to The Voice, featuring close-to-stage seating and complimentary snacks during the show.',
        price: 150.0,
        eventDate: DateTime(2024, 2, 15, 19, 0),
        location: 'Diamond Island Convention Center, Phnom Penh'),
    ProductModel(
        id: '3',
        name: 'The Voice Standard',
        description:
            'General admission ticket to The Voice with great seating and an amazing experience for music lovers.',
        price: 20.0,
        eventDate: DateTime(2024, 2, 15, 19, 0),
        location: 'Olympic Stadium, Phnom Penh'),
    ProductModel(
        id: '4',
        name: 'The Voice Standing',
        description:
            'Standing-only ticket for The Voice, perfect for those who love to immerse themselves in the energy of the crowd.',
        price: 30.0,
        eventDate: DateTime(2024, 2, 15, 19, 0),
        location: 'AEON Mall Phnom Penh'),
    ProductModel(
        id: '5',
        name: 'The Voice VVIP',
        description:
            'The ultimate VIP experience with front-row seating, backstage passes, and exclusive dinner with the artists.',
        price: 250.0,
        eventDate: DateTime(2024, 2, 15, 19, 0),
        location: 'City Center Parking, Phnom Penh'),
    ProductModel(
        id: '6',
        name: 'Bun Phum - Magic Show',
        description:
            'Experience a night of wonder and amazement with world-renowned magicians performing their best tricks and illusions.',
        price: 100.0,
        eventDate: DateTime(2024, 3, 10, 18, 0),
        location: 'Event Hall, Phnom Penh'),
    ProductModel(
        id: '7',
        name: 'Bun Phum - Concert',
        description:
            'A spectacular music concert featuring top local and international artists, lighting displays, and an unforgettable atmosphere.',
        price: 100.0,
        eventDate: DateTime(2024, 3, 11, 20, 0),
        location: 'Event Hall, Phnom Penh'),
    ProductModel(
        id: '8',
        name: 'Bun Phum - Elephant Ride',
        description:
            'An adventurous elephant ride through scenic trails, combining excitement with cultural immersion.',
        price: 100.0,
        eventDate: DateTime(2024, 3, 12, 10, 0),
        location: 'Event Hall, Phnom Penh'),
    ProductModel(
        id: '9',
        name: 'Bun Phum - Mountain View',
        description:
            'A breathtaking outdoor event showcasing the serene beauty of mountain landscapes with live performances.',
        price: 100.0,
        eventDate: DateTime(2024, 3, 13, 15, 0),
        location: 'Event Hall, Phnom Penh'),
    ProductModel(
        id: '10',
        name: 'The VIP',
        description:
            'A VIP ticket granting access to premium seating and an exclusive pre-show cocktail hour.',
        price: 60.0,
        eventDate: DateTime(2024, 4, 5, 18, 0),
        location: 'Event Food Court, Phnom Penh'),
    ProductModel(
        id: '11',
        name: 'The VVIP',
        description:
            'An extraordinary VVIP experience with front-row seats and a post-show meet-and-greet with the performers.',
        price: 250.0,
        eventDate: DateTime(2024, 4, 5, 18, 0),
        location: 'Main Stage, Phnom Penh'),
    ProductModel(
        id: '12',
        name: 'The Premium',
        description:
            'Premium seating and complimentary event merchandise for a complete concert experience.',
        price: 25.0,
        eventDate: DateTime(2024, 4, 5, 18, 0),
        location: 'Merchandise Booth, Phnom Penh'),
    ProductModel(
        id: '13',
        name: 'The Standard',
        description:
            'Standard admission ticket for a fun-filled evening of music and entertainment.',
        price: 15.0,
        eventDate: DateTime(2024, 4, 5, 18, 0),
        location: 'Merchandise Booth, Phnom Penh'),
    ProductModel(
        id: '14',
        name: 'Front Seat',
        description:
            'Front-row seating for an up-close view of all the action, complete with complimentary refreshments.',
        price: 120.0,
        eventDate: DateTime(2024, 4, 6, 19, 0),
        location: 'VIP Dining Hall, Phnom Penh'),
    ProductModel(
        id: '15',
        name: 'Back Seat',
        description:
            'Comfortable seating at the back with a clear view of the stage and a relaxed atmosphere.',
        price: 10.0,
        eventDate: DateTime(2024, 4, 6, 19, 0),
        location: 'Check-in Counter, Phnom Penh'),
    ProductModel(
        id: '16',
        name: 'Innex - First Forum',
        description:
            'Join the first-ever Innex forum to discuss groundbreaking ideas and network with industry leaders.',
        price: 5.0,
        eventDate: DateTime(2024, 5, 1, 10, 0),
        location: 'Merchandise Booth, Phnom Penh'),
    ProductModel(
        id: '17',
        name: 'Innex - Second Forum',
        description:
            'The second Innex forum, focusing on emerging technologies and their impact on businesses.',
        price: 12.0,
        eventDate: DateTime(2024, 5, 2, 10, 0),
        location: 'Entrance Hall, Phnom Penh'),
    ProductModel(
        id: '18',
        name: 'Innex - Last Forum',
        description:
            'The final forum in the Innex series, featuring keynote speakers and innovative case studies.',
        price: 180.0,
        eventDate: DateTime(2024, 5, 3, 10, 0),
        location: 'Main Stage, Phnom Penh'),
    ProductModel(
        id: '19',
        name: 'Morning Fair',
        description:
            'A subscription plan offering early access to tickets and discounts for all upcoming events in 2024.',
        price: 100.0,
        eventDate: DateTime(2024, 1, 1, 0, 0),
        location: 'Online Platform'),
    ProductModel(
        id: '20',
        name: 'Cambodia Culture',
        description:
            'An immersive virtual experience showcasing Cambodia’s rich cultural heritage with live streaming and interactive sessions.',
        price: 30.0,
        eventDate: DateTime(2024, 6, 10, 19, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '21',
        name: 'Become Introvert',
        description:
            'A virtual session for personal growth and mindfulness, featuring renowned speakers and relaxing music.',
        price: 30.0,
        eventDate: DateTime(2024, 6, 12, 19, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '22',
        name: 'Cam Vs Tai',
        description:
            'Watch an exhilarating online streaming event featuring top athletes from Cambodia and Thailand competing live.',
        price: 30.0,
        eventDate: DateTime(2024, 7, 1, 18, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '23',
        name: 'Cam Vs Viet',
        description:
            'Stream live matches featuring Cambodia and Vietnam in an intense sporting competition.',
        price: 30.0,
        eventDate: DateTime(2024, 7, 2, 18, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '24',
        name: 'Cam Vs Phi',
        description:
            'Catch the live streaming of a thrilling game between Cambodia and the Philippines.',
        price: 30.0,
        eventDate: DateTime(2024, 7, 3, 18, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '25',
        name: 'Cam Vs Indo',
        description:
            'Join the excitement as Cambodia faces Indonesia in this highly anticipated sporting event.',
        price: 30.0,
        eventDate: DateTime(2024, 7, 4, 18, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '26',
        name: 'Left Row',
        description:
            'Enjoy your view from the left row, offering a unique perspective on the virtual event.',
        price: 30.0,
        eventDate: DateTime(2024, 8, 10, 19, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '27',
        name: 'Right Row',
        description:
            'Sit in the right row for an unparalleled virtual experience and a great view of the action.',
        price: 30.0,
        eventDate: DateTime(2024, 8, 10, 19, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '28',
        name: 'Front Row',
        description:
            'Secure the front row for the best seat in the virtual venue with an immersive view.',
        price: 30.0,
        eventDate: DateTime(2024, 8, 10, 19, 0),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '29',
        name: 'Car Show Meet',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '30',
        name: 'CADT Workshop',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '31',
        name: 'Technology Seminar',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '32',
        name: 'Bar-Cam',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '33',
        name: 'Code-C',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '34',
        name: 'MSC-VIP',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '35',
        name: 'MSC-Standard',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '36',
        name: 'Alumni Meet',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '37',
        name: 'Prom',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '38',
        name: 'Stu-Teach Garthering',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '39',
        name: 'Robocon Show',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '40',
        name: 'Coding Expo',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '41',
        name: '7km',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '42',
        name: '14km',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '43',
        name: '21km',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '44',
        name: '42km',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '45',
        name: 'Play-Off',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '46',
        name: 'Knock-Out',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '47',
        name: 'Grand Final',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '48',
        name: 'Play-Off',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '49',
        name: 'Knock-Out',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '50',
        name: 'Grand Final',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '51',
        name: 'Yeak Sa Show',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '52',
        name: 'Movie Night',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '53',
        name: 'Boat Party',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '54',
        name: 'VVIP',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '55',
        name: 'VIP',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '56',
        name: 'Premium',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '57',
        name: 'Diamond',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '58',
        name: 'Standing',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
    ProductModel(
        id: '59',
        name: 'Standard',
        description: 'Online streaming access for the event',
        price: 30.0,
        eventDate: DateTime.now(),
        location: 'Virtual Event Platform'),
  ];
}

class ProductTaxonDatabase {
  ProductTaxonDatabase._privateConstructor();
  static final ProductTaxonDatabase _instance =
      ProductTaxonDatabase._privateConstructor();
  static ProductTaxonDatabase get instance => _instance;

  List<ProductTaxonModel> classifications = [
    ProductTaxonModel(id: '1', taxonId: '1', productId: '1'),
    ProductTaxonModel(id: '2', taxonId: '1', productId: '2'),
    ProductTaxonModel(id: '3', taxonId: '1', productId: '3'),
    ProductTaxonModel(id: '4', taxonId: '1', productId: '4'),
    ProductTaxonModel(id: '5', taxonId: '1', productId: '5'),
    ProductTaxonModel(id: '6', taxonId: '2', productId: '6'),
    ProductTaxonModel(id: '7', taxonId: '2', productId: '7'),
    ProductTaxonModel(id: '8', taxonId: '2', productId: '8'),
    ProductTaxonModel(id: '9', taxonId: '2', productId: '9'),
    ProductTaxonModel(id: '10', taxonId: '3', productId: '10'),
    ProductTaxonModel(id: '11', taxonId: '3', productId: '11'),
    ProductTaxonModel(id: '12', taxonId: '3', productId: '12'),
    ProductTaxonModel(id: '13', taxonId: '3', productId: '13'),
    ProductTaxonModel(id: '14', taxonId: '4', productId: '14'),
    ProductTaxonModel(id: '15', taxonId: '4', productId: '15'),
    ProductTaxonModel(id: '16', taxonId: '5', productId: '16'),
    ProductTaxonModel(id: '17', taxonId: '5', productId: '17'),
    ProductTaxonModel(id: '18', taxonId: '5', productId: '18'),
    ProductTaxonModel(id: '19', taxonId: '6', productId: '19'),
    ProductTaxonModel(id: '20', taxonId: '7', productId: '20'),
    ProductTaxonModel(id: '21', taxonId: '7', productId: '21'),
    ProductTaxonModel(id: '22', taxonId: '8', productId: '22'),
    ProductTaxonModel(id: '23', taxonId: '8', productId: '23'),
    ProductTaxonModel(id: '24', taxonId: '8', productId: '24'),
    ProductTaxonModel(id: '25', taxonId: '8', productId: '25'),
    ProductTaxonModel(id: '26', taxonId: '9', productId: '26'),
    ProductTaxonModel(id: '27', taxonId: '9', productId: '27'),
    ProductTaxonModel(id: '28', taxonId: '9', productId: '28'),
    ProductTaxonModel(id: '29', taxonId: '10', productId: '29'),
    ProductTaxonModel(id: '30', taxonId: '11', productId: '30'),
    ProductTaxonModel(id: '31', taxonId: '11', productId: '31'),
    ProductTaxonModel(id: '32', taxonId: '11', productId: '32'),
    ProductTaxonModel(id: '33', taxonId: '11', productId: '33'),
    ProductTaxonModel(id: '34', taxonId: '12', productId: '34'),
    ProductTaxonModel(id: '35', taxonId: '12', productId: '35'),
    ProductTaxonModel(id: '36', taxonId: '13', productId: '36'),
    ProductTaxonModel(id: '37', taxonId: '13', productId: '37'),
    ProductTaxonModel(id: '38', taxonId: '13', productId: '38'),
    ProductTaxonModel(id: '39', taxonId: '14', productId: '39'),
    ProductTaxonModel(id: '40', taxonId: '14', productId: '40'),
    ProductTaxonModel(id: '41', taxonId: '15', productId: '41'),
    ProductTaxonModel(id: '42', taxonId: '15', productId: '42'),
    ProductTaxonModel(id: '43', taxonId: '15', productId: '43'),
    ProductTaxonModel(id: '44', taxonId: '15', productId: '44'),
    ProductTaxonModel(id: '45', taxonId: '16', productId: '45'),
    ProductTaxonModel(id: '46', taxonId: '16', productId: '46'),
    ProductTaxonModel(id: '47', taxonId: '16', productId: '47'),
    ProductTaxonModel(id: '48', taxonId: '17', productId: '48'),
    ProductTaxonModel(id: '49', taxonId: '17', productId: '49'),
    ProductTaxonModel(id: '50', taxonId: '17', productId: '50'),
    ProductTaxonModel(id: '51', taxonId: '18', productId: '51'),
    ProductTaxonModel(id: '52', taxonId: '18', productId: '52'),
    ProductTaxonModel(id: '53', taxonId: '18', productId: '53'),
    ProductTaxonModel(id: '54', taxonId: '19', productId: '54'),
    ProductTaxonModel(id: '55', taxonId: '19', productId: '55'),
    ProductTaxonModel(id: '56', taxonId: '19', productId: '56'),
    ProductTaxonModel(id: '57', taxonId: '19', productId: '57'),
    ProductTaxonModel(id: '58', taxonId: '19', productId: '58'),
    ProductTaxonModel(id: '59', taxonId: '19', productId: '59'),
  ];
}

class OptionTypeDatabase {
  OptionTypeDatabase._privateConstructor();
  static final OptionTypeDatabase _instance =
      OptionTypeDatabase._privateConstructor();
  static OptionTypeDatabase get instance => _instance;

  List<OptionTypeModel> options = [
    // Color types
    OptionTypeModel(id: '1', type: 'Color', description: 'Red'),
    OptionTypeModel(id: '2', type: 'Color', description: 'Blue'),
    OptionTypeModel(id: '3', type: 'Color', description: 'Green'),
    OptionTypeModel(id: '4', type: 'Color', description: 'Yellow'),
    OptionTypeModel(id: '5', type: 'Color', description: 'Black'),
    OptionTypeModel(id: '6', type: 'Color', description: 'White'),
    OptionTypeModel(id: '7', type: 'Color', description: 'Purple'),
    OptionTypeModel(id: '8', type: 'Color', description: 'Pink'),
    OptionTypeModel(id: '9', type: 'Color', description: 'Orange'),
    OptionTypeModel(id: '10', type: 'Color', description: 'Brown'),

    // Size types
    OptionTypeModel(id: '11', type: 'Size', description: 'T-Shirt Small'),
    OptionTypeModel(id: '12', type: 'Size', description: 'T-Shirt Medium'),
    OptionTypeModel(id: '13', type: 'Size', description: 'T-Shirt Large'),
    OptionTypeModel(id: '14', type: 'Size', description: 'T-Shirt Extra Small'),
    OptionTypeModel(id: '15', type: 'Size', description: 'T-Shirt Extra Large'),
    OptionTypeModel(id: '16', type: 'Size', description: 'T-Shirt XXL'),
    OptionTypeModel(id: '17', type: 'Size', description: 'T-Shirt 3XL'),
    OptionTypeModel(id: '18', type: 'Size', description: 'T-Shirt Custom Fit'),
    OptionTypeModel(
        id: '19', type: 'Size', description: 'T-Shirt One Fits All'),
    OptionTypeModel(id: '20', type: 'Size', description: 'T-Shirt Kids Size'),

    // Privilege types
    OptionTypeModel(id: '21', type: 'Privilege', description: 'VIP'),
    OptionTypeModel(id: '22', type: 'Privilege', description: 'Normal'),
    OptionTypeModel(id: '23', type: 'Privilege', description: 'Standard'),
    OptionTypeModel(id: '24', type: 'Privilege', description: 'Premium'),
    OptionTypeModel(id: '25', type: 'Privilege', description: 'Basic'),
    OptionTypeModel(id: '26', type: 'Privilege', description: 'Exclusive'),
    OptionTypeModel(id: '27', type: 'Privilege', description: 'Elite'),
    OptionTypeModel(id: '28', type: 'Privilege', description: 'Gold'),
    OptionTypeModel(id: '29', type: 'Privilege', description: 'Silver'),
    OptionTypeModel(id: '30', type: 'Privilege', description: 'Bronze'),

    // Food types
    OptionTypeModel(id: '31', type: 'Food', description: 'Pizza'),
    OptionTypeModel(id: '32', type: 'Food', description: 'Burger'),
    OptionTypeModel(id: '33', type: 'Food', description: 'Sushi'),
    OptionTypeModel(id: '34', type: 'Food', description: 'Pasta'),
    OptionTypeModel(id: '35', type: 'Food', description: 'Salad'),
    OptionTypeModel(id: '36', type: 'Food', description: 'Ice Cream'),
    OptionTypeModel(id: '37', type: 'Food', description: 'Steak'),
    OptionTypeModel(id: '38', type: 'Food', description: 'Tacos'),
    OptionTypeModel(id: '39', type: 'Food', description: 'Sandwich'),
    OptionTypeModel(id: '40', type: 'Food', description: 'Soup'),

    // EventType types
    OptionTypeModel(id: '41', type: 'EventType', description: 'Concert'),
    OptionTypeModel(id: '42', type: 'EventType', description: 'Workshop'),
    OptionTypeModel(id: '43', type: 'EventType', description: 'Seminar'),
    OptionTypeModel(id: '44', type: 'EventType', description: 'Festival'),
    OptionTypeModel(id: '45', type: 'EventType', description: 'Retreat'),
    OptionTypeModel(id: '46', type: 'EventType', description: 'Conference'),
    OptionTypeModel(id: '47', type: 'EventType', description: 'Competition'),
    OptionTypeModel(id: '48', type: 'EventType', description: 'Meetup'),
    OptionTypeModel(
        id: '49', type: 'EventType', description: 'Networking Event'),
    OptionTypeModel(id: '50', type: 'EventType', description: 'Gala'),

    // Merchandise
    OptionTypeModel(id: '51', type: 'Merchandise', description: 'T-Shirt'),
    OptionTypeModel(id: '52', type: 'Merchandise', description: 'Hoodie'),
    OptionTypeModel(id: '53', type: 'Merchandise', description: 'Cap'),
    OptionTypeModel(id: '54', type: 'Merchandise', description: 'Mug'),
    OptionTypeModel(id: '55', type: 'Merchandise', description: 'Tote Bag'),
    OptionTypeModel(id: '56', type: 'Merchandise', description: 'Poster'),
    OptionTypeModel(id: '57', type: 'Merchandise', description: 'Notebook'),
    OptionTypeModel(id: '58', type: 'Merchandise', description: 'Keychain'),
    OptionTypeModel(id: '59', type: 'Merchandise', description: 'Water Bottle'),
    OptionTypeModel(id: '60', type: 'Merchandise', description: 'Sticker Pack'),

    // TicketEvent types
    OptionTypeModel(
        id: '61', type: 'TicketEvent', description: 'Sponsor Ticket'),
    OptionTypeModel(id: '62', type: 'TicketEvent', description: 'Crew Pass'),
    OptionTypeModel(
        id: '63', type: 'TicketEvent', description: 'Student Ticket'),
    OptionTypeModel(id: '64', type: 'TicketEvent', description: 'Company Pass'),
    OptionTypeModel(id: '65', type: 'TicketEvent', description: 'Media Pass'),
    OptionTypeModel(id: '66', type: 'TicketEvent', description: 'Speaker Pass'),
    OptionTypeModel(
        id: '67', type: 'TicketEvent', description: 'Volunteer Pass'),
    OptionTypeModel(id: '68', type: 'TicketEvent', description: 'Press Pass'),
    OptionTypeModel(
        id: '69', type: 'TicketEvent', description: 'Exhibitor Ticket'),
    OptionTypeModel(
        id: '70', type: 'TicketEvent', description: 'Affiliate Ticket'),
  ];
  // Future<void> load() async {
  //   try {
  //     if (await _checkBox('option_type')) {
  //       final myBox = await _getBox<OptionTypeModel>('option_type');
  //       options = myBox.values.toList();
  //     } else {
  //       final myBox = await _getBox<OptionTypeModel>('option_type');
  //       await myBox.addAll(options);
  //     }
  //   } catch (e) {
  //     Logger().d('loadOptionTypes: $e');
  //   }
  // }

  // Future<List<OptionTypeModel>?> getAllOptions() async {
  //   try {
  //     await load();
  //     return options;
  //   } catch (e) {
  //     Logger().d('getAllOptions: $e');
  //     return null;
  //   }
  // }

  // Future<OptionTypeModel?> getOptionTypeById(String id) async {
  //   try {
  //     return options.firstWhere((option) => option.id == id);
  //   } catch (e) {
  //     Logger().d('getOptionTypeById: $e');
  //     return null;
  //   }
  // }

  // Future<List<OptionTypeModel>?> getOptionTypeByType(String type) async {
  //   try {
  //     return options.where((option) => option.type == type).toList();
  //   } catch (e) {
  //     Logger().d('getOptionTypeById: $e');
  //     return null;
  //   }
  // }
}

class ProductVariantDatabase {
  ProductVariantDatabase._privateInstance();
  static final ProductVariantDatabase _instance =
      ProductVariantDatabase._privateInstance();
  static ProductVariantDatabase get instance => _instance;

  List<ProductVariantModel> productVariant = [
    ProductVariantModel(
        id: '1',
        productId: '1',
        optionTypesId: ['61', '31', '11'],
        stockId: '1'), // T-shirt, Size M, Color Blue
    ProductVariantModel(
        id: '2',
        productId: '1',
        optionTypesId: ['61', '31', '12'],
        stockId: '2'), // T-shirt, Size M, Color Red
    ProductVariantModel(
        id: '3',
        productId: '1',
        optionTypesId: ['61', '31', '13'],
        stockId: '3'), // T-shirt, Size M, Color Green
    ProductVariantModel(
        id: '4',
        productId: '1',
        optionTypesId: ['61', '31', '14'],
        stockId: '4'), // T-shirt, Size M, Color Yellow
    ProductVariantModel(
        id: '5',
        productId: '1',
        optionTypesId: ['61', '31', '15'],
        stockId: '5'), // T-shirt, Size M, Color Black
    ProductVariantModel(
        id: '6',
        productId: '1',
        optionTypesId: ['61', '31', '16'],
        stockId: '6'), // T-shirt, Size L, Color Blue
    ProductVariantModel(
        id: '7',
        productId: '1',
        optionTypesId: ['61', '31', '17'],
        stockId: '7'), // T-shirt, Size L, Color Red
    ProductVariantModel(
        id: '8',
        productId: '1',
        optionTypesId: ['61', '31', '18'],
        stockId: '8'), // T-shirt, Size L, Color Green
    ProductVariantModel(
        id: '9',
        productId: '2',
        optionTypesId: ['61', '31', '11'],
        stockId: '9'), // T-shirt, Size M, Color Yellow
    ProductVariantModel(
        id: '10',
        productId: '2',
        optionTypesId: ['61', '31', '12'],
        stockId: '10'), // T-shirt, Size M, Color Red
    ProductVariantModel(
        id: '11',
        productId: '2',
        optionTypesId: ['61', '31', '13'],
        stockId: '11'), // T-shirt, Size M, Color Blue
    ProductVariantModel(
        id: '12',
        productId: '2',
        optionTypesId: ['61', '31', '14'],
        stockId: '12'), // T-shirt, Size M, Color Green
    ProductVariantModel(
        id: '13',
        productId: '2',
        optionTypesId: ['61', '31', '15'],
        stockId: '13'), // T-shirt, Size L, Color Blue
    ProductVariantModel(
        id: '14',
        productId: '2',
        optionTypesId: ['61', '31', '16'],
        stockId: '14'), // T-shirt, Size L, Color Red
    ProductVariantModel(
        id: '15',
        productId: '2',
        optionTypesId: ['61', '31', '17'],
        stockId: '15'), // T-shirt, Size L, Color Green
    ProductVariantModel(
        id: '16',
        productId: '3',
        optionTypesId: ['61', '31', '18'],
        stockId: '16'), // T-shirt, Size M, Color Yellow
    ProductVariantModel(
        id: '17',
        productId: '3',
        optionTypesId: ['61', '31', '19'],
        stockId: '17'), // T-shirt, Size M, Color Red
    ProductVariantModel(
        id: '18',
        productId: '3',
        optionTypesId: ['61', '31', '20'],
        stockId: '18'), // T-shirt, Size M, Color Blue
    ProductVariantModel(
        id: '19',
        productId: '3',
        optionTypesId: ['61', '31', '21'],
        stockId: '19'), // T-shirt, Size L, Color Yellow
    ProductVariantModel(
        id: '20',
        productId: '3',
        optionTypesId: ['61', '31', '22'],
        stockId: '20'), // T-shirt, Size L, Color Red
    ProductVariantModel(
        id: '21',
        productId: '3',
        optionTypesId: ['61', '31', '23'],
        stockId: '21'), // T-shirt, Size L, Color Blue
    ProductVariantModel(
        id: '22',
        productId: '4',
        optionTypesId: ['61', '31', '24'],
        stockId: '22'), // T-shirt, Size XL, Color Blue
    ProductVariantModel(
        id: '23',
        productId: '4',
        optionTypesId: ['61', '31', '25'],
        stockId: '23'), // T-shirt, Size XL, Color Red
    ProductVariantModel(
        id: '24',
        productId: '4',
        optionTypesId: ['61', '31', '26'],
        stockId: '24'), // T-shirt, Size XL, Color Green
    ProductVariantModel(
        id: '25',
        productId: '4',
        optionTypesId: ['61', '31', '27'],
        stockId: '25'), // T-shirt, Size XL, Color Black
    ProductVariantModel(
        id: '26',
        productId: '5',
        optionTypesId: ['61', '31', '28'],
        stockId: '26'), // T-shirt, Size XXL, Color Blue
    ProductVariantModel(
        id: '27',
        productId: '5',
        optionTypesId: ['61', '31', '29'],
        stockId: '27'), // T-shirt, Size XXL, Color Red
    ProductVariantModel(
        id: '28',
        productId: '5',
        optionTypesId: ['61', '31', '30'],
        stockId: '28'), // T-shirt, Size XXL, Color Green
    ProductVariantModel(
        id: '29',
        productId: '5',
        optionTypesId: ['61', '31', '31'],
        stockId: '29'), // T-shirt, Size XXL, Color Yellow
    ProductVariantModel(
        id: '30',
        productId: '6',
        optionTypesId: ['61', '31', '32'],
        stockId: '30'), // Hoodie, Size M, Color Blue
    ProductVariantModel(
        id: '31',
        productId: '6',
        optionTypesId: ['61', '31', '33'],
        stockId: '31'), // Hoodie, Size M, Color Red
    ProductVariantModel(
        id: '32',
        productId: '6',
        optionTypesId: ['61', '31', '34'],
        stockId: '32'), // Hoodie, Size M, Color Green
    ProductVariantModel(
        id: '33',
        productId: '6',
        optionTypesId: ['61', '31', '35'],
        stockId: '33'), // Hoodie, Size L, Color Blue
    ProductVariantModel(
        id: '34',
        productId: '6',
        optionTypesId: ['61', '31', '36'],
        stockId: '34'), // Hoodie, Size L, Color Red
    ProductVariantModel(
        id: '35',
        productId: '6',
        optionTypesId: ['61', '31', '37'],
        stockId: '35'), // Hoodie, Size L, Color Green
    ProductVariantModel(
        id: '36',
        productId: '7',
        optionTypesId: ['62', '32', '11'],
        stockId: '36'), // Sweatshirt, Size M, Color Blue
    ProductVariantModel(
        id: '37',
        productId: '7',
        optionTypesId: ['63', '32', '12'],
        stockId: '37'), // Sweatshirt, Size M, Color Red
    ProductVariantModel(
        id: '38',
        productId: '7',
        optionTypesId: ['64', '32', '13'],
        stockId: '38'), // Sweatshirt, Size M, Color Green
    ProductVariantModel(
        id: '39',
        productId: '7',
        optionTypesId: ['65', '32', '14'],
        stockId: '39'), // Sweatshirt, Size L, Color Blue
    ProductVariantModel(
        id: '40',
        productId: '7',
        optionTypesId: ['66', '32', '15'],
        stockId: '40'), // Sweatshirt, Size L, Color Red
    ProductVariantModel(
        id: '41',
        productId: '7',
        optionTypesId: ['67', '32', '16'],
        stockId: '41'), // Sweatshirt, Size L, Color Green
    ProductVariantModel(
        id: '42',
        productId: '7',
        optionTypesId: ['68', '32', '16'],
        stockId: '42'), // Sweatshirt, Size L, Color Green
    ProductVariantModel(
        id: '43',
        productId: '7',
        optionTypesId: ['69', '32', '16'],
        stockId: '43'), // Sweatshirt, Size L, Color Green
    ProductVariantModel(
        id: '44',
        productId: '7',
        optionTypesId: ['70', '32', '16'],
        stockId: '44'), // Sweatshirt, Size L, Color Green
    ProductVariantModel(
        id: '45',
        productId: '8',
        optionTypesId: ['63', '33', '11'],
        stockId: '45'), // Jacket, Size M, Color Blue
    ProductVariantModel(
        id: '46',
        productId: '8',
        optionTypesId: ['63', '33', '12'],
        stockId: '46'), // Jacket, Size M, Color Red
    ProductVariantModel(
        id: '47',
        productId: '8',
        optionTypesId: ['63', '33', '13'],
        stockId: '47'), // Jacket, Size M, Color Green
    ProductVariantModel(
        id: '48',
        productId: '8',
        optionTypesId: ['63', '33', '14'],
        stockId: '48'), // Jacket, Size L, Color Blue
    ProductVariantModel(
        id: '49',
        productId: '8',
        optionTypesId: ['63', '33', '15'],
        stockId: '49'), // Jacket, Size L, Color Red
    ProductVariantModel(
        id: '50',
        productId: '8',
        optionTypesId: ['63', '33', '16'],
        stockId: '50'), // Jacket, Size L, Color Green
    ProductVariantModel(
        id: '51',
        productId: '8',
        optionTypesId: ['63', '33', '17'],
        stockId: '51'), // Jacket, Size XL, Color Blue
    ProductVariantModel(
        id: '52',
        productId: '8',
        optionTypesId: ['63', '33', '18'],
        stockId: '52'), // Jacket, Size XL, Color Red
    ProductVariantModel(
        id: '53',
        productId: '8',
        optionTypesId: ['63', '33', '19'],
        stockId: '53'), // Jacket, Size XL, Color Green
    ProductVariantModel(
        id: '54',
        productId: '9',
        optionTypesId: ['64', '34', '11'],
        stockId: '54'), // Sweater, Size M, Color Blue
    ProductVariantModel(
        id: '55',
        productId: '9',
        optionTypesId: ['64', '34', '12'],
        stockId: '55'), // Sweater, Size M, Color Red
    ProductVariantModel(
        id: '56',
        productId: '9',
        optionTypesId: ['64', '34', '13'],
        stockId: '56'), // Sweater, Size M, Color Green
    ProductVariantModel(
        id: '57',
        productId: '9',
        optionTypesId: ['64', '34', '14'],
        stockId: '57'), // Sweater, Size L, Color Blue
    ProductVariantModel(
        id: '58',
        productId: '9',
        optionTypesId: ['64', '34', '15'],
        stockId: '58'), // Sweater, Size L, Color Red
    ProductVariantModel(
        id: '59',
        productId: '9',
        optionTypesId: ['64', '34', '16'],
        stockId: '59'), // Sweater, Size L, Color Green
    ProductVariantModel(
        id: '60',
        productId: '9',
        optionTypesId: ['64', '34', '17'],
        stockId: '60'), // Sweater, Size XL, Color Blue
    ProductVariantModel(
        id: '61',
        productId: '9',
        optionTypesId: ['64', '34', '18'],
        stockId: '61'), // Sweater, Size XL, Color Red
    ProductVariantModel(
        id: '62',
        productId: '9',
        optionTypesId: ['64', '34', '19'],
        stockId: '62'), // Sweater, Size XL, Color Green
    ProductVariantModel(
        id: '63',
        productId: '10',
        optionTypesId: ['65', '35', '11'],
        stockId: '63'), // Jeans, Size 30, Color Blue
    ProductVariantModel(
        id: '64',
        productId: '10',
        optionTypesId: ['65', '35', '12'],
        stockId: '64'), // Jeans, Size 30, Color Black
    ProductVariantModel(
        id: '65',
        productId: '10',
        optionTypesId: ['65', '35', '13'],
        stockId: '65'), // Jeans, Size 30, Color Red
    ProductVariantModel(
        id: '66',
        productId: '10',
        optionTypesId: ['65', '35', '14'],
        stockId: '66'), // Jeans, Size 32, Color Blue
    ProductVariantModel(
        id: '67',
        productId: '10',
        optionTypesId: ['65', '35', '15'],
        stockId: '67'), // Jeans, Size 32, Color Black
    ProductVariantModel(
        id: '68',
        productId: '10',
        optionTypesId: ['65', '35', '16'],
        stockId: '68'), // Jeans, Size 32, Color Red
    ProductVariantModel(
        id: '69',
        productId: '10',
        optionTypesId: ['65', '35', '17'],
        stockId: '69'), // Jeans, Size 34, Color Blue
    ProductVariantModel(
        id: '70',
        productId: '10',
        optionTypesId: ['65', '35', '18'],
        stockId: '70'), // Jeans, Size 34, Color Black
    ProductVariantModel(
        id: '71',
        productId: '10',
        optionTypesId: ['65', '35', '19'],
        stockId: '71'), // Jeans, Size 34, Color Red
    ProductVariantModel(
        id: '72',
        productId: '11',
        optionTypesId: ['66', '36', '11'],
        stockId: '72'), // Shorts, Size 30, Color Blue
    ProductVariantModel(
        id: '73',
        productId: '11',
        optionTypesId: ['66', '36', '12'],
        stockId: '73'), // Shorts, Size 30, Color Red
    ProductVariantModel(
        id: '74',
        productId: '11',
        optionTypesId: ['66', '36', '13'],
        stockId: '74'), // Shorts, Size 30, Color Green
    ProductVariantModel(
        id: '75',
        productId: '11',
        optionTypesId: ['66', '36', '14'],
        stockId: '75'), // Shorts, Size 32, Color Blue
    ProductVariantModel(
        id: '76',
        productId: '11',
        optionTypesId: ['66', '36', '15'],
        stockId: '76'), // Shorts, Size 32, Color Red
    ProductVariantModel(
        id: '77',
        productId: '11',
        optionTypesId: ['66', '36', '16'],
        stockId: '77'), // Shorts, Size 32, Color Green
    ProductVariantModel(
        id: '78',
        productId: '11',
        optionTypesId: ['66', '36', '17'],
        stockId: '78'), // Shorts, Size 34, Color Blue
    ProductVariantModel(
        id: '79',
        productId: '11',
        optionTypesId: ['66', '36', '18'],
        stockId: '79'), // Shorts, Size 34, Color Red
    ProductVariantModel(
        id: '80',
        productId: '11',
        optionTypesId: ['66', '36', '19'],
        stockId: '80'), // Shorts, Size 34, Color Green
    ProductVariantModel(
        id: '81',
        productId: '12',
        optionTypesId: ['67', '37', '11'],
        stockId: '81'), // Dress, Size S, Color Blue
    ProductVariantModel(
        id: '82',
        productId: '12',
        optionTypesId: ['67', '37', '12'],
        stockId: '82'), // Dress, Size S, Color Red
    ProductVariantModel(
        id: '83',
        productId: '12',
        optionTypesId: ['67', '37', '13'],
        stockId: '83'), // Dress, Size S, Color Green
    ProductVariantModel(
        id: '84',
        productId: '12',
        optionTypesId: ['67', '37', '14'],
        stockId: '84'), // Dress, Size M, Color Blue
    ProductVariantModel(
        id: '85',
        productId: '12',
        optionTypesId: ['67', '37', '15'],
        stockId: '85'), // Dress, Size M, Color Red
    ProductVariantModel(
        id: '86',
        productId: '12',
        optionTypesId: ['67', '37', '16'],
        stockId: '86'), // Dress, Size M, Color Green
    ProductVariantModel(
        id: '87',
        productId: '12',
        optionTypesId: ['67', '37', '17'],
        stockId: '87'), // Dress, Size L, Color Blue
    ProductVariantModel(
        id: '88',
        productId: '12',
        optionTypesId: ['67', '37', '18'],
        stockId: '88'), // Dress, Size L, Color Red
    ProductVariantModel(
        id: '89',
        productId: '12',
        optionTypesId: ['67', '37', '19'],
        stockId: '89'), // Dress, Size L, Color Gree
    ProductVariantModel(
        id: '90',
        productId: '13',
        optionTypesId: ['68', '38', '11'],
        stockId: '90'), // Jacket, Size M, Color Blue
    ProductVariantModel(
        id: '91',
        productId: '13',
        optionTypesId: ['68', '38', '12'],
        stockId: '91'), // Jacket, Size M, Color Black
    ProductVariantModel(
        id: '92',
        productId: '13',
        optionTypesId: ['68', '38', '13'],
        stockId: '92'), // Jacket, Size M, Color Red
    ProductVariantModel(
        id: '93',
        productId: '13',
        optionTypesId: ['68', '38', '14'],
        stockId: '93'), // Jacket, Size L, Color Blue
    ProductVariantModel(
        id: '94',
        productId: '13',
        optionTypesId: ['68', '38', '15'],
        stockId: '94'), // Jacket, Size L, Color Black
    ProductVariantModel(
        id: '95',
        productId: '13',
        optionTypesId: ['68', '38', '16'],
        stockId: '95'), // Jacket, Size L, Color Red
    ProductVariantModel(
        id: '96',
        productId: '13',
        optionTypesId: ['68', '38', '17'],
        stockId: '96'), // Jacket, Size XL, Color Blue
    ProductVariantModel(
        id: '97',
        productId: '13',
        optionTypesId: ['68', '38', '18'],
        stockId: '97'), // Jacket, Size XL, Color Black
    ProductVariantModel(
        id: '98',
        productId: '13',
        optionTypesId: ['68', '38', '19'],
        stockId: '98'), // Jacket, Size XL, Color Red
    ProductVariantModel(
        id: '99',
        productId: '14',
        optionTypesId: ['69', '39', '11'],
        stockId: '99'), // Skirt, Size S, Color Blue

    ProductVariantModel(
        id: '100',
        productId: '14',
        optionTypesId: ['69', '39', '12'],
        stockId: '100'), // Skirt, Size S, Color Black
    ProductVariantModel(
        id: '101',
        productId: '14',
        optionTypesId: ['69', '39', '13'],
        stockId: '101'), // Skirt, Size S, Color Red
    ProductVariantModel(
        id: '102',
        productId: '14',
        optionTypesId: ['69', '39', '14'],
        stockId: '102'), // Skirt, Size M, Color Blue
    ProductVariantModel(
        id: '103',
        productId: '14',
        optionTypesId: ['69', '39', '15'],
        stockId: '103'), // Skirt, Size M, Color Black
    ProductVariantModel(
        id: '104',
        productId: '14',
        optionTypesId: ['69', '39', '16'],
        stockId: '104'), // Skirt, Size M, Color Red
    ProductVariantModel(
        id: '105',
        productId: '14',
        optionTypesId: ['69', '39', '17'],
        stockId: '105'), // Skirt, Size L, Color Blue
    ProductVariantModel(
        id: '106',
        productId: '14',
        optionTypesId: ['69', '39', '18'],
        stockId: '106'), // Skirt, Size L, Color Black
    ProductVariantModel(
        id: '107',
        productId: '14',
        optionTypesId: ['69', '39', '19'],
        stockId: '107'), // Skirt, Size L, Color Red
    ProductVariantModel(
        id: '108',
        productId: '15',
        optionTypesId: ['60', '40', '11'],
        stockId: '108'), // T-shirt, Size S, Color White
    ProductVariantModel(
        id: '109',
        productId: '15',
        optionTypesId: ['60', '40', '12'],
        stockId: '109'), // T-shirt, Size S, Color Black
    ProductVariantModel(
        id: '110',
        productId: '15',
        optionTypesId: ['60', '40', '13'],
        stockId: '110'), // T-shirt, Size S, Color Blue
    ProductVariantModel(
        id: '111',
        productId: '15',
        optionTypesId: ['60', '40', '14'],
        stockId: '111'), // T-shirt, Size M, Color White
    ProductVariantModel(
        id: '112',
        productId: '15',
        optionTypesId: ['60', '40', '15'],
        stockId: '112'), // T-shirt, Size M, Color Black
    ProductVariantModel(
        id: '113',
        productId: '15',
        optionTypesId: ['60', '40', '16'],
        stockId: '113'), // T-shirt, Size M, Color Blue
    ProductVariantModel(
        id: '114',
        productId: '15',
        optionTypesId: ['60', '40', '17'],
        stockId: '114'), // T-shirt, Size L, Color White
    ProductVariantModel(
        id: '115',
        productId: '15',
        optionTypesId: ['60', '40', '18'],
        stockId: '115'), // T-shirt, Size L, Color Black
    ProductVariantModel(
        id: '116',
        productId: '15',
        optionTypesId: ['60', '40', '19'],
        stockId: '116'), // T-shirt, Size L, Color Blue
    ProductVariantModel(
        id: '117',
        productId: '16',
        optionTypesId: ['61', '41', '11'],
        stockId: '117'), // Cap, Size One Size, Color Blue
    ProductVariantModel(
        id: '118',
        productId: '16',
        optionTypesId: ['61', '41', '12'],
        stockId: '118'), // Cap, Size One Size, Color Black
    ProductVariantModel(
        id: '119',
        productId: '16',
        optionTypesId: ['61', '41', '13'],
        stockId: '119'), // Cap, Size One Size, Color Red
    ProductVariantModel(
        id: '120',
        productId: '16',
        optionTypesId: ['61', '41', '14'],
        stockId: '120'), // Cap, Size One Size, Color Green
    ProductVariantModel(
        id: '121',
        productId: '16',
        optionTypesId: ['61', '41', '15'],
        stockId: '121'), // Cap, Size One Size, Color Yellow
    ProductVariantModel(
        id: '122',
        productId: '16',
        optionTypesId: ['61', '41', '16'],
        stockId: '122'), // Cap, Size One Size, Color White
    ProductVariantModel(
        id: '123',
        productId: '16',
        optionTypesId: ['61', '41', '17'],
        stockId: '123'), // Cap, Size One Size, Color Pink
    ProductVariantModel(
        id: '124',
        productId: '16',
        optionTypesId: ['61', '41', '18'],
        stockId: '124'), // Cap, Size One Size, Color Purple
    ProductVariantModel(
        id: '125',
        productId: '16',
        optionTypesId: ['61', '41', '19'],
        stockId: '125'), // Cap, Size One Size, Color Brown
    ProductVariantModel(
        id: '126',
        productId: '17',
        optionTypesId: ['62', '42', '11'],
        stockId: '126'), // Sneakers, Size 7, Color White
    ProductVariantModel(
        id: '127',
        productId: '17',
        optionTypesId: ['62', '42', '12'],
        stockId: '127'), // Sneakers, Size 7, Color Black
    ProductVariantModel(
        id: '128',
        productId: '17',
        optionTypesId: ['62', '42', '13'],
        stockId: '128'), // Sneakers, Size 7, Color Red
    ProductVariantModel(
        id: '129',
        productId: '17',
        optionTypesId: ['62', '42', '14'],
        stockId: '129'), // Sneakers, Size 8, Color White
    ProductVariantModel(
        id: '130',
        productId: '17',
        optionTypesId: ['62', '42', '15'],
        stockId: '130'), // Sneakers, Size 8, Color Black
    ProductVariantModel(
        id: '131',
        productId: '17',
        optionTypesId: ['62', '42', '16'],
        stockId: '131'), // Sneakers, Size 8, Color Red
    ProductVariantModel(
        id: '132',
        productId: '17',
        optionTypesId: ['62', '42', '17'],
        stockId: '132'), // Sneakers, Size 9, Color White
    ProductVariantModel(
        id: '133',
        productId: '17',
        optionTypesId: ['62', '42', '18'],
        stockId: '133'), // Sneakers, Size 9, Color Black
    ProductVariantModel(
        id: '134',
        productId: '17',
        optionTypesId: ['62', '42', '19'],
        stockId: '134'), // Sneakers, Size 9, Color Red
    ProductVariantModel(
        id: '135',
        productId: '18',
        optionTypesId: ['63', '43', '11'],
        stockId: '135'), // Bag, Size One Size, Color Black
    ProductVariantModel(
        id: '136',
        productId: '18',
        optionTypesId: ['63', '43', '12'],
        stockId: '136'), // Bag, Size One Size, Color Brown
    ProductVariantModel(
        id: '137',
        productId: '18',
        optionTypesId: ['63', '43', '13'],
        stockId: '137'), // Bag, Size One Size, Color Red
    ProductVariantModel(
        id: '138',
        productId: '18',
        optionTypesId: ['63', '43', '14'],
        stockId: '138'), // Bag, Size One Size, Color Green
    ProductVariantModel(
        id: '139',
        productId: '18',
        optionTypesId: ['63', '43', '15'],
        stockId: '139'), // Bag, Size One Size, Color Blue
    ProductVariantModel(
        id: '140',
        productId: '18',
        optionTypesId: ['63', '43', '16'],
        stockId: '140'), // Bag, Size One Size, Color Yellow
    ProductVariantModel(
        id: '141',
        productId: '18',
        optionTypesId: ['63', '43', '17'],
        stockId: '141'), // Bag, Size One Size, Color Pink
    ProductVariantModel(
        id: '142',
        productId: '18',
        optionTypesId: ['63', '43', '18'],
        stockId: '142'), // Bag, Size One Size, Color Purple
    ProductVariantModel(
        id: '143',
        productId: '18',
        optionTypesId: ['63', '43', '19'],
        stockId: '143'), // Bag, Size One Size, Color White
    ProductVariantModel(
        id: '144',
        productId: '19',
        optionTypesId: ['64', '44', '11'],
        stockId: '144'), // Watch, Size One Size, Color Silver
    ProductVariantModel(
        id: '145',
        productId: '19',
        optionTypesId: ['64', '44', '12'],
        stockId: '145'), // Watch, Size One Size, Color Gold
    ProductVariantModel(
        id: '146',
        productId: '19',
        optionTypesId: ['64', '44', '13'],
        stockId: '146'), // Watch, Size One Size, Color Black
    ProductVariantModel(
        id: '147',
        productId: '19',
        optionTypesId: ['64', '44', '14'],
        stockId: '147'), // Watch, Size One Size, Color Blue
    ProductVariantModel(
        id: '148',
        productId: '19',
        optionTypesId: ['64', '44', '15'],
        stockId: '148'), // Watch, Size One Size, Color Brown
    ProductVariantModel(
        id: '149',
        productId: '19',
        optionTypesId: ['64', '44', '16'],
        stockId: '149'), // Watch, Size One Size, Color White
    ProductVariantModel(
        id: '150',
        productId: '19',
        optionTypesId: ['64', '44', '17'],
        stockId: '150'), // Watch, Size One Size, Color Red
    ProductVariantModel(
        id: '151',
        productId: '19',
        optionTypesId: ['64', '44', '18'],
        stockId: '151'), // Watch, Size One Size, Color Silver
    ProductVariantModel(
        id: '152',
        productId: '19',
        optionTypesId: ['64', '44', '19'],
        stockId: '152'), // Watch, Size One Size, Color Gold
    ProductVariantModel(
        id: '153',
        productId: '20',
        optionTypesId: ['65', '45', '11'],
        stockId: '153'), // Glasses, Size One Size, Color Black
    ProductVariantModel(
        id: '154',
        productId: '20',
        optionTypesId: ['65', '45', '12'],
        stockId: '154'), // Glasses, Size One Size, Color Brown
    ProductVariantModel(
        id: '155',
        productId: '20',
        optionTypesId: ['65', '45', '13'],
        stockId: '155'), // Glasses, Size One Size, Color Blue
    ProductVariantModel(
        id: '156',
        productId: '20',
        optionTypesId: ['65', '45', '14'],
        stockId: '156'), // Glasses, Size One Size, Color Red
    ProductVariantModel(
        id: '157',
        productId: '20',
        optionTypesId: ['65', '45', '15'],
        stockId: '157'), // Glasses, Size One Size, Color Green
    ProductVariantModel(
        id: '158',
        productId: '20',
        optionTypesId: ['65', '45', '16'],
        stockId: '158'), // Glasses, Size One Size, Color Yellow
    ProductVariantModel(
        id: '159',
        productId: '20',
        optionTypesId: ['65', '45', '17'],
        stockId: '159'), // Glasses, Size One Size, Color White
    ProductVariantModel(
        id: '160',
        productId: '20',
        optionTypesId: ['65', '45', '18'],
        stockId: '160'), // Glasses, Size One Size, Color Pink
    ProductVariantModel(
        id: '161',
        productId: '20',
        optionTypesId: ['65', '45', '19'],
        stockId: '161'), // Glasses, Size One Size, Color Purple
    ProductVariantModel(
        id: '162',
        productId: '21',
        optionTypesId: ['66', '46', '11'],
        stockId: '162'), // Hat, Size One Size, Color Blue
    ProductVariantModel(
        id: '163',
        productId: '21',
        optionTypesId: ['66', '46', '12'],
        stockId: '163'), // Hat, Size One Size, Color Red
    ProductVariantModel(
        id: '164',
        productId: '21',
        optionTypesId: ['66', '46', '13'],
        stockId: '164'), // Hat, Size One Size, Color Black
    ProductVariantModel(
        id: '165',
        productId: '21',
        optionTypesId: ['66', '46', '14'],
        stockId: '165'), // Hat, Size One Size, Color Green
    ProductVariantModel(
        id: '166',
        productId: '21',
        optionTypesId: ['66', '46', '15'],
        stockId: '166'), // Hat, Size One Size, Color Yellow
    ProductVariantModel(
        id: '167',
        productId: '21',
        optionTypesId: ['66', '46', '16'],
        stockId: '167'), // Hat, Size One Size, Color White
    ProductVariantModel(
        id: '168',
        productId: '22',
        optionTypesId: ['67', '47', '11'],
        stockId: '168'), // Scarf, Size One Size, Color Blue
    ProductVariantModel(
        id: '169',
        productId: '22',
        optionTypesId: ['67', '47', '12'],
        stockId: '169'), // Scarf, Size One Size, Color Red
    ProductVariantModel(
        id: '170',
        productId: '22',
        optionTypesId: ['67', '47', '13'],
        stockId: '170'), // Scarf, Size One Size, Color Black
    ProductVariantModel(
        id: '171',
        productId: '22',
        optionTypesId: ['67', '47', '14'],
        stockId: '171'), // Scarf, Size One Size, Color Green
    ProductVariantModel(
        id: '172',
        productId: '22',
        optionTypesId: ['67', '47', '15'],
        stockId: '172'), // Scarf, Size One Size, Color Yellow
    ProductVariantModel(
        id: '173',
        productId: '22',
        optionTypesId: ['67', '47', '16'],
        stockId: '173'), // Scarf, Size One Size, Color White
    ProductVariantModel(
        id: '174',
        productId: '23',
        optionTypesId: ['68', '48', '11'],
        stockId: '174'), // Belt, Size One Size, Color Blue
    ProductVariantModel(
        id: '175',
        productId: '23',
        optionTypesId: ['68', '48', '12'],
        stockId: '175'), // Belt, Size One Size, Color Red
    ProductVariantModel(
        id: '176',
        productId: '23',
        optionTypesId: ['68', '48', '13'],
        stockId: '176'), // Belt, Size One Size, Color Black
    ProductVariantModel(
        id: '177',
        productId: '23',
        optionTypesId: ['68', '48', '14'],
        stockId: '177'), // Belt, Size One Size, Color Green
    ProductVariantModel(
        id: '178',
        productId: '23',
        optionTypesId: ['68', '48', '15'],
        stockId: '178'), // Belt, Size One Size, Color Yellow
    ProductVariantModel(
        id: '179',
        productId: '23',
        optionTypesId: ['68', '48', '16'],
        stockId: '179'), // Belt, Size One Size, Color White
    ProductVariantModel(
        id: '180',
        productId: '24',
        optionTypesId: ['69', '49', '11'],
        stockId: '180'), // Gloves, Size One Size, Color Blue
    ProductVariantModel(
        id: '181',
        productId: '24',
        optionTypesId: ['69', '49', '12'],
        stockId: '181'), // Gloves, Size One Size, Color Red
    ProductVariantModel(
        id: '182',
        productId: '24',
        optionTypesId: ['69', '49', '13'],
        stockId: '182'), // Gloves, Size One Size, Color Black
    ProductVariantModel(
        id: '183',
        productId: '24',
        optionTypesId: ['69', '49', '14'],
        stockId: '183'), // Gloves, Size One Size, Color Green
    ProductVariantModel(
        id: '184',
        productId: '24',
        optionTypesId: ['69', '49', '15'],
        stockId: '184'), // Gloves, Size One Size, Color Yellow
    ProductVariantModel(
        id: '185',
        productId: '24',
        optionTypesId: ['69', '49', '16'],
        stockId: '185'), // Gloves, Size One Size, Color White
    ProductVariantModel(
        id: '186',
        productId: '25',
        optionTypesId: ['60', '50', '11'],
        stockId: '186'), // Socks, Size One Size, Color Blue
    ProductVariantModel(
        id: '187',
        productId: '25',
        optionTypesId: ['60', '50', '12'],
        stockId: '187'), // Socks, Size One Size, Color Red
    ProductVariantModel(
        id: '188',
        productId: '25',
        optionTypesId: ['60', '50', '13'],
        stockId: '188'), // Socks, Size One Size, Color Black
    ProductVariantModel(
        id: '189',
        productId: '25',
        optionTypesId: ['60', '50', '14'],
        stockId: '189'), // Socks, Size One Size, Color Green
    ProductVariantModel(
        id: '190',
        productId: '25',
        optionTypesId: ['60', '50', '15'],
        stockId: '190'), // Socks, Size One Size, Color Yellow
    ProductVariantModel(
        id: '191',
        productId: '25',
        optionTypesId: ['60', '50', '16'],
        stockId: '191'), // Socks, Size One Size, Color White
    ProductVariantModel(
        id: '192',
        productId: '26',
        optionTypesId: ['61', '51', '11'],
        stockId: '192'), // Shoes, Size One Size, Color Blue
    ProductVariantModel(
        id: '193',
        productId: '26',
        optionTypesId: ['61', '51', '12'],
        stockId: '193'), // Shoes, Size One Size, Color Red
    ProductVariantModel(
        id: '194',
        productId: '26',
        optionTypesId: ['61', '51', '13'],
        stockId: '194'), // Shoes, Size One Size, Color Black
    ProductVariantModel(
        id: '195',
        productId: '26',
        optionTypesId: ['61', '51', '14'],
        stockId: '195'), // Shoes, Size One Size, Color Green
    ProductVariantModel(
        id: '196',
        productId: '26',
        optionTypesId: ['61', '51', '15'],
        stockId: '196'), // Shoes, Size One Size, Color Yellow
    ProductVariantModel(
        id: '197',
        productId: '26',
        optionTypesId: ['61', '51', '16'],
        stockId: '197'), // Shoes, Size One Size, Color White
    ProductVariantModel(
        id: '198',
        productId: '27',
        optionTypesId: ['62', '52', '11'],
        stockId: '198'), // Watch, Size One Size, Color Blue
    ProductVariantModel(
        id: '199',
        productId: '27',
        optionTypesId: ['62', '52', '12'],
        stockId: '199'), // Watch, Size One Size, Color Red
    ProductVariantModel(
        id: '200',
        productId: '27',
        optionTypesId: ['62', '52', '13'],
        stockId: '200'), // Watch, Size One Size, Color Black
    ProductVariantModel(
        id: '201',
        productId: '27',
        optionTypesId: ['62', '52', '14'],
        stockId: '201'), // Watch, Size One Size, Color Green
    ProductVariantModel(
        id: '202',
        productId: '27',
        optionTypesId: ['62', '52', '15'],
        stockId: '202'), // Watch, Size One Size, Color Yellow
    ProductVariantModel(
        id: '203',
        productId: '27',
        optionTypesId: ['62', '52', '16'],
        stockId: '203'), // Watch, Size One Size, Color White
    ProductVariantModel(
        id: '204',
        productId: '28',
        optionTypesId: ['63', '53', '11'],
        stockId: '204'), // Glasses, Size One Size, Color Blue
    ProductVariantModel(
        id: '205',
        productId: '28',
        optionTypesId: ['63', '53', '12'],
        stockId: '205'), // Glasses, Size One Size, Color Red
    ProductVariantModel(
        id: '206',
        productId: '28',
        optionTypesId: ['63', '53', '13'],
        stockId: '206'), // Glasses, Size One Size, Color Black
    ProductVariantModel(
        id: '207',
        productId: '28',
        optionTypesId: ['63', '53', '14'],
        stockId: '207'), // Glasses, Size One Size, Color Green
    ProductVariantModel(
        id: '208',
        productId: '28',
        optionTypesId: ['63', '53', '15'],
        stockId: '208'), // Glasses, Size One Size, Color Yellow
    ProductVariantModel(
        id: '209',
        productId: '28',
        optionTypesId: ['63', '53', '16'],
        stockId: '209'), // Glasses, Size One Size, Color White
    ProductVariantModel(
        id: '210',
        productId: '29',
        optionTypesId: ['64', '54', '11'],
        stockId: '210'), // Bag, Size One Size, Color Blue
    ProductVariantModel(
        id: '211',
        productId: '29',
        optionTypesId: ['64', '54', '12'],
        stockId: '211'), // Bag, Size One Size, Color Red
    ProductVariantModel(
        id: '212',
        productId: '29',
        optionTypesId: ['64', '54', '13'],
        stockId: '212'), // Bag, Size One Size, Color Black
    ProductVariantModel(
        id: '213',
        productId: '29',
        optionTypesId: ['64', '54', '14'],
        stockId: '213'), // Bag, Size One Size, Color Green
    ProductVariantModel(
        id: '214',
        productId: '29',
        optionTypesId: ['64', '54', '15'],
        stockId: '214'), // Bag, Size One Size, Color Yellow
    ProductVariantModel(
        id: '215',
        productId: '29',
        optionTypesId: ['64', '54', '16'],
        stockId: '215'), // Bag, Size One Size, Color White
    ProductVariantModel(
        id: '216',
        productId: '30',
        optionTypesId: ['65', '55', '11'],
        stockId: '216'), // Shoes, Size Small, Color Blue
    ProductVariantModel(
        id: '217',
        productId: '30',
        optionTypesId: ['65', '55', '12'],
        stockId: '217'), // Shoes, Size Small, Color Red
    ProductVariantModel(
        id: '218',
        productId: '30',
        optionTypesId: ['65', '55', '13'],
        stockId: '218'), // Shoes, Size Small, Color Black
    ProductVariantModel(
        id: '219',
        productId: '30',
        optionTypesId: ['65', '55', '14'],
        stockId: '219'), // Shoes, Size Small, Color Green
    ProductVariantModel(
        id: '220',
        productId: '30',
        optionTypesId: ['65', '55', '15'],
        stockId: '220'), // Shoes, Size Small, Color Yellow
    ProductVariantModel(
        id: '221',
        productId: '30',
        optionTypesId: ['65', '55', '16'],
        stockId: '221'), // Shoes, Size Small, Color White
    ProductVariantModel(
        id: '222',
        productId: '31',
        optionTypesId: ['66', '56', '11'],
        stockId: '222'), // Shirt, Size Medium, Color Blue
    ProductVariantModel(
        id: '223',
        productId: '31',
        optionTypesId: ['66', '56', '12'],
        stockId: '223'), // Shirt, Size Medium, Color Red
    ProductVariantModel(
        id: '224',
        productId: '31',
        optionTypesId: ['66', '56', '13'],
        stockId: '224'), // Shirt, Size Medium, Color Black
    ProductVariantModel(
        id: '225',
        productId: '31',
        optionTypesId: ['66', '56', '14'],
        stockId: '225'), // Shirt, Size Medium, Color Green
    ProductVariantModel(
        id: '226',
        productId: '31',
        optionTypesId: ['66', '56', '15'],
        stockId: '226'), // Shirt, Size Medium, Color Yellow
    ProductVariantModel(
        id: '227',
        productId: '31',
        optionTypesId: ['66', '56', '16'],
        stockId: '227'), // Shirt, Size Medium, Color White
    ProductVariantModel(
        id: '228',
        productId: '32',
        optionTypesId: ['67', '57', '11'],
        stockId: '228'), // Pants, Size Medium, Color Blue
    ProductVariantModel(
        id: '229',
        productId: '32',
        optionTypesId: ['67', '57', '12'],
        stockId: '229'), // Pants, Size Medium, Color Red
    ProductVariantModel(
        id: '230',
        productId: '32',
        optionTypesId: ['67', '57', '13'],
        stockId: '230'), // Pants, Size Medium, Color Black
    ProductVariantModel(
        id: '231',
        productId: '32',
        optionTypesId: ['67', '57', '14'],
        stockId: '231'), // Pants, Size Medium, Color Green
    ProductVariantModel(
        id: '232',
        productId: '32',
        optionTypesId: ['67', '57', '15'],
        stockId: '232'), // Pants, Size Medium, Color Yellow
    ProductVariantModel(
        id: '233',
        productId: '32',
        optionTypesId: ['67', '57', '16'],
        stockId: '233'), // Pants, Size Medium, Color White
    ProductVariantModel(
        id: '234',
        productId: '33',
        optionTypesId: ['68', '58', '11'],
        stockId: '234'), // Jacket, Size Large, Color Blue
    ProductVariantModel(
        id: '235',
        productId: '33',
        optionTypesId: ['68', '58', '12'],
        stockId: '235'), // Jacket, Size Large, Color Red
    ProductVariantModel(
        id: '236',
        productId: '33',
        optionTypesId: ['68', '58', '13'],
        stockId: '236'), // Jacket, Size Large, Color Black
    ProductVariantModel(
        id: '237',
        productId: '33',
        optionTypesId: ['68', '58', '14'],
        stockId: '237'), // Jacket, Size Large, Color Green
    ProductVariantModel(
        id: '238',
        productId: '33',
        optionTypesId: ['68', '58', '15'],
        stockId: '238'), // Jacket, Size Large, Color Yellow
    ProductVariantModel(
        id: '239',
        productId: '33',
        optionTypesId: ['68', '58', '16'],
        stockId: '239'), // Jacket, Size Large, Color White
    ProductVariantModel(
        id: '240',
        productId: '34',
        optionTypesId: ['69', '59', '11'],
        stockId: '240'), // Gloves, Size Small, Color Blue
    ProductVariantModel(
        id: '241',
        productId: '34',
        optionTypesId: ['69', '59', '12'],
        stockId: '241'), // Gloves, Size Small, Color Red
    ProductVariantModel(
        id: '242',
        productId: '34',
        optionTypesId: ['69', '59', '13'],
        stockId: '242'), // Gloves, Size Small, Color Black
    ProductVariantModel(
        id: '243',
        productId: '34',
        optionTypesId: ['69', '59', '14'],
        stockId: '243'), // Gloves, Size Small, Color Green
    ProductVariantModel(
        id: '244',
        productId: '34',
        optionTypesId: ['69', '59', '15'],
        stockId: '244'), // Gloves, Size Small, Color Yellow
    ProductVariantModel(
        id: '245',
        productId: '34',
        optionTypesId: ['69', '59', '16'],
        stockId: '245'), // Gloves, Size Small, Color White
    ProductVariantModel(
        id: '246',
        productId: '35',
        optionTypesId: ['10', '60', '11'],
        stockId: '246'), // Tie, Size One Size, Color Blue
    ProductVariantModel(
        id: '247',
        productId: '35',
        optionTypesId: ['10', '60', '12'],
        stockId: '247'), // Tie, Size One Size, Color Red
    ProductVariantModel(
        id: '248',
        productId: '35',
        optionTypesId: ['10', '60', '13'],
        stockId: '248'), // Tie, Size One Size, Color Black
    ProductVariantModel(
        id: '249',
        productId: '35',
        optionTypesId: ['10', '60', '14'],
        stockId: '249'), // Tie, Size One Size, Color Green
    ProductVariantModel(
        id: '250',
        productId: '35',
        optionTypesId: ['10', '60', '15'],
        stockId: '250'), // Tie, Size One Size, Color Yellow
    ProductVariantModel(
        id: '251',
        productId: '35',
        optionTypesId: ['10', '60', '16'],
        stockId: '251'), // Tie, Size One Size, Color White
    ProductVariantModel(
        id: '252',
        productId: '36',
        optionTypesId: ['11', '61', '11'],
        stockId: '252'), // Belt, Size Medium, Color Blue
    ProductVariantModel(
        id: '253',
        productId: '36',
        optionTypesId: ['11', '61', '12'],
        stockId: '253'), // Belt, Size Medium, Color Red
    ProductVariantModel(
        id: '254',
        productId: '36',
        optionTypesId: ['11', '61', '13'],
        stockId: '254'), // Belt, Size Medium, Color Black
    ProductVariantModel(
        id: '255',
        productId: '36',
        optionTypesId: ['11', '61', '14'],
        stockId: '255'), // Belt, Size Medium, Color Green
    ProductVariantModel(
        id: '256',
        productId: '36',
        optionTypesId: ['11', '61', '15'],
        stockId: '256'), // Belt, Size Medium, Color Yellow
    ProductVariantModel(
        id: '257',
        productId: '36',
        optionTypesId: ['11', '61', '16'],
        stockId: '257'), // Belt, Size Medium, Color White
    ProductVariantModel(
        id: '258',
        productId: '37',
        optionTypesId: ['12', '62', '11'],
        stockId: '258'), // Socks, Size Large, Color Blue
    ProductVariantModel(
        id: '259',
        productId: '37',
        optionTypesId: ['12', '62', '12'],
        stockId: '259'), // Socks, Size Large, Color Red
    ProductVariantModel(
        id: '260',
        productId: '37',
        optionTypesId: ['12', '62', '13'],
        stockId: '260'), // Socks, Size Large, Color Black
    ProductVariantModel(
        id: '261',
        productId: '37',
        optionTypesId: ['12', '62', '14'],
        stockId: '261'), // Socks, Size Large, Color Green
    ProductVariantModel(
        id: '262',
        productId: '37',
        optionTypesId: ['12', '62', '15'],
        stockId: '262'), // Socks, Size Large, Color Yellow
    ProductVariantModel(
        id: '263',
        productId: '37',
        optionTypesId: ['12', '62', '16'],
        stockId: '263'), // Socks, Size Large, Color White
    ProductVariantModel(
        id: '264',
        productId: '38',
        optionTypesId: ['13', '63', '11'],
        stockId: '264'), // Shoes, Size 40, Color Blue
    ProductVariantModel(
        id: '265',
        productId: '38',
        optionTypesId: ['13', '63', '12'],
        stockId: '265'), // Shoes, Size 40, Color Red
    ProductVariantModel(
        id: '266',
        productId: '38',
        optionTypesId: ['13', '63', '13'],
        stockId: '266'), // Shoes, Size 40, Color Black
    ProductVariantModel(
        id: '267',
        productId: '38',
        optionTypesId: ['13', '63', '14'],
        stockId: '267'), // Shoes, Size 40, Color Green
    ProductVariantModel(
        id: '268',
        productId: '38',
        optionTypesId: ['13', '63', '15'],
        stockId: '268'), // Shoes, Size 40, Color Yellow
    ProductVariantModel(
        id: '269',
        productId: '38',
        optionTypesId: ['13', '63', '16'],
        stockId: '269'), // Shoes, Size 40, Color White
    ProductVariantModel(
        id: '270',
        productId: '39',
        optionTypesId: ['14', '64', '11'],
        stockId: '270'), // Boots, Size 41, Color Blue
    ProductVariantModel(
        id: '271',
        productId: '39',
        optionTypesId: ['14', '64', '12'],
        stockId: '271'), // Boots, Size 41, Color Red
    ProductVariantModel(
        id: '272',
        productId: '39',
        optionTypesId: ['14', '64', '13'],
        stockId: '272'), // Boots, Size 41, Color Black
    ProductVariantModel(
        id: '273',
        productId: '39',
        optionTypesId: ['14', '64', '14'],
        stockId: '273'), // Boots, Size 41, Color Green
    ProductVariantModel(
        id: '274',
        productId: '39',
        optionTypesId: ['14', '64', '15'],
        stockId: '274'), // Boots, Size 41, Color Yellow
    ProductVariantModel(
        id: '275',
        productId: '39',
        optionTypesId: ['14', '64', '16'],
        stockId: '275'), // Boots, Size 41, Color White
    ProductVariantModel(
        id: '276',
        productId: '40',
        optionTypesId: ['15', '65', '11'],
        stockId: '276'), // Sandals, Size 42, Color Blue
    ProductVariantModel(
        id: '277',
        productId: '40',
        optionTypesId: ['15', '65', '12'],
        stockId: '277'), // Sandals, Size 42, Color Red
    ProductVariantModel(
        id: '278',
        productId: '40',
        optionTypesId: ['15', '65', '13'],
        stockId: '278'), // Sandals, Size 42, Color Black
    ProductVariantModel(
        id: '279',
        productId: '40',
        optionTypesId: ['15', '65', '14'],
        stockId: '279'), // Sandals, Size 42, Color Green
    ProductVariantModel(
        id: '280',
        productId: '40',
        optionTypesId: ['15', '65', '15'],
        stockId: '280'), // Sandals, Size 42, Color Yellow
    ProductVariantModel(
        id: '281',
        productId: '40',
        optionTypesId: ['15', '65', '16'],
        stockId: '281'), // Sandals, Size 42, Color White
    ProductVariantModel(
        id: '282',
        productId: '41',
        optionTypesId: ['16', '66', '11'],
        stockId: '282'), // Sweater, Size Small, Color Blue
    ProductVariantModel(
        id: '283',
        productId: '41',
        optionTypesId: ['16', '66', '12'],
        stockId: '283'), // Sweater, Size Small, Color Red
    ProductVariantModel(
        id: '284',
        productId: '41',
        optionTypesId: ['16', '66', '13'],
        stockId: '284'), // Sweater, Size Small, Color Black
    ProductVariantModel(
        id: '285',
        productId: '41',
        optionTypesId: ['16', '66', '14'],
        stockId: '285'), // Sweater, Size Small, Color Green
    ProductVariantModel(
        id: '286',
        productId: '41',
        optionTypesId: ['16', '66', '15'],
        stockId: '286'), // Sweater, Size Small, Color Yellow
    ProductVariantModel(
        id: '287',
        productId: '41',
        optionTypesId: ['16', '66', '16'],
        stockId: '287'), // Sweater, Size Small, Color White
    ProductVariantModel(
        id: '288',
        productId: '42',
        optionTypesId: ['17', '67', '11'],
        stockId: '288'), // Shirt, Size Medium, Color Blue
    ProductVariantModel(
        id: '289',
        productId: '42',
        optionTypesId: ['17', '67', '12'],
        stockId: '289'), // Shirt, Size Medium, Color Red
    ProductVariantModel(
        id: '290',
        productId: '42',
        optionTypesId: ['17', '67', '13'],
        stockId: '290'), // Shirt, Size Medium, Color Black
    ProductVariantModel(
        id: '291',
        productId: '42',
        optionTypesId: ['17', '67', '14'],
        stockId: '291'), // Shirt, Size Medium, Color Green
    ProductVariantModel(
        id: '292',
        productId: '42',
        optionTypesId: ['17', '67', '15'],
        stockId: '292'), // Shirt, Size Medium, Color Yellow
    ProductVariantModel(
        id: '293',
        productId: '42',
        optionTypesId: ['17', '67', '16'],
        stockId: '293'), // Shirt, Size Medium, Color White
    ProductVariantModel(
        id: '294',
        productId: '43',
        optionTypesId: ['18', '68', '11'],
        stockId: '294'), // Jacket, Size Large, Color Blue
    ProductVariantModel(
        id: '295',
        productId: '43',
        optionTypesId: ['18', '68', '12'],
        stockId: '295'), // Jacket, Size Large, Color Red
    ProductVariantModel(
        id: '296',
        productId: '43',
        optionTypesId: ['18', '68', '13'],
        stockId: '296'), // Jacket, Size Large, Color Black
    ProductVariantModel(
        id: '297',
        productId: '43',
        optionTypesId: ['18', '68', '14'],
        stockId: '297'), // Jacket, Size Large, Color Green
    ProductVariantModel(
        id: '298',
        productId: '43',
        optionTypesId: ['18', '68', '15'],
        stockId: '298'), // Jacket, Size Large, Color Yellow
    ProductVariantModel(
        id: '299',
        productId: '43',
        optionTypesId: ['18', '68', '16'],
        stockId: '299'), // Jacket, Size Large, Color White
    ProductVariantModel(
        id: '300',
        productId: '44',
        optionTypesId: ['19', '69', '11'],
        stockId: '300'), // Pants, Size 32, Color Blue
    ProductVariantModel(
        id: '301',
        productId: '44',
        optionTypesId: ['19', '69', '12'],
        stockId: '301'), // Pants, Size 32, Color Red
    ProductVariantModel(
        id: '302',
        productId: '44',
        optionTypesId: ['19', '69', '13'],
        stockId: '302'), // Pants, Size 32, Color Black
    ProductVariantModel(
        id: '303',
        productId: '44',
        optionTypesId: ['19', '69', '14'],
        stockId: '303'), // Pants, Size 32, Color Green
    ProductVariantModel(
        id: '304',
        productId: '44',
        optionTypesId: ['19', '69', '15'],
        stockId: '304'), // Pants, Size 32, Color Yellow
    ProductVariantModel(
        id: '305',
        productId: '44',
        optionTypesId: ['19', '69', '16'],
        stockId: '305'), // Pants, Size 32, Color White
    ProductVariantModel(
        id: '306',
        productId: '45',
        optionTypesId: ['20', '70', '11'],
        stockId: '306'), // Shorts, Size 33, Color Blue
    ProductVariantModel(
        id: '307',
        productId: '45',
        optionTypesId: ['20', '70', '12'],
        stockId: '307'), // Shorts, Size 33, Color Red
    ProductVariantModel(
        id: '308',
        productId: '45',
        optionTypesId: ['20', '70', '13'],
        stockId: '308'), // Shorts, Size 33, Color Black
    ProductVariantModel(
        id: '309',
        productId: '45',
        optionTypesId: ['20', '70', '14'],
        stockId: '309'), // Shorts, Size 33, Color Green
    ProductVariantModel(
        id: '310',
        productId: '45',
        optionTypesId: ['20', '70', '15'],
        stockId: '310'), // Shorts, Size 33, Color Yellow
    ProductVariantModel(
        id: '311',
        productId: '45',
        optionTypesId: ['20', '70', '16'],
        stockId: '311'), // Shorts, Size 33, Color White
    ProductVariantModel(
        id: '312',
        productId: '46',
        optionTypesId: ['21', '61', '11'],
        stockId: '312'), // T-shirt, Size XL, Color Blue
    ProductVariantModel(
        id: '313',
        productId: '46',
        optionTypesId: ['21', '61', '12'],
        stockId: '313'), // T-shirt, Size XL, Color Red
    ProductVariantModel(
        id: '314',
        productId: '46',
        optionTypesId: ['21', '61', '13'],
        stockId: '314'), // T-shirt, Size XL, Color Black
    ProductVariantModel(
        id: '315',
        productId: '46',
        optionTypesId: ['21', '61', '14'],
        stockId: '315'), // T-shirt, Size XL, Color Green
    ProductVariantModel(
        id: '316',
        productId: '46',
        optionTypesId: ['21', '61', '15'],
        stockId: '316'), // T-shirt, Size XL, Color Yellow
    ProductVariantModel(
        id: '317',
        productId: '46',
        optionTypesId: ['21', '61', '16'],
        stockId: '317'), // T-shirt, Size XL, Color White
    ProductVariantModel(
        id: '318',
        productId: '47',
        optionTypesId: ['22', '62', '11'],
        stockId: '318'), // Hoodie, Size XXL, Color Blue
    ProductVariantModel(
        id: '319',
        productId: '47',
        optionTypesId: ['22', '62', '12'],
        stockId: '319'), // Hoodie, Size XXL, Color Red
    ProductVariantModel(
        id: '320',
        productId: '47',
        optionTypesId: ['22', '62', '13'],
        stockId: '320'), // Hoodie, Size XXL, Color Black
    ProductVariantModel(
        id: '321',
        productId: '47',
        optionTypesId: ['22', '62', '14'],
        stockId: '321'), // Hoodie, Size XXL, Color Green
    ProductVariantModel(
        id: '322',
        productId: '47',
        optionTypesId: ['22', '62', '15'],
        stockId: '322'), // Hoodie, Size XXL, Color Yellow
    ProductVariantModel(
        id: '323',
        productId: '47',
        optionTypesId: ['22', '62', '16'],
        stockId: '323'), // Hoodie, Size XXL, Color White
    ProductVariantModel(
        id: '324',
        productId: '48',
        optionTypesId: ['23', '63', '11'],
        stockId: '324'), // Jacket, Size 34, Color Blue
    ProductVariantModel(
        id: '325',
        productId: '48',
        optionTypesId: ['23', '63', '12'],
        stockId: '325'), // Jacket, Size 34, Color Red
    ProductVariantModel(
        id: '326',
        productId: '48',
        optionTypesId: ['23', '63', '13'],
        stockId: '326'), // Jacket, Size 34, Color Black
    ProductVariantModel(
        id: '327',
        productId: '48',
        optionTypesId: ['23', '63', '14'],
        stockId: '327'), // Jacket, Size 34, Color Green
    ProductVariantModel(
        id: '328',
        productId: '48',
        optionTypesId: ['23', '63', '15'],
        stockId: '328'), // Jacket, Size 34, Color Yellow
    ProductVariantModel(
        id: '329',
        productId: '48',
        optionTypesId: ['23', '63', '16'],
        stockId: '329'), // Jacket, Size 34, Color White
    ProductVariantModel(
        id: '330',
        productId: '49',
        optionTypesId: ['24', '64', '11'],
        stockId: '330'), // Blouse, Size 35, Color Blue
    ProductVariantModel(
        id: '331',
        productId: '49',
        optionTypesId: ['24', '64', '12'],
        stockId: '331'), // Blouse, Size 35, Color Red
    ProductVariantModel(
        id: '332',
        productId: '49',
        optionTypesId: ['24', '64', '13'],
        stockId: '332'), // Blouse, Size 35, Color Black
    ProductVariantModel(
        id: '333',
        productId: '49',
        optionTypesId: ['24', '64', '14'],
        stockId: '333'), // Blouse, Size 35, Color Green
    ProductVariantModel(
        id: '334',
        productId: '49',
        optionTypesId: ['24', '64', '15'],
        stockId: '334'), // Blouse, Size 35, Color Yellow
    ProductVariantModel(
        id: '335',
        productId: '49',
        optionTypesId: ['24', '64', '16'],
        stockId: '335'), // Blouse, Size 35, Color White
    ProductVariantModel(
        id: '336',
        productId: '50',
        optionTypesId: ['25', '65', '11'],
        stockId: '336'), // Skirt, Size 36, Color Blue
    ProductVariantModel(
        id: '337',
        productId: '50',
        optionTypesId: ['25', '65', '12'],
        stockId: '337'), // Skirt, Size 36, Color Red
    ProductVariantModel(
        id: '338',
        productId: '50',
        optionTypesId: ['25', '65', '13'],
        stockId: '338'), // Skirt, Size 36, Color Black
    ProductVariantModel(
        id: '339',
        productId: '50',
        optionTypesId: ['25', '65', '14'],
        stockId: '339'), // Skirt, Size 36, Color Green
    ProductVariantModel(
        id: '340',
        productId: '50',
        optionTypesId: ['25', '65', '15'],
        stockId: '340'), // Skirt, Size 36, Color Yellow
    ProductVariantModel(
        id: '341',
        productId: '50',
        optionTypesId: ['25', '65', '16'],
        stockId: '341'), // Skirt, Size 36, Color White
    ProductVariantModel(
        id: '342',
        productId: '51',
        optionTypesId: ['26', '66', '11'],
        stockId: '342'), // Dress, Size 37, Color Blue
    ProductVariantModel(
        id: '343',
        productId: '51',
        optionTypesId: ['26', '66', '12'],
        stockId: '343'), // Dress, Size 37, Color Red
    ProductVariantModel(
        id: '344',
        productId: '51',
        optionTypesId: ['26', '66', '13'],
        stockId: '344'), // Dress, Size 37, Color Black
    ProductVariantModel(
        id: '345',
        productId: '51',
        optionTypesId: ['26', '66', '14'],
        stockId: '345'), // Dress, Size 37, Color Green
    ProductVariantModel(
        id: '346',
        productId: '51',
        optionTypesId: ['26', '66', '15'],
        stockId: '346'), // Dress, Size 37, Color Yellow
    ProductVariantModel(
        id: '347',
        productId: '51',
        optionTypesId: ['26', '66', '16'],
        stockId: '347'), // Dress, Size 37, Color White
    ProductVariantModel(
        id: '348',
        productId: '52',
        optionTypesId: ['27', '67', '11'],
        stockId: '348'), // Sweater, Size 38, Color Blue
    ProductVariantModel(
        id: '349',
        productId: '52',
        optionTypesId: ['27', '67', '12'],
        stockId: '349'), // Sweater, Size 38, Color Red
    ProductVariantModel(
        id: '350',
        productId: '52',
        optionTypesId: ['27', '67', '13'],
        stockId: '350'), // Sweater, Size 38, Color Black
    ProductVariantModel(
        id: '351',
        productId: '52',
        optionTypesId: ['27', '67', '14'],
        stockId: '351'), // Sweater, Size 38, Color Green
    ProductVariantModel(
        id: '352',
        productId: '52',
        optionTypesId: ['27', '67', '15'],
        stockId: '352'), // Sweater, Size 38, Color Yellow
    ProductVariantModel(
        id: '353',
        productId: '52',
        optionTypesId: ['27', '67', '16'],
        stockId: '353'), // Sweater, Size 38, Color White
    ProductVariantModel(
        id: '354',
        productId: '53',
        optionTypesId: ['28', '68', '11'],
        stockId: '354'), // Gloves, Size One Size, Color Blue
    ProductVariantModel(
        id: '355',
        productId: '53',
        optionTypesId: ['28', '68', '12'],
        stockId: '355'), // Gloves, Size One Size, Color Red
    ProductVariantModel(
        id: '356',
        productId: '53',
        optionTypesId: ['28', '68', '13'],
        stockId: '356'), // Gloves, Size One Size, Color Black
    ProductVariantModel(
        id: '357',
        productId: '53',
        optionTypesId: ['28', '68', '14'],
        stockId: '357'), // Gloves, Size One Size, Color Green
    ProductVariantModel(
        id: '358',
        productId: '53',
        optionTypesId: ['28', '68', '15'],
        stockId: '358'), // Gloves, Size One Size, Color Yellow
    ProductVariantModel(
        id: '359',
        productId: '53',
        optionTypesId: ['28', '68', '16'],
        stockId: '359'), // Gloves, Size One Size, Color White
    ProductVariantModel(
        id: '360',
        productId: '54',
        optionTypesId: ['29', '69', '11'],
        stockId: '360'), // Socks, Size One Size, Color Blue
    ProductVariantModel(
        id: '361',
        productId: '54',
        optionTypesId: ['29', '69', '12'],
        stockId: '361'), // Socks, Size One Size, Color Red
    ProductVariantModel(
        id: '362',
        productId: '54',
        optionTypesId: ['29', '69', '13'],
        stockId: '362'), // Socks, Size One Size, Color Black
    ProductVariantModel(
        id: '363',
        productId: '54',
        optionTypesId: ['29', '69', '14'],
        stockId: '363'), // Socks, Size One Size, Color Green
    ProductVariantModel(
        id: '364',
        productId: '54',
        optionTypesId: ['29', '69', '15'],
        stockId: '364'), // Socks, Size One Size, Color Yellow
    ProductVariantModel(
        id: '365',
        productId: '54',
        optionTypesId: ['29', '69', '16'],
        stockId: '365'), // Socks, Size One Size, Color White
    ProductVariantModel(
        id: '366',
        productId: '55',
        optionTypesId: ['30', '60', '11'],
        stockId: '366'), // Watch, Size One Size, Color Blue
    ProductVariantModel(
        id: '367',
        productId: '55',
        optionTypesId: ['30', '60', '12'],
        stockId: '367'), // Watch, Size One Size, Color Red
    ProductVariantModel(
        id: '368',
        productId: '55',
        optionTypesId: ['30', '60', '13'],
        stockId: '368'), // Watch, Size One Size, Color Black
    ProductVariantModel(
        id: '369',
        productId: '55',
        optionTypesId: ['30', '60', '14'],
        stockId: '369'), // Watch, Size One Size, Color Green
    ProductVariantModel(
        id: '370',
        productId: '55',
        optionTypesId: ['30', '60', '15'],
        stockId: '370'), // Watch, Size One Size, Color Yellow
    ProductVariantModel(
        id: '371',
        productId: '55',
        optionTypesId: ['30', '60', '16'],
        stockId: '371'), // Watch, Size One Size, Color White
    ProductVariantModel(
        id: '372',
        productId: '56',
        optionTypesId: ['31', '61', '11'],
        stockId: '372'), // Hat, Size One Size, Color Blue
    ProductVariantModel(
        id: '373',
        productId: '56',
        optionTypesId: ['31', '61', '12'],
        stockId: '373'), // Hat, Size One Size, Color Red
    ProductVariantModel(
        id: '374',
        productId: '56',
        optionTypesId: ['31', '61', '13'],
        stockId: '374'), // Hat, Size One Size, Color Black
    ProductVariantModel(
        id: '375',
        productId: '56',
        optionTypesId: ['31', '61', '14'],
        stockId: '375'), // Hat, Size One Size, Color Green
    ProductVariantModel(
        id: '376',
        productId: '56',
        optionTypesId: ['31', '61', '15'],
        stockId: '376'), // Hat, Size One Size, Color Yellow
    ProductVariantModel(
        id: '377',
        productId: '56',
        optionTypesId: ['31', '61', '16'],
        stockId: '377'), // Hat, Size One Size, Color White
    ProductVariantModel(
        id: '378',
        productId: '57',
        optionTypesId: ['32', '62', '11'],
        stockId: '378'), // Jacket, Size Medium, Color Blue
    ProductVariantModel(
        id: '379',
        productId: '57',
        optionTypesId: ['32', '62', '12'],
        stockId: '379'), // Jacket, Size Medium, Color Red
    ProductVariantModel(
        id: '380',
        productId: '57',
        optionTypesId: ['32', '62', '13'],
        stockId: '380'), // Jacket, Size Medium, Color Black
    ProductVariantModel(
        id: '381',
        productId: '57',
        optionTypesId: ['32', '62', '14'],
        stockId: '381'), // Jacket, Size Medium, Color Green
    ProductVariantModel(
        id: '382',
        productId: '57',
        optionTypesId: ['32', '62', '15'],
        stockId: '382'), // Jacket, Size Medium, Color Yellow
    ProductVariantModel(
        id: '383',
        productId: '57',
        optionTypesId: ['32', '62', '16'],
        stockId: '383'), // Jacket, Size Medium, Color White
    ProductVariantModel(
        id: '384',
        productId: '58',
        optionTypesId: ['33', '63', '11'],
        stockId: '384'), // Sweater, Size Small, Color Blue
    ProductVariantModel(
        id: '385',
        productId: '58',
        optionTypesId: ['33', '63', '12'],
        stockId: '385'), // Sweater, Size Small, Color Red
    ProductVariantModel(
        id: '386',
        productId: '58',
        optionTypesId: ['33', '63', '13'],
        stockId: '386'), // Sweater, Size Small, Color Black
    ProductVariantModel(
        id: '387',
        productId: '58',
        optionTypesId: ['33', '63', '14'],
        stockId: '387'), // Sweater, Size Small, Color Green
    ProductVariantModel(
        id: '388',
        productId: '58',
        optionTypesId: ['33', '63', '15'],
        stockId: '388'), // Sweater, Size Small, Color Yellow
    ProductVariantModel(
        id: '389',
        productId: '58',
        optionTypesId: ['33', '63', '16'],
        stockId: '389'), // Sweater, Size Small, Color White
    ProductVariantModel(
        id: '390',
        productId: '59',
        optionTypesId: ['34', '64', '11'],
        stockId: '390'), // T-shirt, Size M, Color Blue
    ProductVariantModel(
        id: '391',
        productId: '59',
        optionTypesId: ['34', '64', '12'],
        stockId: '391'), // T-shirt, Size M, Color Red
    ProductVariantModel(
        id: '392',
        productId: '59',
        optionTypesId: ['34', '64', '13'],
        stockId: '392'), // T-shirt, Size M, Color Black
    ProductVariantModel(
        id: '393',
        productId: '59',
        optionTypesId: ['34', '64', '14'],
        stockId: '393'), // T-shirt, Size M, Color Green
    ProductVariantModel(
        id: '394',
        productId: '59',
        optionTypesId: ['34', '64', '15'],
        stockId: '394'), // T-shirt, Size M, Color Yellow
    ProductVariantModel(
        id: '395',
        productId: '59',
        optionTypesId: ['34', '64', '16'],
        stockId: '395'), // T-shirt, Size M, Color White
    ProductVariantModel(
        id: '396',
        productId: '59',
        optionTypesId: ['25', '65', '13'],
        stockId: ''), // Skirt, Size 36, Color Black
    ProductVariantModel(
        id: '397',
        productId: '59',
        optionTypesId: ['25', '65', '13'],
        stockId: ''), // Skirt, Size 36, Color Black
    ProductVariantModel(
        id: '398',
        productId: '59',
        optionTypesId: ['25', '65', '13'],
        stockId: ''), // Skirt, Size 36, Color Black
    ProductVariantModel(
        id: '399',
        productId: '59',
        optionTypesId: ['25', '65', '13'],
        stockId: ''), // Skirt, Size 36, Color Black
    ProductVariantModel(
        id: '400',
        productId: '59',
        optionTypesId: ['25', '65', '13'],
        stockId: ''), // Skirt, Size 36, Color Black
  ];
}

class StockDatabase {
  StockDatabase._privateInstance();
  static final StockDatabase _instance = StockDatabase._privateInstance();
  static StockDatabase get instance => _instance;

  List<StockModel> stockDatabase = [
    StockModel(
      id: '1',
      quantity: 100,
      stockLocation: '',
      variantId: '1',
      limitStock: 100,
    ),
    StockModel(
        id: '2',
        quantity: 200,
        stockLocation: '',
        variantId: '2',
        limitStock: 200),
    StockModel(
      id: '3',
      quantity: 0,
      stockLocation: '',
      variantId: '3',
      limitStock: 0,
    ),
    StockModel(
        id: '4',
        quantity: 200,
        stockLocation: '',
        variantId: '4',
        limitStock: 200),
    StockModel(
        id: '5',
        quantity: 200,
        stockLocation: '',
        variantId: '5',
        limitStock: 200),
    StockModel(
        id: '6',
        quantity: 200,
        stockLocation: '',
        variantId: '6',
        limitStock: 200),
    StockModel(
        id: '6',
        quantity: 200,
        stockLocation: '',
        variantId: '7',
        limitStock: 200),
    StockModel(
        id: '8',
        quantity: 200,
        stockLocation: '',
        variantId: '8',
        limitStock: 200),
    StockModel(
        id: '9',
        quantity: 200,
        stockLocation: '',
        variantId: '9',
        limitStock: 200),
    StockModel(
        id: '10',
        quantity: 200,
        stockLocation: '',
        variantId: '10',
        limitStock: 200),
    StockModel(
        id: '11',
        quantity: 200,
        stockLocation: '',
        variantId: '11',
        limitStock: 200),
    StockModel(
        id: '12',
        quantity: 200,
        stockLocation: '',
        variantId: '12',
        limitStock: 200),
    StockModel(
        id: '13',
        quantity: 0,
        stockLocation: '',
        variantId: '13',
        limitStock: 0),
    StockModel(
        id: '14',
        quantity: 5,
        stockLocation: '',
        variantId: '14',
        limitStock: 5),
    StockModel(
        id: '15',
        quantity: 200,
        stockLocation: '',
        variantId: '15',
        limitStock: 200),
    StockModel(
        id: '16',
        quantity: 2,
        stockLocation: '',
        variantId: '16',
        limitStock: 2),
    StockModel(
        id: '17',
        quantity: 200,
        stockLocation: '',
        variantId: '17',
        limitStock: 200),
    StockModel(
        id: '18',
        quantity: 200,
        stockLocation: '',
        variantId: '18',
        limitStock: 200),
    StockModel(
        id: '19',
        quantity: 200,
        stockLocation: '',
        variantId: '19',
        limitStock: 200),
    StockModel(
        id: '20',
        quantity: 200,
        stockLocation: '',
        variantId: '20',
        limitStock: 200),
    StockModel(
        id: '21',
        quantity: 100,
        stockLocation: '',
        variantId: '21',
        limitStock: 100),
    StockModel(
        id: '22',
        quantity: 150,
        stockLocation: '',
        variantId: '22',
        limitStock: 150),
    StockModel(
        id: '23',
        quantity: 75,
        stockLocation: '',
        variantId: '23',
        limitStock: 75),
    StockModel(
        id: '24',
        quantity: 50,
        stockLocation: '',
        variantId: '24',
        limitStock: 50),
    StockModel(
        id: '25',
        quantity: 200,
        stockLocation: '',
        variantId: '25',
        limitStock: 200),
    StockModel(
        id: '26',
        quantity: 120,
        stockLocation: '',
        variantId: '26',
        limitStock: 120),
    StockModel(
        id: '27',
        quantity: 90,
        stockLocation: '',
        variantId: '27',
        limitStock: 90),
    StockModel(
        id: '28',
        quantity: 5,
        stockLocation: '',
        variantId: '28',
        limitStock: 5),
    StockModel(
        id: '29',
        quantity: 60,
        stockLocation: '',
        variantId: '29',
        limitStock: 60),
    StockModel(
        id: '30',
        quantity: 200,
        stockLocation: '',
        variantId: '30',
        limitStock: 200),
    StockModel(
        id: '31',
        quantity: 100,
        stockLocation: '',
        variantId: '31',
        limitStock: 100),
    StockModel(
        id: '32',
        quantity: 150,
        stockLocation: '',
        variantId: '32',
        limitStock: 150),
    StockModel(
        id: '33',
        quantity: 75,
        stockLocation: '',
        variantId: '33',
        limitStock: 75),
    StockModel(
        id: '34',
        quantity: 50,
        stockLocation: '',
        variantId: '34',
        limitStock: 50),
    StockModel(
        id: '35',
        quantity: 200,
        stockLocation: '',
        variantId: '35',
        limitStock: 200),
    StockModel(
        id: '36',
        quantity: 120,
        stockLocation: '',
        variantId: '36',
        limitStock: 120),
    StockModel(
        id: '37',
        quantity: 90,
        stockLocation: '',
        variantId: '37',
        limitStock: 90),
    StockModel(
        id: '38',
        quantity: 5,
        stockLocation: '',
        variantId: '38',
        limitStock: 5),
    StockModel(
        id: '39',
        quantity: 60,
        stockLocation: '',
        variantId: '39',
        limitStock: 60),
    StockModel(
        id: '40',
        quantity: 200,
        stockLocation: '',
        variantId: '40',
        limitStock: 200),
    StockModel(
        id: '41',
        quantity: 100,
        stockLocation: '',
        variantId: '41',
        limitStock: 100),
    StockModel(
        id: '42',
        quantity: 150,
        stockLocation: '',
        variantId: '42',
        limitStock: 150),
    StockModel(
        id: '43',
        quantity: 75,
        stockLocation: '',
        variantId: '43',
        limitStock: 75),
    StockModel(
        id: '44',
        quantity: 50,
        stockLocation: '',
        variantId: '44',
        limitStock: 50),
    StockModel(
        id: '45',
        quantity: 200,
        stockLocation: '',
        variantId: '45',
        limitStock: 200),
    StockModel(
        id: '46',
        quantity: 120,
        stockLocation: '',
        variantId: '46',
        limitStock: 120),
    StockModel(
        id: '47',
        quantity: 90,
        stockLocation: '',
        variantId: '47',
        limitStock: 90),
    StockModel(
        id: '48',
        quantity: 5,
        stockLocation: '',
        variantId: '48',
        limitStock: 5),
    StockModel(
        id: '49',
        quantity: 60,
        stockLocation: '',
        variantId: '49',
        limitStock: 60),
    StockModel(
        id: '50',
        quantity: 200,
        stockLocation: '',
        variantId: '50',
        limitStock: 200),
    StockModel(
        id: '51',
        quantity: 100,
        stockLocation: '',
        variantId: '51',
        limitStock: 100),
    StockModel(
        id: '52',
        quantity: 150,
        stockLocation: '',
        variantId: '52',
        limitStock: 150),
    StockModel(
        id: '53',
        quantity: 75,
        stockLocation: '',
        variantId: '53',
        limitStock: 75),
    StockModel(
        id: '54',
        quantity: 50,
        stockLocation: '',
        variantId: '54',
        limitStock: 50),
    StockModel(
        id: '55',
        quantity: 200,
        stockLocation: '',
        variantId: '55',
        limitStock: 200),
    StockModel(
        id: '56',
        quantity: 120,
        stockLocation: '',
        variantId: '56',
        limitStock: 120),
    StockModel(
        id: '57',
        quantity: 90,
        stockLocation: '',
        variantId: '57',
        limitStock: 90),
    StockModel(
        id: '58',
        quantity: 5,
        stockLocation: '',
        variantId: '58',
        limitStock: 5),
    StockModel(
        id: '59',
        quantity: 60,
        stockLocation: '',
        variantId: '59',
        limitStock: 60),
    StockModel(
        id: '60',
        quantity: 200,
        stockLocation: '',
        variantId: '60',
        limitStock: 200),
    StockModel(
        id: '61',
        quantity: 100,
        stockLocation: '',
        variantId: '61',
        limitStock: 100),
    StockModel(
        id: '62',
        quantity: 150,
        stockLocation: '',
        variantId: '62',
        limitStock: 150),
    StockModel(
        id: '63',
        quantity: 75,
        stockLocation: '',
        variantId: '63',
        limitStock: 75),
    StockModel(
        id: '64',
        quantity: 50,
        stockLocation: '',
        variantId: '64',
        limitStock: 50),
    StockModel(
        id: '65',
        quantity: 200,
        stockLocation: '',
        variantId: '65',
        limitStock: 200),
    StockModel(
        id: '66',
        quantity: 120,
        stockLocation: '',
        variantId: '66',
        limitStock: 120),
    StockModel(
        id: '67',
        quantity: 90,
        stockLocation: '',
        variantId: '67',
        limitStock: 90),
    StockModel(
        id: '68',
        quantity: 5,
        stockLocation: '',
        variantId: '68',
        limitStock: 5),
    StockModel(
        id: '69',
        quantity: 60,
        stockLocation: '',
        variantId: '69',
        limitStock: 60),
    StockModel(
        id: '70',
        quantity: 200,
        stockLocation: '',
        variantId: '70',
        limitStock: 200),
    StockModel(
        id: '71',
        quantity: 100,
        stockLocation: '',
        variantId: '71',
        limitStock: 100),
    StockModel(
        id: '72',
        quantity: 150,
        stockLocation: '',
        variantId: '72',
        limitStock: 150),
    StockModel(
        id: '73',
        quantity: 75,
        stockLocation: '',
        variantId: '73',
        limitStock: 75),
    StockModel(
        id: '74',
        quantity: 50,
        stockLocation: '',
        variantId: '74',
        limitStock: 50),
    StockModel(
        id: '75',
        quantity: 200,
        stockLocation: '',
        variantId: '75',
        limitStock: 200),
    StockModel(
        id: '76',
        quantity: 120,
        stockLocation: '',
        variantId: '76',
        limitStock: 120),
    StockModel(
        id: '77',
        quantity: 90,
        stockLocation: '',
        variantId: '77',
        limitStock: 90),
    StockModel(
        id: '78',
        quantity: 5,
        stockLocation: '',
        variantId: '78',
        limitStock: 5),
    StockModel(
        id: '79',
        quantity: 60,
        stockLocation: '',
        variantId: '79',
        limitStock: 60),
    StockModel(
        id: '80',
        quantity: 200,
        stockLocation: '',
        variantId: '80',
        limitStock: 200),
    StockModel(
        id: '81',
        quantity: 100,
        stockLocation: '',
        variantId: '81',
        limitStock: 100),
    StockModel(
        id: '82',
        quantity: 150,
        stockLocation: '',
        variantId: '82',
        limitStock: 150),
    StockModel(
        id: '83',
        quantity: 75,
        stockLocation: '',
        variantId: '83',
        limitStock: 75),
    StockModel(
        id: '84',
        quantity: 50,
        stockLocation: '',
        variantId: '84',
        limitStock: 50),
    StockModel(
        id: '85',
        quantity: 200,
        stockLocation: '',
        variantId: '85',
        limitStock: 200),
    StockModel(
        id: '86',
        quantity: 120,
        stockLocation: '',
        variantId: '86',
        limitStock: 120),
    StockModel(
        id: '87',
        quantity: 90,
        stockLocation: '',
        variantId: '87',
        limitStock: 90),
    StockModel(
        id: '88',
        quantity: 5,
        stockLocation: '',
        variantId: '88',
        limitStock: 5),
    StockModel(
        id: '89',
        quantity: 60,
        stockLocation: '',
        variantId: '89',
        limitStock: 60),
    StockModel(
        id: '90',
        quantity: 200,
        stockLocation: '',
        variantId: '90',
        limitStock: 200),
    StockModel(
        id: '91',
        quantity: 100,
        stockLocation: '',
        variantId: '91',
        limitStock: 100),
    StockModel(
        id: '92',
        quantity: 150,
        stockLocation: '',
        variantId: '92',
        limitStock: 150),
    StockModel(
        id: '93',
        quantity: 75,
        stockLocation: '',
        variantId: '93',
        limitStock: 75),
    StockModel(
        id: '94',
        quantity: 50,
        stockLocation: '',
        variantId: '94',
        limitStock: 50),
    StockModel(
        id: '95',
        quantity: 200,
        stockLocation: '',
        variantId: '95',
        limitStock: 200),
    StockModel(
        id: '96',
        quantity: 120,
        stockLocation: '',
        variantId: '96',
        limitStock: 120),
    StockModel(
        id: '97',
        quantity: 90,
        stockLocation: '',
        variantId: '97',
        limitStock: 90),
    StockModel(
        id: '98',
        quantity: 5,
        stockLocation: '',
        variantId: '98',
        limitStock: 5),
    StockModel(
        id: '99',
        quantity: 60,
        stockLocation: '',
        variantId: '99',
        limitStock: 60),
    StockModel(
        id: '100',
        quantity: 200,
        stockLocation: '',
        variantId: '100',
        limitStock: 200),
    StockModel(
        id: '101',
        quantity: 100,
        stockLocation: '',
        variantId: '101',
        limitStock: 100),
    StockModel(
        id: '102',
        quantity: 150,
        stockLocation: '',
        variantId: '102',
        limitStock: 150),
    StockModel(
        id: '103',
        quantity: 75,
        stockLocation: '',
        variantId: '103',
        limitStock: 75),
    StockModel(
        id: '104',
        quantity: 50,
        stockLocation: '',
        variantId: '104',
        limitStock: 50),
    StockModel(
        id: '105',
        quantity: 200,
        stockLocation: '',
        variantId: '105',
        limitStock: 200),
    StockModel(
        id: '106',
        quantity: 120,
        stockLocation: '',
        variantId: '106',
        limitStock: 120),
    StockModel(
        id: '107',
        quantity: 90,
        stockLocation: '',
        variantId: '107',
        limitStock: 90),
    StockModel(
        id: '108',
        quantity: 5,
        stockLocation: '',
        variantId: '108',
        limitStock: 5),
    StockModel(
        id: '109',
        quantity: 60,
        stockLocation: '',
        variantId: '109',
        limitStock: 60),
    StockModel(
        id: '110',
        quantity: 200,
        stockLocation: '',
        variantId: '110',
        limitStock: 200),
    StockModel(
        id: '111',
        quantity: 100,
        stockLocation: '',
        variantId: '111',
        limitStock: 100),
    StockModel(
        id: '112',
        quantity: 150,
        stockLocation: '',
        variantId: '112',
        limitStock: 150),
    StockModel(
        id: '113',
        quantity: 75,
        stockLocation: '',
        variantId: '113',
        limitStock: 75),
    StockModel(
        id: '114',
        quantity: 50,
        stockLocation: '',
        variantId: '114',
        limitStock: 50),
    StockModel(
        id: '115',
        quantity: 200,
        stockLocation: '',
        variantId: '115',
        limitStock: 200),
    StockModel(
        id: '116',
        quantity: 120,
        stockLocation: '',
        variantId: '116',
        limitStock: 120),
    StockModel(
        id: '117',
        quantity: 90,
        stockLocation: '',
        variantId: '117',
        limitStock: 90),
    StockModel(
        id: '118',
        quantity: 5,
        stockLocation: '',
        variantId: '118',
        limitStock: 5),
    StockModel(
        id: '119',
        quantity: 60,
        stockLocation: '',
        variantId: '119',
        limitStock: 60),
    StockModel(
        id: '120',
        quantity: 200,
        stockLocation: '',
        variantId: '120',
        limitStock: 200),
    StockModel(
        id: '121',
        quantity: 100,
        stockLocation: '',
        variantId: '121',
        limitStock: 100),
    StockModel(
        id: '122',
        quantity: 150,
        stockLocation: '',
        variantId: '122',
        limitStock: 150),
    StockModel(
        id: '123',
        quantity: 75,
        stockLocation: '',
        variantId: '123',
        limitStock: 75),
    StockModel(
        id: '124',
        quantity: 50,
        stockLocation: '',
        variantId: '124',
        limitStock: 50),
    StockModel(
        id: '125',
        quantity: 200,
        stockLocation: '',
        variantId: '125',
        limitStock: 200),
    StockModel(
        id: '126',
        quantity: 120,
        stockLocation: '',
        variantId: '126',
        limitStock: 120),
    StockModel(
        id: '127',
        quantity: 90,
        stockLocation: '',
        variantId: '127',
        limitStock: 90),
    StockModel(
        id: '128',
        quantity: 5,
        stockLocation: '',
        variantId: '128',
        limitStock: 5),
    StockModel(
        id: '129',
        quantity: 60,
        stockLocation: '',
        variantId: '129',
        limitStock: 60),
    StockModel(
        id: '130',
        quantity: 200,
        stockLocation: '',
        variantId: '130',
        limitStock: 200),
    StockModel(
        id: '131',
        quantity: 100,
        stockLocation: '',
        variantId: '131',
        limitStock: 100),
    StockModel(
        id: '132',
        quantity: 150,
        stockLocation: '',
        variantId: '132',
        limitStock: 150),
    StockModel(
        id: '133',
        quantity: 75,
        stockLocation: '',
        variantId: '133',
        limitStock: 75),
    StockModel(
        id: '134',
        quantity: 50,
        stockLocation: '',
        variantId: '134',
        limitStock: 50),
    StockModel(
        id: '135',
        quantity: 200,
        stockLocation: '',
        variantId: '135',
        limitStock: 200),
    StockModel(
        id: '136',
        quantity: 120,
        stockLocation: '',
        variantId: '136',
        limitStock: 120),
    StockModel(
        id: '137',
        quantity: 90,
        stockLocation: '',
        variantId: '137',
        limitStock: 90),
    StockModel(
        id: '138',
        quantity: 5,
        stockLocation: '',
        variantId: '138',
        limitStock: 5),
    StockModel(
        id: '139',
        quantity: 60,
        stockLocation: '',
        variantId: '139',
        limitStock: 60),
    StockModel(
        id: '140',
        quantity: 200,
        stockLocation: '',
        variantId: '140',
        limitStock: 200),
    StockModel(
        id: '141',
        quantity: 100,
        stockLocation: '',
        variantId: '141',
        limitStock: 100),
    StockModel(
        id: '142',
        quantity: 150,
        stockLocation: '',
        variantId: '142',
        limitStock: 150),
    StockModel(
        id: '143',
        quantity: 75,
        stockLocation: '',
        variantId: '143',
        limitStock: 75),
    StockModel(
        id: '144',
        quantity: 50,
        stockLocation: '',
        variantId: '144',
        limitStock: 50),
    StockModel(
        id: '145',
        quantity: 200,
        stockLocation: '',
        variantId: '145',
        limitStock: 200),
    StockModel(
        id: '146',
        quantity: 120,
        stockLocation: '',
        variantId: '146',
        limitStock: 120),
    StockModel(
        id: '147',
        quantity: 90,
        stockLocation: '',
        variantId: '147',
        limitStock: 90),
    StockModel(
        id: '148',
        quantity: 5,
        stockLocation: '',
        variantId: '148',
        limitStock: 5),
    StockModel(
        id: '149',
        quantity: 60,
        stockLocation: '',
        variantId: '149',
        limitStock: 60),
    StockModel(
        id: '150',
        quantity: 200,
        stockLocation: '',
        variantId: '150',
        limitStock: 200),
    StockModel(
        id: '151',
        quantity: 100,
        stockLocation: '',
        variantId: '151',
        limitStock: 100),
    StockModel(
        id: '152',
        quantity: 150,
        stockLocation: '',
        variantId: '152',
        limitStock: 150),
    StockModel(
        id: '153',
        quantity: 75,
        stockLocation: '',
        variantId: '153',
        limitStock: 75),
    StockModel(
        id: '154',
        quantity: 50,
        stockLocation: '',
        variantId: '154',
        limitStock: 50),
    StockModel(
        id: '155',
        quantity: 200,
        stockLocation: '',
        variantId: '155',
        limitStock: 200),
    StockModel(
        id: '156',
        quantity: 120,
        stockLocation: '',
        variantId: '156',
        limitStock: 120),
    StockModel(
        id: '157',
        quantity: 90,
        stockLocation: '',
        variantId: '157',
        limitStock: 90),
    StockModel(
        id: '158',
        quantity: 5,
        stockLocation: '',
        variantId: '158',
        limitStock: 5),
    StockModel(
        id: '159',
        quantity: 60,
        stockLocation: '',
        variantId: '159',
        limitStock: 60),
    StockModel(
        id: '160',
        quantity: 200,
        stockLocation: '',
        variantId: '160',
        limitStock: 200),
    StockModel(
        id: '161',
        quantity: 100,
        stockLocation: '',
        variantId: '161',
        limitStock: 100),
    StockModel(
        id: '162',
        quantity: 150,
        stockLocation: '',
        variantId: '162',
        limitStock: 150),
    StockModel(
        id: '163',
        quantity: 75,
        stockLocation: '',
        variantId: '163',
        limitStock: 75),
    StockModel(
        id: '164',
        quantity: 50,
        stockLocation: '',
        variantId: '164',
        limitStock: 50),
    StockModel(
        id: '165',
        quantity: 200,
        stockLocation: '',
        variantId: '165',
        limitStock: 200),
    StockModel(
        id: '166',
        quantity: 120,
        stockLocation: '',
        variantId: '166',
        limitStock: 120),
    StockModel(
        id: '167',
        quantity: 90,
        stockLocation: '',
        variantId: '167',
        limitStock: 90),
    StockModel(
        id: '168',
        quantity: 5,
        stockLocation: '',
        variantId: '168',
        limitStock: 5),
    StockModel(
        id: '169',
        quantity: 60,
        stockLocation: '',
        variantId: '169',
        limitStock: 60),
    StockModel(
        id: '170',
        quantity: 200,
        stockLocation: '',
        variantId: '170',
        limitStock: 200),
    StockModel(
        id: '171',
        quantity: 100,
        stockLocation: '',
        variantId: '171',
        limitStock: 100),
    StockModel(
        id: '172',
        quantity: 150,
        stockLocation: '',
        variantId: '172',
        limitStock: 150),
    StockModel(
        id: '173',
        quantity: 75,
        stockLocation: '',
        variantId: '173',
        limitStock: 75),
    StockModel(
        id: '174',
        quantity: 50,
        stockLocation: '',
        variantId: '174',
        limitStock: 50),
    StockModel(
        id: '175',
        quantity: 200,
        stockLocation: '',
        variantId: '175',
        limitStock: 200),
    StockModel(
        id: '176',
        quantity: 120,
        stockLocation: '',
        variantId: '176',
        limitStock: 120),
    StockModel(
        id: '177',
        quantity: 90,
        stockLocation: '',
        variantId: '177',
        limitStock: 90),
    StockModel(
        id: '178',
        quantity: 5,
        stockLocation: '',
        variantId: '178',
        limitStock: 5),
    StockModel(
        id: '179',
        quantity: 60,
        stockLocation: '',
        variantId: '179',
        limitStock: 60),
    StockModel(
        id: '180',
        quantity: 200,
        stockLocation: '',
        variantId: '180',
        limitStock: 200),
    StockModel(
        id: '181',
        quantity: 100,
        stockLocation: '',
        variantId: '181',
        limitStock: 100),
    StockModel(
        id: '182',
        quantity: 150,
        stockLocation: '',
        variantId: '182',
        limitStock: 150),
    StockModel(
        id: '183',
        quantity: 75,
        stockLocation: '',
        variantId: '183',
        limitStock: 75),
    StockModel(
        id: '184',
        quantity: 50,
        stockLocation: '',
        variantId: '184',
        limitStock: 50),
    StockModel(
        id: '185',
        quantity: 200,
        stockLocation: '',
        variantId: '185',
        limitStock: 200),
    StockModel(
        id: '186',
        quantity: 120,
        stockLocation: '',
        variantId: '186',
        limitStock: 120),
    StockModel(
        id: '187',
        quantity: 90,
        stockLocation: '',
        variantId: '187',
        limitStock: 90),
    StockModel(
        id: '188',
        quantity: 5,
        stockLocation: '',
        variantId: '188',
        limitStock: 5),
    StockModel(
        id: '189',
        quantity: 60,
        stockLocation: '',
        variantId: '189',
        limitStock: 60),
    StockModel(
        id: '190',
        quantity: 200,
        stockLocation: '',
        variantId: '190',
        limitStock: 200),
    StockModel(
        id: '191',
        quantity: 100,
        stockLocation: '',
        variantId: '191',
        limitStock: 100),
    StockModel(
        id: '192',
        quantity: 150,
        stockLocation: '',
        variantId: '192',
        limitStock: 150),
    StockModel(
        id: '193',
        quantity: 75,
        stockLocation: '',
        variantId: '193',
        limitStock: 75),
    StockModel(
        id: '194',
        quantity: 50,
        stockLocation: '',
        variantId: '194',
        limitStock: 50),
    StockModel(
        id: '195',
        quantity: 200,
        stockLocation: '',
        variantId: '195',
        limitStock: 200),
    StockModel(
        id: '196',
        quantity: 120,
        stockLocation: '',
        variantId: '196',
        limitStock: 120),
    StockModel(
        id: '197',
        quantity: 90,
        stockLocation: '',
        variantId: '197',
        limitStock: 90),
    StockModel(
        id: '198',
        quantity: 5,
        stockLocation: '',
        variantId: '198',
        limitStock: 5),
    StockModel(
        id: '199',
        quantity: 60,
        stockLocation: '',
        variantId: '199',
        limitStock: 60),
    StockModel(
        id: '200',
        quantity: 200,
        stockLocation: '',
        variantId: '200',
        limitStock: 200),
    StockModel(
        id: '201',
        quantity: 100,
        stockLocation: '',
        variantId: '201',
        limitStock: 100),
    StockModel(
        id: '202',
        quantity: 150,
        stockLocation: '',
        variantId: '202',
        limitStock: 150),
    StockModel(
        id: '203',
        quantity: 75,
        stockLocation: '',
        variantId: '203',
        limitStock: 75),
    StockModel(
        id: '204',
        quantity: 50,
        stockLocation: '',
        variantId: '204',
        limitStock: 50),
    StockModel(
        id: '205',
        quantity: 200,
        stockLocation: '',
        variantId: '205',
        limitStock: 200),
    StockModel(
        id: '206',
        quantity: 120,
        stockLocation: '',
        variantId: '206',
        limitStock: 120),
    StockModel(
        id: '207',
        quantity: 90,
        stockLocation: '',
        variantId: '207',
        limitStock: 90),
    StockModel(
        id: '208',
        quantity: 5,
        stockLocation: '',
        variantId: '208',
        limitStock: 5),
    StockModel(
        id: '209',
        quantity: 60,
        stockLocation: '',
        variantId: '209',
        limitStock: 60),
    StockModel(
        id: '210',
        quantity: 200,
        stockLocation: '',
        variantId: '210',
        limitStock: 200),
    StockModel(
        id: '211',
        quantity: 100,
        stockLocation: '',
        variantId: '211',
        limitStock: 100),
    StockModel(
        id: '212',
        quantity: 150,
        stockLocation: '',
        variantId: '212',
        limitStock: 150),
    StockModel(
        id: '213',
        quantity: 75,
        stockLocation: '',
        variantId: '213',
        limitStock: 75),
    StockModel(
        id: '214',
        quantity: 50,
        stockLocation: '',
        variantId: '214',
        limitStock: 50),
    StockModel(
        id: '215',
        quantity: 200,
        stockLocation: '',
        variantId: '215',
        limitStock: 200),
    StockModel(
        id: '216',
        quantity: 120,
        stockLocation: '',
        variantId: '216',
        limitStock: 120),
    StockModel(
        id: '217',
        quantity: 90,
        stockLocation: '',
        variantId: '217',
        limitStock: 90),
    StockModel(
        id: '218',
        quantity: 5,
        stockLocation: '',
        variantId: '218',
        limitStock: 5),
    StockModel(
        id: '219',
        quantity: 60,
        stockLocation: '',
        variantId: '219',
        limitStock: 60),
    StockModel(
        id: '220',
        quantity: 200,
        stockLocation: '',
        variantId: '220',
        limitStock: 200),
    StockModel(
        id: '221',
        quantity: 100,
        stockLocation: '',
        variantId: '221',
        limitStock: 100),
    StockModel(
        id: '222',
        quantity: 150,
        stockLocation: '',
        variantId: '222',
        limitStock: 150),
    StockModel(
        id: '223',
        quantity: 75,
        stockLocation: '',
        variantId: '223',
        limitStock: 75),
    StockModel(
        id: '224',
        quantity: 50,
        stockLocation: '',
        variantId: '224',
        limitStock: 50),
    StockModel(
        id: '225',
        quantity: 200,
        stockLocation: '',
        variantId: '225',
        limitStock: 200),
    StockModel(
        id: '226',
        quantity: 120,
        stockLocation: '',
        variantId: '226',
        limitStock: 120),
    StockModel(
        id: '227',
        quantity: 90,
        stockLocation: '',
        variantId: '227',
        limitStock: 90),
    StockModel(
        id: '228',
        quantity: 5,
        stockLocation: '',
        variantId: '228',
        limitStock: 5),
    StockModel(
        id: '229',
        quantity: 60,
        stockLocation: '',
        variantId: '229',
        limitStock: 60),
    StockModel(
        id: '230',
        quantity: 200,
        stockLocation: '',
        variantId: '230',
        limitStock: 200),
    StockModel(
        id: '231',
        quantity: 100,
        stockLocation: '',
        variantId: '231',
        limitStock: 100),
    StockModel(
        id: '232',
        quantity: 150,
        stockLocation: '',
        variantId: '232',
        limitStock: 150),
    StockModel(
        id: '233',
        quantity: 75,
        stockLocation: '',
        variantId: '233',
        limitStock: 75),
    StockModel(
        id: '234',
        quantity: 50,
        stockLocation: '',
        variantId: '234',
        limitStock: 50),
    StockModel(
        id: '235',
        quantity: 200,
        stockLocation: '',
        variantId: '235',
        limitStock: 200),
    StockModel(
        id: '236',
        quantity: 120,
        stockLocation: '',
        variantId: '236',
        limitStock: 120),
    StockModel(
        id: '237',
        quantity: 90,
        stockLocation: '',
        variantId: '237',
        limitStock: 90),
    StockModel(
        id: '238',
        quantity: 5,
        stockLocation: '',
        variantId: '238',
        limitStock: 5),
    StockModel(
        id: '239',
        quantity: 60,
        stockLocation: '',
        variantId: '239',
        limitStock: 60),
    StockModel(
        id: '240',
        quantity: 200,
        stockLocation: '',
        variantId: '240',
        limitStock: 200),
    StockModel(
        id: '241',
        quantity: 100,
        stockLocation: '',
        variantId: '241',
        limitStock: 100),
    StockModel(
        id: '242',
        quantity: 150,
        stockLocation: '',
        variantId: '242',
        limitStock: 150),
    StockModel(
        id: '243',
        quantity: 75,
        stockLocation: '',
        variantId: '243',
        limitStock: 75),
    StockModel(
        id: '244',
        quantity: 50,
        stockLocation: '',
        variantId: '244',
        limitStock: 50),
    StockModel(
        id: '245',
        quantity: 200,
        stockLocation: '',
        variantId: '245',
        limitStock: 200),
    StockModel(
        id: '246',
        quantity: 120,
        stockLocation: '',
        variantId: '246',
        limitStock: 120),
    StockModel(
        id: '247',
        quantity: 90,
        stockLocation: '',
        variantId: '247',
        limitStock: 90),
    StockModel(
        id: '248',
        quantity: 5,
        stockLocation: '',
        variantId: '248',
        limitStock: 5),
    StockModel(
        id: '249',
        quantity: 60,
        stockLocation: '',
        variantId: '249',
        limitStock: 60),
    StockModel(
        id: '250',
        quantity: 200,
        stockLocation: '',
        variantId: '250',
        limitStock: 200),
    StockModel(
        id: '251',
        quantity: 100,
        stockLocation: '',
        variantId: '251',
        limitStock: 100),
    StockModel(
        id: '252',
        quantity: 150,
        stockLocation: '',
        variantId: '252',
        limitStock: 150),
    StockModel(
        id: '253',
        quantity: 75,
        stockLocation: '',
        variantId: '253',
        limitStock: 75),
    StockModel(
        id: '254',
        quantity: 50,
        stockLocation: '',
        variantId: '254',
        limitStock: 50),
    StockModel(
        id: '255',
        quantity: 200,
        stockLocation: '',
        variantId: '255',
        limitStock: 200),
    StockModel(
        id: '256',
        quantity: 120,
        stockLocation: '',
        variantId: '256',
        limitStock: 120),
    StockModel(
        id: '257',
        quantity: 90,
        stockLocation: '',
        variantId: '257',
        limitStock: 90),
    StockModel(
        id: '258',
        quantity: 5,
        stockLocation: '',
        variantId: '258',
        limitStock: 5),
    StockModel(
        id: '259',
        quantity: 60,
        stockLocation: '',
        variantId: '259',
        limitStock: 60),
    StockModel(
        id: '260',
        quantity: 200,
        stockLocation: '',
        variantId: '260',
        limitStock: 200),
    StockModel(
        id: '261',
        quantity: 100,
        stockLocation: '',
        variantId: '261',
        limitStock: 100),
    StockModel(
        id: '262',
        quantity: 150,
        stockLocation: '',
        variantId: '262',
        limitStock: 150),
    StockModel(
        id: '263',
        quantity: 75,
        stockLocation: '',
        variantId: '263',
        limitStock: 75),
    StockModel(
        id: '264',
        quantity: 50,
        stockLocation: '',
        variantId: '264',
        limitStock: 50),
    StockModel(
        id: '265',
        quantity: 200,
        stockLocation: '',
        variantId: '265',
        limitStock: 200),
    StockModel(
        id: '266',
        quantity: 120,
        stockLocation: '',
        variantId: '266',
        limitStock: 120),
    StockModel(
        id: '267',
        quantity: 90,
        stockLocation: '',
        variantId: '267',
        limitStock: 90),
    StockModel(
        id: '268',
        quantity: 5,
        stockLocation: '',
        variantId: '268',
        limitStock: 5),
    StockModel(
        id: '269',
        quantity: 60,
        stockLocation: '',
        variantId: '269',
        limitStock: 60),
    StockModel(
        id: '270',
        quantity: 200,
        stockLocation: '',
        variantId: '270',
        limitStock: 200),
    StockModel(
        id: '271',
        quantity: 100,
        stockLocation: '',
        variantId: '271',
        limitStock: 100),
    StockModel(
        id: '272',
        quantity: 150,
        stockLocation: '',
        variantId: '272',
        limitStock: 150),
    StockModel(
        id: '273',
        quantity: 75,
        stockLocation: '',
        variantId: '273',
        limitStock: 75),
    StockModel(
        id: '274',
        quantity: 50,
        stockLocation: '',
        variantId: '274',
        limitStock: 50),
    StockModel(
        id: '275',
        quantity: 200,
        stockLocation: '',
        variantId: '275',
        limitStock: 200),
    StockModel(
        id: '276',
        quantity: 120,
        stockLocation: '',
        variantId: '276',
        limitStock: 120),
    StockModel(
        id: '277',
        quantity: 90,
        stockLocation: '',
        variantId: '277',
        limitStock: 90),
    StockModel(
        id: '278',
        quantity: 5,
        stockLocation: '',
        variantId: '278',
        limitStock: 5),
    StockModel(
        id: '279',
        quantity: 60,
        stockLocation: '',
        variantId: '279',
        limitStock: 60),
    StockModel(
        id: '280',
        quantity: 200,
        stockLocation: '',
        variantId: '280',
        limitStock: 200),
    StockModel(
        id: '281',
        quantity: 100,
        stockLocation: '',
        variantId: '281',
        limitStock: 100),
    StockModel(
        id: '282',
        quantity: 150,
        stockLocation: '',
        variantId: '282',
        limitStock: 150),
    StockModel(
        id: '283',
        quantity: 75,
        stockLocation: '',
        variantId: '283',
        limitStock: 75),
    StockModel(
        id: '284',
        quantity: 50,
        stockLocation: '',
        variantId: '284',
        limitStock: 50),
    StockModel(
        id: '285',
        quantity: 200,
        stockLocation: '',
        variantId: '285',
        limitStock: 200),
    StockModel(
        id: '286',
        quantity: 120,
        stockLocation: '',
        variantId: '286',
        limitStock: 120),
    StockModel(
        id: '287',
        quantity: 90,
        stockLocation: '',
        variantId: '287',
        limitStock: 90),
    StockModel(
        id: '288',
        quantity: 5,
        stockLocation: '',
        variantId: '288',
        limitStock: 5),
    StockModel(
        id: '289',
        quantity: 60,
        stockLocation: '',
        variantId: '289',
        limitStock: 60),
    StockModel(
        id: '290',
        quantity: 200,
        stockLocation: '',
        variantId: '290',
        limitStock: 200),
    StockModel(
        id: '291',
        quantity: 100,
        stockLocation: '',
        variantId: '291',
        limitStock: 100),
    StockModel(
        id: '292',
        quantity: 150,
        stockLocation: '',
        variantId: '292',
        limitStock: 150),
    StockModel(
        id: '293',
        quantity: 75,
        stockLocation: '',
        variantId: '293',
        limitStock: 75),
    StockModel(
        id: '294',
        quantity: 50,
        stockLocation: '',
        variantId: '294',
        limitStock: 50),
    StockModel(
        id: '295',
        quantity: 200,
        stockLocation: '',
        variantId: '295',
        limitStock: 200),
    StockModel(
        id: '296',
        quantity: 120,
        stockLocation: '',
        variantId: '296',
        limitStock: 120),
    StockModel(
        id: '297',
        quantity: 90,
        stockLocation: '',
        variantId: '297',
        limitStock: 90),
    StockModel(
        id: '298',
        quantity: 5,
        stockLocation: '',
        variantId: '298',
        limitStock: 5),
    StockModel(
        id: '299',
        quantity: 60,
        stockLocation: '',
        variantId: '299',
        limitStock: 60),
    StockModel(
        id: '300',
        quantity: 200,
        stockLocation: '',
        variantId: '300',
        limitStock: 200),
    StockModel(
        id: '301',
        quantity: 100,
        stockLocation: '',
        variantId: '301',
        limitStock: 100),
    StockModel(
        id: '302',
        quantity: 150,
        stockLocation: '',
        variantId: '302',
        limitStock: 150),
    StockModel(
        id: '303',
        quantity: 75,
        stockLocation: '',
        variantId: '303',
        limitStock: 75),
    StockModel(
        id: '304',
        quantity: 50,
        stockLocation: '',
        variantId: '304',
        limitStock: 50),
    StockModel(
        id: '305',
        quantity: 200,
        stockLocation: '',
        variantId: '305',
        limitStock: 200),
    StockModel(
        id: '306',
        quantity: 120,
        stockLocation: '',
        variantId: '306',
        limitStock: 120),
    StockModel(
        id: '307',
        quantity: 90,
        stockLocation: '',
        variantId: '307',
        limitStock: 90),
    StockModel(
        id: '308',
        quantity: 5,
        stockLocation: '',
        variantId: '308',
        limitStock: 5),
    StockModel(
        id: '309',
        quantity: 60,
        stockLocation: '',
        variantId: '309',
        limitStock: 60),
    StockModel(
        id: '310',
        quantity: 200,
        stockLocation: '',
        variantId: '310',
        limitStock: 200),
    StockModel(
        id: '311',
        quantity: 100,
        stockLocation: '',
        variantId: '311',
        limitStock: 100),
    StockModel(
        id: '312',
        quantity: 150,
        stockLocation: '',
        variantId: '312',
        limitStock: 150),
    StockModel(
        id: '313',
        quantity: 75,
        stockLocation: '',
        variantId: '313',
        limitStock: 75),
    StockModel(
        id: '314',
        quantity: 50,
        stockLocation: '',
        variantId: '314',
        limitStock: 50),
    StockModel(
        id: '315',
        quantity: 200,
        stockLocation: '',
        variantId: '315',
        limitStock: 200),
    StockModel(
        id: '316',
        quantity: 120,
        stockLocation: '',
        variantId: '316',
        limitStock: 120),
    StockModel(
        id: '317',
        quantity: 90,
        stockLocation: '',
        variantId: '317',
        limitStock: 90),
    StockModel(
        id: '318',
        quantity: 5,
        stockLocation: '',
        variantId: '318',
        limitStock: 5),
    StockModel(
        id: '319',
        quantity: 60,
        stockLocation: '',
        variantId: '319',
        limitStock: 60),
    StockModel(
        id: '320',
        quantity: 200,
        stockLocation: '',
        variantId: '320',
        limitStock: 200),
    StockModel(
        id: '321',
        quantity: 100,
        stockLocation: '',
        variantId: '321',
        limitStock: 100),
    StockModel(
        id: '322',
        quantity: 150,
        stockLocation: '',
        variantId: '322',
        limitStock: 150),
    StockModel(
        id: '323',
        quantity: 75,
        stockLocation: '',
        variantId: '323',
        limitStock: 75),
    StockModel(
        id: '324',
        quantity: 50,
        stockLocation: '',
        variantId: '324',
        limitStock: 50),
    StockModel(
        id: '325',
        quantity: 200,
        stockLocation: '',
        variantId: '325',
        limitStock: 200),
    StockModel(
        id: '326',
        quantity: 120,
        stockLocation: '',
        variantId: '326',
        limitStock: 120),
    StockModel(
        id: '327',
        quantity: 90,
        stockLocation: '',
        variantId: '327',
        limitStock: 90),
    StockModel(
        id: '328',
        quantity: 5,
        stockLocation: '',
        variantId: '328',
        limitStock: 5),
    StockModel(
        id: '329',
        quantity: 60,
        stockLocation: '',
        variantId: '329',
        limitStock: 60),
    StockModel(
        id: '330',
        quantity: 200,
        stockLocation: '',
        variantId: '330',
        limitStock: 200),
    StockModel(
        id: '331',
        quantity: 100,
        stockLocation: '',
        variantId: '331',
        limitStock: 100),
    StockModel(
        id: '332',
        quantity: 150,
        stockLocation: '',
        variantId: '332',
        limitStock: 150),
    StockModel(
        id: '333',
        quantity: 75,
        stockLocation: '',
        variantId: '333',
        limitStock: 75),
    StockModel(
        id: '334',
        quantity: 50,
        stockLocation: '',
        variantId: '334',
        limitStock: 50),
    StockModel(
        id: '335',
        quantity: 200,
        stockLocation: '',
        variantId: '335',
        limitStock: 200),
    StockModel(
        id: '336',
        quantity: 120,
        stockLocation: '',
        variantId: '336',
        limitStock: 120),
    StockModel(
        id: '337',
        quantity: 90,
        stockLocation: '',
        variantId: '337',
        limitStock: 90),
    StockModel(
        id: '338',
        quantity: 5,
        stockLocation: '',
        variantId: '338',
        limitStock: 5),
    StockModel(
        id: '339',
        quantity: 60,
        stockLocation: '',
        variantId: '339',
        limitStock: 60),
    StockModel(
        id: '340',
        quantity: 200,
        stockLocation: '',
        variantId: '340',
        limitStock: 200),
    StockModel(
        id: '341',
        quantity: 100,
        stockLocation: '',
        variantId: '341',
        limitStock: 100),
    StockModel(
        id: '342',
        quantity: 150,
        stockLocation: '',
        variantId: '342',
        limitStock: 150),
    StockModel(
        id: '343',
        quantity: 75,
        stockLocation: '',
        variantId: '343',
        limitStock: 75),
    StockModel(
        id: '344',
        quantity: 50,
        stockLocation: '',
        variantId: '344',
        limitStock: 50),
    StockModel(
        id: '345',
        quantity: 200,
        stockLocation: '',
        variantId: '345',
        limitStock: 200),
    StockModel(
        id: '346',
        quantity: 120,
        stockLocation: '',
        variantId: '346',
        limitStock: 120),
    StockModel(
        id: '347',
        quantity: 90,
        stockLocation: '',
        variantId: '347',
        limitStock: 90),
    StockModel(
        id: '348',
        quantity: 5,
        stockLocation: '',
        variantId: '348',
        limitStock: 5),
    StockModel(
        id: '349',
        quantity: 60,
        stockLocation: '',
        variantId: '349',
        limitStock: 60),
    StockModel(
        id: '350',
        quantity: 200,
        stockLocation: '',
        variantId: '350',
        limitStock: 200),
    StockModel(
        id: '351',
        quantity: 100,
        stockLocation: '',
        variantId: '351',
        limitStock: 100),
    StockModel(
        id: '352',
        quantity: 150,
        stockLocation: '',
        variantId: '352',
        limitStock: 150),
    StockModel(
        id: '353',
        quantity: 75,
        stockLocation: '',
        variantId: '353',
        limitStock: 75),
    StockModel(
        id: '354',
        quantity: 50,
        stockLocation: '',
        variantId: '354',
        limitStock: 50),
    StockModel(
        id: '355',
        quantity: 200,
        stockLocation: '',
        variantId: '355',
        limitStock: 200),
    StockModel(
        id: '356',
        quantity: 120,
        stockLocation: '',
        variantId: '356',
        limitStock: 120),
    StockModel(
        id: '357',
        quantity: 90,
        stockLocation: '',
        variantId: '357',
        limitStock: 90),
    StockModel(
        id: '358',
        quantity: 5,
        stockLocation: '',
        variantId: '358',
        limitStock: 5),
    StockModel(
        id: '359',
        quantity: 60,
        stockLocation: '',
        variantId: '359',
        limitStock: 60),
    StockModel(
        id: '360',
        quantity: 200,
        stockLocation: '',
        variantId: '360',
        limitStock: 200),
    StockModel(
        id: '361',
        quantity: 100,
        stockLocation: '',
        variantId: '361',
        limitStock: 100),
    StockModel(
        id: '362',
        quantity: 150,
        stockLocation: '',
        variantId: '362',
        limitStock: 150),
    StockModel(
        id: '363',
        quantity: 75,
        stockLocation: '',
        variantId: '363',
        limitStock: 75),
    StockModel(
        id: '364',
        quantity: 50,
        stockLocation: '',
        variantId: '364',
        limitStock: 50),
    StockModel(
        id: '365',
        quantity: 200,
        stockLocation: '',
        variantId: '365',
        limitStock: 200),
    StockModel(
        id: '366',
        quantity: 120,
        stockLocation: '',
        variantId: '366',
        limitStock: 120),
    StockModel(
        id: '367',
        quantity: 90,
        stockLocation: '',
        variantId: '367',
        limitStock: 90),
    StockModel(
        id: '368',
        quantity: 5,
        stockLocation: '',
        variantId: '368',
        limitStock: 5),
    StockModel(
        id: '369',
        quantity: 60,
        stockLocation: '',
        variantId: '369',
        limitStock: 60),
    StockModel(
        id: '370',
        quantity: 200,
        stockLocation: '',
        variantId: '370',
        limitStock: 200),
    StockModel(
        id: '371',
        quantity: 100,
        stockLocation: '',
        variantId: '371',
        limitStock: 100),
    StockModel(
        id: '372',
        quantity: 150,
        stockLocation: '',
        variantId: '372',
        limitStock: 150),
    StockModel(
        id: '373',
        quantity: 75,
        stockLocation: '',
        variantId: '373',
        limitStock: 75),
    StockModel(
        id: '374',
        quantity: 50,
        stockLocation: '',
        variantId: '374',
        limitStock: 50),
    StockModel(
        id: '375',
        quantity: 200,
        stockLocation: '',
        variantId: '375',
        limitStock: 200),
    StockModel(
        id: '376',
        quantity: 120,
        stockLocation: '',
        variantId: '376',
        limitStock: 120),
    StockModel(
        id: '377',
        quantity: 90,
        stockLocation: '',
        variantId: '377',
        limitStock: 90),
    StockModel(
        id: '378',
        quantity: 5,
        stockLocation: '',
        variantId: '378',
        limitStock: 5),
    StockModel(
        id: '379',
        quantity: 60,
        stockLocation: '',
        variantId: '379',
        limitStock: 60),
    StockModel(
        id: '380',
        quantity: 200,
        stockLocation: '',
        variantId: '380',
        limitStock: 200),
    StockModel(
        id: '381',
        quantity: 100,
        stockLocation: '',
        variantId: '381',
        limitStock: 100),
    StockModel(
        id: '382',
        quantity: 150,
        stockLocation: '',
        variantId: '382',
        limitStock: 150),
    StockModel(
        id: '383',
        quantity: 75,
        stockLocation: '',
        variantId: '383',
        limitStock: 75),
    StockModel(
        id: '384',
        quantity: 50,
        stockLocation: '',
        variantId: '384',
        limitStock: 50),
    StockModel(
        id: '385',
        quantity: 200,
        stockLocation: '',
        variantId: '385',
        limitStock: 200),
    StockModel(
        id: '386',
        quantity: 120,
        stockLocation: '',
        variantId: '386',
        limitStock: 120),
    StockModel(
        id: '387',
        quantity: 90,
        stockLocation: '',
        variantId: '387',
        limitStock: 90),
    StockModel(
        id: '388',
        quantity: 5,
        stockLocation: '',
        variantId: '388',
        limitStock: 5),
    StockModel(
        id: '389',
        quantity: 60,
        stockLocation: '',
        variantId: '389',
        limitStock: 60),
    StockModel(
        id: '390',
        quantity: 200,
        stockLocation: '',
        variantId: '390',
        limitStock: 200),
    StockModel(
        id: '391',
        quantity: 100,
        stockLocation: '',
        variantId: '391',
        limitStock: 100),
    StockModel(
        id: '392',
        quantity: 150,
        stockLocation: '',
        variantId: '392',
        limitStock: 150),
    StockModel(
        id: '393',
        quantity: 75,
        stockLocation: '',
        variantId: '393',
        limitStock: 75),
    StockModel(
        id: '394',
        quantity: 50,
        stockLocation: '',
        variantId: '394',
        limitStock: 50),
    StockModel(
        id: '395',
        quantity: 200,
        stockLocation: '',
        variantId: '395',
        limitStock: 200),
  ];
}

class LineItemDatabase {
  LineItemDatabase._privateInstance();
  static final LineItemDatabase _instance = LineItemDatabase._privateInstance();
  static LineItemDatabase get instance => _instance;
  List<LineItemModel> lineItems = [];
}

class OrderDatabase {
  OrderDatabase._privateInstance();
  static final OrderDatabase _instance = OrderDatabase._privateInstance();
  static OrderDatabase get instance => _instance;
  List<OrderModel> orders = [];
}

class PaymentDatabase {
  PaymentDatabase._privateInstance();
  static final PaymentDatabase _instance = PaymentDatabase._privateInstance();
  static PaymentDatabase get instance => _instance;
  List<PaymentModel> payments = [];
}

class UserDatabase {
  UserDatabase._privateInstance();
  static final UserDatabase _instance = UserDatabase._privateInstance();
  static UserDatabase get instance => _instance;

  List<UserModel> users = [
    UserModel(
      id: '1',
      name: 'Mengthong Ly',
      firstName: 'Mengthong',
      lastName: 'ly',
      email: 'mengthong@example.com',
      password: '123',
      role: UserRoleModel.admin,
    ),
    UserModel(
      id: '2',
      name: 'Lylin Ho',
      firstName: 'lylin',
      lastName: 'ho',
      email: 'lylin@example.com',
      password: '123',
      role: UserRoleModel.admin,
    ),
  ];
}
