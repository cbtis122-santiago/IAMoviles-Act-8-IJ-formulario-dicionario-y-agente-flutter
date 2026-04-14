import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  static void registrarEmpleado(String nombre, String puesto, double salario) {
    // Generar ID automático y robusto: superior al ID más alto registrado.
    int nuevoId = datosEmpleado.isEmpty ? 1 : datosEmpleado.keys.reduce((a, b) => a > b ? a : b) + 1;
    
    Empleado nuevo = Empleado(
      id: nuevoId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // Guardar en el diccionario global usando el ID como llave
    datosEmpleado[nuevoId] = nuevo;
  }
}
