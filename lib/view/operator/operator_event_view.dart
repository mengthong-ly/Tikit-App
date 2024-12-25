import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_provider.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/viewModels/taxon_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorEventView extends StatefulWidget {
  const OperatorEventView({super.key});

  @override
  State<OperatorEventView> createState() => _OperatorEventViewState();
}

class _OperatorEventViewState extends State<OperatorEventView> {
  late List<TaxonModel> taxons;
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> onTap(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorEventForm(mode: FormMode.create);
      },
    ));
    load();
  }

  Future<void> onEdit(TaxonModel model) async {
    final TaxonModel? tempTaxon = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return OperatorEventForm(
            mode: FormMode.edit,
            taxon: model,
          );
        },
      ),
    );
    if (tempTaxon != null) {
      await context.read<TaxonModelProvider>().service.updateTaxon(tempTaxon);
      load();
    }
  }

  void load() {
    setState(() {
      taxons = context.read<OperatorProvider>().service.getAllEvents();
    });
  }

  void onDelete(TaxonModel taxon) async {
    await context.read<TaxonModelProvider>().removeTaxonById(taxon.id);
    setState(() {
      load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: 'Event',
      bottom: GestureDetector(
        onTap: () => onTap(context),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xff16A34A),
          ),
          height: 70,
          child: const Text(
            'Create a new Event',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: ListView.builder(
          itemCount: taxons.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onEdit(taxons[index]),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                width: MediaQuery.of(context).size.width - 40,
                height: 40,
                child: Row(
                  children: [
                    Text(
                      '${index + 1}. ',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      taxons[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () => onDelete(taxons[index]),
                        icon: const Icon(Icons.delete))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
