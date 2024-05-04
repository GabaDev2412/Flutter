import 'package:app_crud_firebase/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  // aqui você declara os controladores dos TextFields
  // os controladores são usados para acessar o valor dos TextFields
  // assim você pode obter o valor dos TextFields quando o botão for clicado ou quando você precisar
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // linha
          mainAxisAlignment:
              MainAxisAlignment.center, // essa linha centraliza os textos
          children: [
            // titulo da tela
            Text('Employee',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
            Text('Form',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Container(
        // o margin é um espaçamento externo
        margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Container( // conteiner NAME
              child: Column(
                // o crossAxisAligment é diferente do mainAxisAlignment, ele alinha os elementos na vertical enquanto o mainAxisAlignment alinha na horizontal
                crossAxisAlignment: CrossAxisAlignment.start,
                // aqui usamos o crossAxisAlignment para alinhar os elementos à esquerda da tela
                children: [
                  Text("Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
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
                          fontSize: 24.0,
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
            Container( // container LOCATION
              child: Column(
                // o crossAxisAligment é diferente do mainAxisAlignment, ele alinha os elementos na vertical enquanto o mainAxisAlignment alinha na horizontal
                crossAxisAlignment: CrossAxisAlignment.start,
                // aqui usamos o crossAxisAlignment para alinhar os elementos à esquerda da tela
                children: [
                  Text("Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
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
            ), // fim do conteiner LOCATION
            SizedBox(height: 40.0),
            Center( // Botão ADD
              child: ElevatedButton(
                onPressed: () async {
                  String Id =
                      randomAlphaNumeric(10); // aqui você gera um id aleatório
                  // aqui você coloca o código que será executado ao clicar no botão
                  Map<String, dynamic> employeeInfoMap = {
                    // aqui você cria um Map<String, dynamic> com os dados do funcionário
                    "Name": nameController
                        .text, // aqui você acessa o valor do TextField name
                    "Age": ageController
                        .text, // aqui você acessa o valor do TextField age
                    "Id": Id, // aqui você acessa o valor do id gerado
                    "Location": locationController
                        .text, // aqui você acessa o valor do TextField location
                  };
                  // aqui você chama o método addEmployeeDetails da classe DataBaseMethods e passa o Map<String, dynamic> employeeInfoMap e o id como parâmetros
                  await DataBaseMethods()
                      .addEmployeeDetails(employeeInfoMap, Id)
                      .then((value) => { // then serve para executar um código após a execução do método
                            Fluttertoast.showToast( // aqui você exibe um toast com a mensagem "Employee added successfully"
                                msg: "Employee added successfully", 
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0)
                          });
                  Navigator.pop(context); // aqui você fecha a tela atual e volta para a tela anterior
                },
                child: Text("Add",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ), // fim do botão ADD
            ), // fim do Center
          ],
        ),
      ),
    );
  }
}
