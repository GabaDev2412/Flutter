import 'package:app_crud_firebase/pages/employee.dart';
import 'package:app_crud_firebase/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  Stream?
      EmployeeStream; // declaração de uma variável Stream chamada EmployeeStream para armazenar os dados dos funcionários

  getontheload() async {
    // esse metodo serve para obter os dados dos funcionários ao carregar a tela
    EmployeeStream = await DataBaseMethods()
        .getEmployeeDetails(); // o EmployeeStream é definido como os dados dos funcionários obtidos do método getEmployeeDetails
    setState(
        () {}); // setState é chamado para reconstruir a tela com os novos dados
  }

  @override
  void initState() {
    // initState serve para inicializar o estado do widget
    // o initState é chamado quando o widget é inserido na árvore de widgets
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    // método allEmployeeDetails que retorna um Widget
    return StreamBuilder(
        // StreamBuilder é um widget que constrói um widget com base nos dados de um Stream
        stream: EmployeeStream, // o stream é definido como EmployeeStream
        builder: (context, AsyncSnapshot snapshot) {
          // o builder é uma função que recebe o contexto e um AsyncSnapshot como parâmetros
          return snapshot.hasData
              ? ListView.builder(
                  // se o snapshot tiver dados, retorna um ListView.builder
                  itemCount: snapshot.data.docs
                      .length, // o itemCount é definido como o comprimento dos documentos no snapshot
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[
                        index]; // o DocumentSnapshot ds é definido como o documento no índice fornecido
                    return Container(
                      // card com os dados dos funcionários
                      margin: EdgeInsets.only(bottom: 20),
                      child: Material(
                        // Material é um widget que implementa o Material Design
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            padding: EdgeInsets.all(20),
                            width: MediaQuery.of(context)
                                .size
                                .width, // aqui definimos a largura do container como a largura da tela
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Name: " + ds["Name"],
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                    Row(
                                      children: [
                                        GestureDetector( // edit/uptade employee details
                                            onTap: () {
                                              nameController.text = ds["Name"];
                                              ageController.text = ds["Age"];
                                              locationController.text =
                                                  ds["Location"];
                                              EditEmployeeDetails(ds["Id"]);
                                            },
                                            child: Icon(Icons.edit,
                                                color: Colors.orange)),
                                        SizedBox(width: 10),
                                        GestureDetector( // delete employee details
                                          onTap: () async{
                                            await DataBaseMethods().deleteEmployeeDetails(ds["Id"]);
                                          },
                                          child: Icon(Icons.delete,
                                              color: Colors.orange),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text("Age: " + ds["Age"],
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                Text("Location: " + ds["Location"],
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )),
                      ),
                    );
                  })
              : Container(); // se o snapshot não tiver dados, retorna um Container
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // estrutura básica de uma tela no Flutter
      floatingActionButton: FloatingActionButton(
        // botão flutuante
        onPressed: () {
          // aqui você coloca o código que será executado ao clicar no botão
          Navigator.push(
              context,
              MaterialPageRoute(
                  // aqui você navega para a tela de Employee usando o Navigator e o MaterialPageRoute, o push é para empilhar a tela atual e a nova tela
                  builder: (context) => Employee()));
        }, // função que será executada ao clicar no botão
        tooltip:
            'Increment', // texto que aparece ao passar o mouse sobre o botão
        child: Icon(Icons.add), // ícone do botão
      ),
      appBar: AppBar(
        // barra superior
        title: Row(
          // define o título da tela home
          // linha
          mainAxisAlignment:
              MainAxisAlignment.center, // essa linha centraliza os textos
          children: [
            Text('Flutter',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
            Text('Firebase',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Container(
        // corpo da tela
        margin: EdgeInsets.only(left: 20, top: 20, right: 30), // margem
        child: Column(
          // coluna
          children: [
            Expanded(
                child:
                    allEmployeeDetails()), // chama o método allEmployeeDetails
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetails(String id) => showDialog(
      // método EditEmployeeDetails que recebe uma String id como parâmetro, esse método exibe um AlertDialog para editar os dados do funcionário
      context: context,
      builder: (context) => AlertDialog(
              content: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    Text('Edit',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold)),
                    Text('Details',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  // conteiner NAME
                  child: Column(
                    // o crossAxisAligment é diferente do mainAxisAlignment, ele alinha os elementos na vertical enquanto o mainAxisAlignment alinha na horizontal
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // aqui usamos o crossAxisAlignment para alinhar os elementos à esquerda da tela
                    children: [
                      Text("Name",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height:
                              10), // o SizedBox é um widget que permite adicionar um espaço entre os elementos
                      Container(
                        // o padding é um espaçamento internos
                        padding: EdgeInsets.only(left: 5),
                        // decoration é um objeto que permite adicionar uma borda, cor, sombra, etc. a um widget
                        decoration: BoxDecoration(
                          // aqui usamos o BoxDecoration para adicionar uma borda ao TextField
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller:
                              nameController, // aqui você define o controlador do TextField
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // aqui removemos a borda do TextField
                          ),
                        ),
                      )
                    ],
                  ),
                ), // fim do conteiner NAME
                SizedBox(height: 20.0),
                Container(
                  // conteiner AGE
                  child: Column(
                    // o crossAxisAligment é diferente do mainAxisAlignment, ele alinha os elementos na vertical enquanto o mainAxisAlignment alinha na horizontal
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // aqui usamos o crossAxisAlignment para alinhar os elementos à esquerda da tela
                    children: [
                      Text("Age",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height:
                              10), // o SizedBox é um widget que permite adicionar um espaço entre os elementos
                      Container(
                        // o padding é um espaçamento internos
                        padding: EdgeInsets.only(left: 5),
                        // decoration é um objeto que permite adicionar uma borda, cor, sombra, etc. a um widget
                        decoration: BoxDecoration(
                          // aqui usamos o BoxDecoration para adicionar uma borda ao TextField
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller:
                              ageController, // aqui você define o controlador do TextField
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // aqui removemos a borda do TextField
                          ),
                        ),
                      )
                    ],
                  ),
                ), // fim do conteiner AGE
                SizedBox(height: 20.0),
                Container(
                  // container LOCATION
                  child: Column(
                    // o crossAxisAligment é diferente do mainAxisAlignment, ele alinha os elementos na vertical enquanto o mainAxisAlignment alinha na horizontal
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // aqui usamos o crossAxisAlignment para alinhar os elementos à esquerda da tela
                    children: [
                      Text("Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                          height:
                              10), // o SizedBox é um widget que permite adicionar um espaço entre os elementos
                      Container(
                        // o padding é um espaçamento internos
                        padding: EdgeInsets.only(left: 5),
                        // decoration é um objeto que permite adicionar uma borda, cor, sombra, etc. a um widget
                        decoration: BoxDecoration(
                          // aqui usamos o BoxDecoration para adicionar uma borda ao TextField
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller:
                              locationController, // aqui você define o controlador do TextField
                          decoration: InputDecoration(
                            border: InputBorder
                                .none, // aqui removemos a borda do TextField
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updateInfoMap = {
                        "Name": nameController.text,
                        "Age": ageController.text,
                        "Location": locationController.text,
                        "Id": id
                      };
                      await DataBaseMethods()
                          .updateEmployeeDetails(updateInfoMap, id)
                          .then(
                        (value) {
                          Fluttertoast.showToast(
                              // aqui você exibe um toast com a mensagem "Employee added successfully"
                              msg: "Employee update successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Text(
                      'Update',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )));
}
