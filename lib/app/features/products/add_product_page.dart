import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  final descriptionEC = TextEditingController();
  final ageEC = TextEditingController();
  final ratingEC = TextEditingController();

  Color selectedColor = Colors.lightGreen;
  String genre = 'Terror';

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
                const SizedBox(height: 10),
                CustomRadioButton(
                    buttonLables: const [
                      'Terror',
                      'Animação',
                      'Ação',
                      'Drama',
                      'Romance',
                      'Comédia',
                      'Suspense',
                      'SciFi',
                      'Infantil',
                    ],
                    buttonValues: const [
                      'Terror',
                      'Animação',
                      'Ação',
                      'Drama',
                      'Romance',
                      'Comédia',
                      'Suspense',
                      'SciFi',
                      'Infantil',
                    ],
                    shapeRadius: 15,
                    enableShape: true,
                    elevation: 2,
                    defaultSelected: genre,
                    buttonTextStyle: const ButtonTextStyle(
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    radioButtonValue: (str) {
                      genre = str;
                    },
                    enableButtonWrap: true,
                    autoWidth: true,
                    height: 60,
                    unSelectedColor: Colors.white,
                    selectedColor: Colors.lightGreen),
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
                  decoration: const InputDecoration(hintText: 'Ano de Lançamento'),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await showColorPickerDialog(
                      context,
                      selectedColor,
                      actionButtons: const ColorPickerActionButtons(
                        closeButton: true,
                      ),
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.7),
                      backgroundColor: Colors.white,
                      pickersEnabled: {
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: false,
                        ColorPickerType.wheel: false,
                      },
                      pickerTypeLabels: {
                        ColorPickerType.primary: 'Cor primária',
                      },
                      elevation: 2,
                      runSpacing: 15,
                      title: const Text('Selecione a faixa etária'),
                    ).then((color) {
                      selectedColor = color;
                      setState(() {});
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Selecione a Faixa Etária:'),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(color: selectedColor, borderRadius: BorderRadius.circular(50)),
                        )
                      ],
                    ),
                  ),
                ),
                RatingBar(
                  initialRating: 3,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star_rounded, color: Colors.amber),
                    empty: const Icon(Icons.star_outline_rounded, color: Colors.amber),
                    half: const Icon(Icons.star_half_rounded, color: Colors.amber),
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
                          genre: genre,
                          title: titleEC.text,
                          rating: rating ?? 0,
                          description: descriptionEC.text,
                          age: int.tryParse(ageEC.text) ?? 0,
                          color: selectedColor,
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
