import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  
  // CREATE
  Future addEmployeeDetails(// classe DataBaseMethods que contém os métodos de acesso ao banco de dados
      // método addEmployeeDetails que recebe um Map<String, dynamic> employeeInfoMap como parâmetro
      Map<String, dynamic> employeeInfoMap,
      String id) async {
    // o método é assíncrono e retorna um Future e recebe um Map<String, dynamic> employeeInfoMap e uma String id como parâmetros
    return await FirebaseFirestore
        .instance // retorna um await que aguarda a execução do método instance da classe FirebaseFirestore
        .collection("employees") // acessa a coleção "employees"
        .doc(id) // acessa o documento com o id fornecido
        .set(
            employeeInfoMap); // define os dados do documento com o Map<String, dynamic> employeeInfoMap fornecido
  }

  // READ
  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    // método getEmployeeDetails que retorna um Future<Stream<QuerySnapshot>>
    return await FirebaseFirestore
        .instance // retorna um await que aguarda a execução do método instance da classe FirebaseFirestore
        .collection("employees") // acessa a coleção "employees"
        .snapshots(); // retorna um Stream de QuerySnapshot com os dados da coleção
  }

  // UPDATE
  Future updateEmployeeDetails(
      // método updateEmployeeDetails que recebe um Map<String, dynamic> employeeInfoMap e uma String id como parâmetros
      Map<String, dynamic> updateInfoMap,
      String id) async {
    // o método é assíncrono e retorna um Future e recebe um Map<String, dynamic> employeeInfoMap e uma String id como parâmetros
    return await FirebaseFirestore
        .instance // retorna um await que aguarda a execução do método instance da classe FirebaseFirestore
        .collection("employees") // acessa a coleção "employees"
        .doc(id) // acessa o documento com o id fornecido
        .update(
            updateInfoMap); // atualiza os dados do documento com o Map<String, dynamic> employeeInfoMap fornecido
  }

  // DELETE
  Future deleteEmployeeDetails(String id) async {
    // o método é assíncrono e retorna um Future e recebe um Map<String, dynamic> employeeInfoMap e uma String id como parâmetros
    return await FirebaseFirestore
        .instance // retorna um await que aguarda a execução do método instance da classe FirebaseFirestore
        .collection("employees") // acessa a coleção "employees"
        .doc(id)
        .delete(); // acessa o documento com o id fornecido
  }
}
