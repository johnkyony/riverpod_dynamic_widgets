import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()) );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {

  final _provider = Provider.autoDispose<List<TextEditingController>>((ref) => []);

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context , ref) {
    final button = Center(
      child: IconButton(
        onPressed: (){
          ref.read(_provider).add(TextEditingController());
        }, icon: const Icon(Icons.add),
      ),
    );
    
    final listView = ListView.builder(
      itemCount: ref.watch(_provider).length,
        itemBuilder: (context , index){
        return ListTile(
          leading: IconButton(
            onPressed: (){
              final list = ref.read(_provider);
              list.remove(list[index]);
            },
            icon: const Icon(Icons.remove_from_queue),
          ),
          title: TextField(
            controller: ref.watch(_provider)[index],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "name ${ref.watch(_provider).length + 1}",
            ),
          ),
        );
        },);
    return  Scaffold(
      appBar: AppBar(title: const Text("Dynamic TextField RiverPod"),),
      body: Column(
        children: [
          button,
          Expanded(child: listView)
        ],
      ),
    );
  }
}
