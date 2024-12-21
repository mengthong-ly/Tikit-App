import 'package:event_with_thong/models/vendor.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/view/operator/operator_vendor_form.dart';
import 'package:event_with_thong/viewModels/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorVendorView extends StatefulWidget {
  const OperatorVendorView({super.key});

  @override
  State<OperatorVendorView> createState() => _OperatorVendorViewState();
}

class _OperatorVendorViewState extends State<OperatorVendorView> {
  late List<VendorModel> vendors;
  @override
  void initState() {
    super.initState();
  }

  void onEdit(VendorModel vendor) async {
    final VendorModel? updatedVendor =
        await Navigator.push<VendorModel>(context, MaterialPageRoute(
      builder: (context) {
        return OperatorVendorForm(venndor: vendor, mode: FormMode.edit);
      },
    ));
    if (updatedVendor != null) {
      await context.read<VendorProvider>().service.updateVendor(updatedVendor);
      setState(() {});
    }
  }

  void onRemove(VendorModel vendor) async {
    await context.read<VendorProvider>().onRemove(vendor);
    setState(() {});
  }

  Future<void> load() async {
    vendors = await context.read<VendorProvider>().getAllVender();
  }

  void onCreate() async {
    final VendorModel? newVendor = await Navigator.push<VendorModel>(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const OperatorVendorForm(mode: FormMode.create)));
    if (newVendor != null) {
      await context.read<VendorProvider>().service.createVendor(newVendor);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      bottom: GestureDetector(
        onTap: () => onCreate(),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xff16A34A),
          ),
          height: 70,
          child: const Text(
            'Create New Vendor',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      title: 'Vendor',
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: FutureBuilder(
              future: load(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: vendors.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => onEdit(vendors[index]),
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white)),
                          width: MediaQuery.of(context).size.width - 40,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vendors[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () => onRemove(vendors[index]),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
