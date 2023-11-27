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
        backgroundColor: Colors.deepPurpleAccent,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Entrez une image à rechercher',
                border: OutlineInputBorder(),
                fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<ImageSearchBloc>(context).add(
                        ImageSearchRequested(_controller.text),
                      );
                    }
                  },
                ),
              ),
              style: TextStyle(color: Colors.deepPurpleAccent),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Veuillez entrer une image à rechercher';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<ImageSearchBloc>(context).add(
                    ImageSearchRequested(_controller.text),
                  );
                }
              },
            ),
          ),
          BlocBuilder<ImageSearchBloc, ImageSearchState>(
                builder: (context, state) {
                    if (state is ImageSearchLoadInProgress) {
                    return CircularProgressIndicator();
                    } else if (state is ImageSearchLoadSuccess) {
                    return Expanded(
                        child: OrientationBuilder(
                        builder: (context, orientation) {
                            int crossAxisCount = orientation == Orientation.portrait ? 2 : 4;
                            if (MediaQuery.of(context).size.width > 600) {
                            crossAxisCount++;
                            }
                            return GridView.count(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 4.0, 
                            crossAxisSpacing: 4.0, 
                            children: state.images.map((image) {
                                return GestureDetector(
                                onTap: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ImageDetailPage(
                                        imageUrl: image.fullImageUrl,
                                        title: image.title,
                                        ),
                                    ),
                                    );
                                },
                                child: GridTile(
                                    child: Image.network(
                                    image.thumbnailUrl,
                                    fit: BoxFit.cover,
                                    ),
                                    footer: GridTileBar(
                                    backgroundColor: Colors.black54,
                                    title: Text(image.title),
                                    ),
                                ),
                                );
                            }).toList(),
                            );
                        },
                        ),
                    );
                    } else {
                    return Text('Aucun résultat');
                    }
                },
                )

        ],
      ),
    );
  }
}
