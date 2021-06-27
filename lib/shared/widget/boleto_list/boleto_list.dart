import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widget/boleto_list/boleto_list_controler.dart';
import 'package:payflow/shared/widget/boleto_title/boleto_title.dart';

class BoletoList extends StatefulWidget {
  final BoletoListController controller;
  BoletoList({Key? key, required this.controller}) : super(key: key);

  @override
  _BoletoListState createState() => _BoletoListState();
}

class _BoletoListState extends State<BoletoList> {
  final controller = BoletoListController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
        valueListenable: widget.controller.boletosNotifier,
        builder: (_, boletos, __) => Column(
              children: boletos.map((e) => BoletoTitle(data: e)).toList(),
            ));
  }
}
