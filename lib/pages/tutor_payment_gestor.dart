import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:metro_experts/controllers/tutor_payment_gestor_controller.dart';
import 'package:metro_experts/components/custom_list_tile.dart';

class TutorPaymentGestor extends StatefulWidget {
  const TutorPaymentGestor({super.key});

  @override
  State<TutorPaymentGestor> createState() => _TutorPaymentGestorState();
}

class _TutorPaymentGestorState extends State<TutorPaymentGestor> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TutorPaymentGestorController>(context, listen: false)
          .fetchPayments(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirmación de Pagos",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<TutorPaymentGestorController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.payments.isEmpty) {
                    return const Center(
                        child: Text("No hay pagos disponibles"));
                  } else {
                    return ListView.builder(
                      itemCount: controller.payments.length,
                      itemBuilder: (context, index) {
                        final payment = controller.payments[index];
                        return Column(
                          children: [
                            CustomListTile(
                              classTitle: payment['nombreTutoria'],
                              studentName: payment['estudiante']['name'],
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
