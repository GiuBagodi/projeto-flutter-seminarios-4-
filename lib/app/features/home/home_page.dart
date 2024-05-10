import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/components/modals/delete_alert_dialog.dart';
import 'package:puc_minas/app/core/components/product_card.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/core/models/product_model.dart';
import 'package:puc_minas/app/features/home/home_controller.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          IconButton(
            onPressed: () async {
              var loggedOut = await HomeController.logout();
              if (loggedOut) {
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              }
            },
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var product = await Navigator.of(context).pushNamed(AppRoutes.add);

          if (product != null) {
            products.add(product as ProductModel);
            setState(() {});
          }
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.movie_creation_outlined, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            products.isEmpty
                ? const Center(child: Text('Nenhum filme cadastrado'))
                : ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            bool? deleted = await showDialog(
                              context: context,
                              builder: ((context) {
                                return const DeleteAlertDialog();
                              }),
                            );
                            if (deleted == true) {
                              try {
                                products.removeAt(index);
                                showTopSnackBar(
                                    Overlay.of(context),
                                    const CustomSnackBar.success(
                                      message: 'O filme foi excluído!',
                                    ));
                                setState(() {});
                              } catch (e) {
                                log('Falha ao excluir filme');
                                showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: 'Falha ao excluir filme'));
                              }
                            }
                            return deleted;
                          }
                          return false;
                        },
                        child: ProductCard(
                          product: products[index],
                        ),
                      ),
                    ),
                    shrinkWrap: true,
                    itemCount: products.length,
                  )
          ],
        ),
      ),
    );
  }
}
