import 'package:flutter/material.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleados extends StatefulWidget {
  const CapturaEmpleados({super.key});

  @override
  State<CapturaEmpleados> createState() => _CapturaEmpleadosState();
}

class _CapturaEmpleadosState extends State<CapturaEmpleados> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _puestoCtrl = TextEditingController();
  final _salarioCtrl = TextEditingController();

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      GuardarDatosDiccionario.registrarEmpleado(
        _nombreCtrl.text,
        _puestoCtrl.text,
        double.parse(_salarioCtrl.text),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registro Exitoso', style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold)),
          backgroundColor: Color(0xFF10B981), // Emerald 500
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text('NUEVO REGISTRO')),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Color(0xFF1E293B).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 30, offset: Offset(0, 15)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.badge_outlined, size: 55, color: Color(0xFF3B82F6)),
                      SizedBox(height: 35),
                      _crearInput(
                        controlador: _nombreCtrl,
                        etiqueta: 'Nombre Completo',
                        icono: Icons.person_outline,
                      ),
                      SizedBox(height: 24),
                      _crearInput(
                        controlador: _puestoCtrl,
                        etiqueta: 'Cargo o Puesto',
                        icono: Icons.work_outline,
                      ),
                      SizedBox(height: 24),
                      _crearInput(
                        controlador: _salarioCtrl,
                        etiqueta: 'Salario Mensual',
                        icono: Icons.attach_money,
                        esNumero: true,
                      ),
                      SizedBox(height: 45),
                      _botonGuardar(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearInput({required TextEditingController controlador, required String etiqueta, required IconData icono, bool esNumero = false}) {
    return TextFormField(
      controller: controlador,
      keyboardType: esNumero ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
      style: TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        labelText: etiqueta,
        labelStyle: TextStyle(color: Colors.white38, letterSpacing: 1.0, fontSize: 14),
        prefixIcon: Icon(icono, color: Color(0xFF3B82F6), size: 22),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF3B82F6), width: 2)),
        errorStyle: TextStyle(color: Color(0xFFEF4444)),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Este campo es obligatorio';
        if (esNumero && double.tryParse(v) == null) return 'Ingrese un monto numérico válido';
        return null;
      },
    );
  }

  Widget _botonGuardar() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
          ),
          boxShadow: [
            BoxShadow(color: Color(0xFF2563EB).withValues(alpha: 0.3), blurRadius: 15, offset: Offset(0, 8)),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: _guardar,
          child: Text(
            'GUARDAR DATOS',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 2.5, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
