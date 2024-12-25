import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/models/taxon_type.dart';
import 'package:event_with_thong/view/components/event_card.dart';
import 'package:event_with_thong/view/components/event_display.dart';
import 'package:event_with_thong/view/components/t_text_form_field.dart';
import 'package:event_with_thong/viewModels/product_provider.dart';
import 'package:event_with_thong/viewModels/taxon_provider.dart';
import 'package:event_with_thong/view/components/event_sliver_app_bar.dart';
import 'package:event_with_thong/view/pages/product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventHomePage extends StatefulWidget {
  const EventHomePage({super.key});

  @override
  State<EventHomePage> createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController tabController;
  late List<TaxonModel> taxons;
  late Future<void> _loadTaxonFuture;
  late bool isSearch = false;

  List<TaxonModel> filterTaxons = [];

  @override
  void initState() {
    super.initState();
    _loadTaxonFuture = loadTaxon();
  }

  bool isCollapsed = false;
  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  void onEventClick(TaxonModel taxon) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => ProductView(
                  model: taxon,
                )));
  }

  Future<void> loadTaxon() async {
    await context.read<TaxonModelProvider>().load();
    await context.read<ProductModelProvider>().load();
    taxons = await context.read<TaxonModelProvider>().getAllTaxon();
  }

  void triggerIsSearch() {
    setState(() => isSearch = !isSearch);
  }

  void _runFilter(String? searchValue) {
    print('hiiii');
    if (searchValue != null && searchValue.length >= 3) {
      setState(() {
        isSearch = true;
      });
      filterTaxons = taxons
          .where((taxon) =>
              taxon.name.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
    } else if (searchValue != null && searchValue.isEmpty) {
      setState(() {
        isSearch = false;
      });
      filterTaxons = [];
    }
  }

  List<Widget> get display => isSearch
      ? [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: EventCard(
                      taxon: filterTaxons[index], onEventClick: onEventClick),
                );
              },
              childCount: filterTaxons.length,
            ),
          ),
          EventDisplay(
            onEventClick: onEventClick,
            taxons: context.read<TaxonModelProvider>().featureTaxons,
            title: 'Recommand for you',
          ),
        ]
      : [
          EventDisplay(
            onEventClick: onEventClick,
            taxons: context.read<TaxonModelProvider>().featureTaxons,
            title: 'Feature',
          ),
          EventDisplay(
            onEventClick: onEventClick,
            taxons: taxons,
            title: 'Event',
          ),
          ...buildCategoryEvent()
        ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadTaxonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CustomScrollView(
            slivers: [
              EventSliverAppBar(
                isCollapsed: isCollapsed,
                onCollapsed: onCollapsed,
                welcomeText: 'Hi👋🏻\nUser',
                isOperator: false,
              ),
              SliverToBoxAdapter(
                  child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TTextFormField(
                    label: 'Search',
                    hint: 'The Q',
                    onChange: (newValue) => _runFilter(newValue),
                  ),
                ),
              )),
              ...display
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<Widget> buildCategoryEvent() {
    const List<TaxonType> taxonTypes = TaxonType.values;
    return taxonTypes.map(
      (taxonType) {
        final filteredTaxons =
            context.watch<TaxonModelProvider>().getFilteredTaxon(taxonType);
        //  display nothing if there is no event
        if (filteredTaxons.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        // display event
        return EventDisplay(
            taxons: filteredTaxons,
            onEventClick: onEventClick,
            title: taxonType.typeString);
      },
    ).toList();
  }
}
