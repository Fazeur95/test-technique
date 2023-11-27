import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../bloc/image_search_bloc.dart';
import 'image_detail_page.dart';

class ImageSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche d\'images'),
      ),
      body: BlocProvider(
        create: (context) => ImageSearchBloc(http.Client()),
        child: ImageSearchForm(),
      ),
    );
  }
}

class ImageSearchForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Entrez un terme de recherche',
            ),
           validator: (value) {
  if (value?.isEmpty ?? true) {
    return 'Veuillez entrer un terme de recherche';
  }
  return null;
},

          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<ImageSearchBloc>(context).add(
                  ImageSearchRequested(_controller.text),
                );
              }
            },
            child: Text('Rechercher'),
          ),
          BlocBuilder<ImageSearchBloc, ImageSearchState>(
            builder: (context, state) {
              if (state is ImageSearchLoadInProgress) {
                return CircularProgressIndicator();
              } else if (state is ImageSearchLoadSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.images.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(state.images[index].thumbnailUrl),
                        title: Text(state.images[index].title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetailPage(
                                imageUrl: state.images[index].fullImageUrl,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return Text('Aucun résultat');
              }
            },
          ),
        ],
      ),
    );
  }
}
