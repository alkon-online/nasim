import 'package:flutter/material.dart';

import '../../addition/widgets.dart';
import 'installation_orders.dart';
import 'maintenance_orders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    // context size
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    return Scaffold(
      backgroundColor: const Color(0xff007088),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 14, vertical: screenWidth / 9),
        child: Column(
          children: [
            Row(
              children: [
                const BackButton(color: Colors.white),
                const SizedBox(
                  width: 18.00,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defultText(
                        text: AppLocalizations.of(context)!.orders,
                        weight: FontWeight.w600,
                        size: 18.00),
                    SizedBox(height: screenWidth / 80),
                    defultText(
                        text: AppLocalizations.of(context)!.your_orders,
                        color: Colors.white.withAlpha(100),
                        size: 13.5)
                  ],
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 30,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(12)),
                width: screenWidth,
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    defultText(
                        text: AppLocalizations.of(context)!.maintenance,
                        size: screenWidth / 23),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MaintenanceOrder()),
                );
              },
            ),
            SizedBox(
              height: screenHeight / 60,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(12)),
                width: screenWidth,
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    defultText(
                        text: AppLocalizations.of(context)!.installation,
                        size: screenWidth / 23),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InstallationOrder()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
