import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';

import '../create_data_into_firebase.dart';

class SelectPageOrder extends StatefulWidget {
  const SelectPageOrder({super.key});

  @override
  State<SelectPageOrder> createState() => _SelectPageOrderState();
}

class _SelectPageOrderState extends State<SelectPageOrder> {
  late final List<PageOrder> pageOrders;
  int? _selectedPageOrder;

  @override
  void initState() {
    super.initState();
    pageOrders = PageOrder.values;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("select study page order"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: pageOrders.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(backgroundColor: _selectedPageOrder == index ? Colors.blueAccent : Colors.white),
                      onPressed: () => setState(() {
                        _selectedPageOrder = index;
                        DevDataProvider().selectedPageOrder = _selectedPageOrder;
                      }),
                      child: Text(pageOrders[index].name, style: TextStyle(color: _selectedPageOrder == index ? Colors.white : Colors.blueAccent),),
                    );
                },),
              ],
            );
  }
}