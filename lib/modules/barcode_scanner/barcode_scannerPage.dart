import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_contoller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/botton_sheet/botton_sheet.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_style.dart';
import 'package:payflow/shared/widget/set_label_buttons/set_label_buttons.dart';

class BarCodeScannerPage extends StatefulWidget {
  const BarCodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarCodeScannerPageState createState() => _BarCodeScannerPageState();
}

class _BarCodeScannerPageState extends State<BarCodeScannerPage> {
  final controller = BarCodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarCode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto",
            arguments: controller.status.barCode);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          ValueListenableBuilder<BarCodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black.withOpacity(0.7),
                title: Text("Escaneie o codígo de barras do boleto",
                    style: TextStyles.buttonBackground),
                leading: BackButton(color: AppColors.background),
              ),
              body: Column(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.black.withOpacity(0.7),
                  )),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                      child: Container(
                    color: Colors.black.withOpacity(0.7),
                  )),
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Inserir código do boleto",
                primaryOnPressed: () {
                  Navigator.pushReplacementNamed(context, "/insert_boleto");
                },
                secondaryLabel: "Adicionar da galeria",
                secondaryOnPressed: () {},
              ),
            ),
          ),
          ValueListenableBuilder<BarCodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return BottonSheet(
                  title: "Não foi possivel identificar um código de barras",
                  subTitle: "Tente novamente ou digite o código de barras",
                  primaryLabel: "Escanear novamente",
                  primaryOnPressed: () {
                    controller.scanWithCamera();
                  },
                  secondaryLabel: "Digitar código",
                  secondaryOnPressed: () {
                    Navigator.pushReplacementNamed(context, "/insert_boleto");
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
