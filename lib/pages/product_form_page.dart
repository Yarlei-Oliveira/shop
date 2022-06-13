import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/products_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descritionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();

  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(UpdateImage);
  }

  void dispode() {
    super.dispose();
    _priceFocus.dispose();
    _descritionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(UpdateImage);
  }

  void UpdateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endWithFile;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<ProductsList>(
        context,
        listen: false,
      ).saveProduct(_formData);

      Navigator.of(context).pop();
    } catch (error) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: (() => Navigator.of(context).pop()),
              child: Text('Ok'),
            )
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Formulario Produto'),
          actions: [
            IconButton(
              onPressed: () {
                _submitForm();
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _formData['name']?.toString(),
                        decoration: InputDecoration(labelText: 'Nome'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocus);
                        },
                        onSaved: (name) => _formData['name'] = name ?? '',
                        validator: (_name) {
                          final name = _name ?? '';

                          if (name.trim().isEmpty) {
                            return "Nome Obrigatorio";
                          }

                          if (name.trim().length < 3) {
                            return "Nome precisa de no minimo 3 letras";
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['price']?.toString(),
                        decoration: InputDecoration(labelText: 'Preço'),
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocus,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_descritionFocus);
                        },
                        onSaved: (price) =>
                            _formData['price'] = double.parse(price ?? '0'),
                        validator: (_price) {
                          final priceString = _price ?? '-1';
                          final price = double.tryParse(priceString) ?? -1;

                          if (price <= 0) {
                            return 'Preço invalido';
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _formData['description']?.toString(),
                        decoration: InputDecoration(labelText: 'Descrição'),
                        textInputAction: TextInputAction.next,
                        focusNode: _descritionFocus,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_imageUrlFocus);
                        },
                        onSaved: (description) =>
                            _formData['description'] = description ?? '',
                        validator: (_descrition) {
                          final descrition = _descrition ?? '';

                          if (descrition.trim().isEmpty) {
                            return "Descrição Obrigatorio";
                          }

                          if (descrition.trim().length < 3) {
                            return "Descrição precisa de no minimo 3 letras";
                          }

                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Url da Imagem'),
                              textInputAction: TextInputAction.done,
                              focusNode: _imageUrlFocus,
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              onSaved: (imageUrl) =>
                                  _formData['imageUrl'] = imageUrl ?? '',
                              validator: (_imageUrl) {
                                final imageUrl = _imageUrl ?? '';
                                if (!isValidImageUrl(imageUrl)) {
                                  return 'Retorne uma Url valida';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => _submitForm(),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(
                              top: 10,
                              left: 10,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )),
                            alignment: Alignment.center,
                            child: _imageUrlController.text.isEmpty
                                ? Text('Informe o Url')
                                : FittedBox(
                                    child:
                                        Image.network(_imageUrlController.text),
                                    fit: BoxFit.contain,
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
