import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widget/input_text/input_text.dart';
import 'package:payflow/shared/widget/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();
  final moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");

  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null)
      barcodeInputTextController.text = widget.barcode!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.input),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 93, vertical: 24),
                child: Text(
                  "Preencha os dados do boleto",
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputText(
                      label: "Nome do boleto",
                      icon: Icons.description_outlined,
                      validator: controller.validateName,
                      onChanged: (value) {
                        controller.onChanged(name: value);
                      },
                    ),
                    InputText(
                      controller: dueDateInputTextController,
                      label: "Vencimento",
                      icon: FontAwesomeIcons.timesCircle,
                      validator: controller.validateVencimento,
                      onChanged: (value) {
                        controller.onChanged(dueDate: value);
                      },
                    ),
                    InputText(
                      controller: moneyInputTextController,
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      validator: (_) => controller
                          .validateValor(moneyInputTextController.numberValue),
                      onChanged: (value) {
                        controller.onChanged(
                            value: moneyInputTextController.numberValue);
                      },
                    ),
                    InputText(
                      controller: barcodeInputTextController,
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      validator: controller.validateCodigo,
                      onChanged: (value) {
                        controller.onChanged(barcode: value);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
          enableSecondaryColor: true,
          primaryLabel: "Cancelar",
          primaryOnPressed: () {
            Navigator.pop(context);
          },
          secondaryLabel: "Cadastrar",
          secondaryOnPressed: () async {
            await controller.cadastrarBoleto();
            Navigator.pop(context);
          }),
    );
  }
}