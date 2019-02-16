import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

/**
 * Clase que crea la app, usa StatelesWidget que tiene su prpio build
 */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome flutter',
      home: RandonWords(),
    );
  }
}

/**
 * Clase para crea el state con StatefulWidget, pero no crea su propio build
 * lo toma de Randon word Sstate
 */
class RandonWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RandonWordsState();
  }
}


/**
 * Esta clase tiene toda la logica y ademas mantiene el estado(data persist)
 */
class RandonWordsState extends State<RandonWords> {
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 28.0);
  final _saved = Set<WordPair>();

  /**
 * Método para mantener el estado(persistie la data) y pinta el widget (title, body)
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestion(),
    );
  }

/**
 * Lógica de ListView, y genera el listTitle traido desde BuidRow
 */
  Widget _buildSuggestion() {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if(i.isOdd) {
          return Divider();
        }
        if (i >= _suggestion.length) {
          _suggestion.addAll(generateWordPairs().take(10));
        }
        final index = i ~/2;
        return _buildRow(_suggestion[index]);
      },
    );
  }

/* Objeto que se visualizará en pantalla(ListTitle)
recibe como parametro la pareja de palabras que mostrará en el LS */
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase, 
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if(alreadySaved){
              _saved.remove(pair);
            }else{
              _saved.add(pair);
            }
          });
        },
    );
  }
}
