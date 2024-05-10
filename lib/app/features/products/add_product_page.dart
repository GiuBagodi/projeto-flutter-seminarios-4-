import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:puc_minas/app/core/models/product_model.dart';
import 'package:validatorless/validatorless.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final titleEC = TextEditingController();
  final genreEC = TextEditingController();
  final descriptionEC = TextEditingController();
  final ageEC = TextEditingController();
  final ratingEC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  double? rating;

  final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Filme'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: Validatorless.required('Campo obrigatório'),
                  controller: titleEC,
                  decoration: const InputDecoration(hintText: 'Título'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: Validatorless.required('Campo obrigatório'),
                  controller: genreEC,
                  decoration: const InputDecoration(hintText: 'Gênero'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: Validatorless.required('Campo obrigatório'),
                  controller: descriptionEC,
                  decoration: const InputDecoration(hintText: 'Descrição'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório'),
                    Validatorless.number('Dado inválido'),
                  ]),
                  controller: ageEC,
                  decoration: const InputDecoration(hintText: 'Faixa Etária'),
                ),
                const SizedBox(height: 10),
                RatingBar(
                  initialRating: 3,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star_rounded, color: Colors.amber),
                    empty: Icon(Icons.star_outline_rounded, color: Colors.amber),
                    half: Icon(Icons.star_half_rounded, color: Colors.amber),
                  ),
                  onRatingUpdate: (value) {
                    rating = value;
                  },
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        ProductModel productModel = ProductModel(
                          genre: genreEC.text,
                          title: titleEC.text,
                          rating: rating ?? 0,
                          description: descriptionEC.text,
                          age: int.tryParse(ageEC.text) ?? 0,
                        );
                        Navigator.of(context).pop(productModel);
                      }
                    },
                    child: const Text(
                      'CADASTRAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
