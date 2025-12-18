import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListaDinamicaPage(),
    );
  }
}

class ListaDinamicaPage extends StatefulWidget {
  const ListaDinamicaPage({super.key});

  @override
  State<ListaDinamicaPage> createState() {
    print('Ciclo de Vida: createState');
    return _ListaDinamicaPageState();
  }
}

class _ListaDinamicaPageState extends State<ListaDinamicaPage> {
  final List<String> _elementos = ['Tarea 1', 'Tarea 2'];

  // --- 3. REQUISITO: Métodos del Ciclo de Vida ---
  @override
  void initState() {
    super.initState();
    print('Ciclo de Vida: initState (Se inicia la lógica de la página)');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('Ciclo de Vida: didChangeDependencies');
  }

  @override
  void dispose() {
    print('Ciclo de Vida: dispose (Se libera la memoria)');
    super.dispose();
  }

  void _agregarElemento() {
    setState(() {
      _elementos.add('Tarea ${_elementos.length + 1}');
      print('Estado actualizado: Elemento agregado');
    });
  }

  void _eliminarElemento(int index) {
    setState(() {
      _elementos.removeAt(index);
      print('Estado actualizado: Elemento eliminado en índice $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Ciclo de Vida: build (Se redibuja la interfaz)');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciclo de Vida y Widgets'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: _elementos.length,
        itemBuilder: (context, index) {
          return ElementoLista(
            texto: _elementos[index],
            onDelete: () => _eliminarElemento(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarElemento,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ElementoLista extends StatelessWidget {
  final String texto;
  final VoidCallback onDelete;

  const ElementoLista({
    super.key,
    required this.texto,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline),
        title: Text(texto),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}