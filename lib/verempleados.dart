import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleados extends StatelessWidget {
  const VerEmpleados({super.key});

  @override
  Widget build(BuildContext context) {
    final lista = datosEmpleado.values.toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text('DIRECTORIO')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: SafeArea(
          child: lista.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined, size: 80, color: Colors.white12),
                      SizedBox(height: 25),
                      Text(
                        'Directorio Vacío',
                        style: TextStyle(color: Colors.white38, fontSize: 18, letterSpacing: 2.0, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(24),
                  itemCount: lista.length,
                  itemBuilder: (context, index) {
                    final e = lista[index];
                    return _tarjetaEmpleado(e.id, e.nombre, e.puesto, e.salario);
                  },
                ),
        ),
      ),
    );
  }

  Widget _tarjetaEmpleado(int id, String nombre, String puesto, double salario) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xFF1E293B).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 15, offset: Offset(0, 8)),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        leading: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(color: Color(0xFF3B82F6).withValues(alpha: 0.3), blurRadius: 10, offset: Offset(0, 4)),
            ],
          ),
          child: Center(
            child: Text(
              '#$id',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
            ),
          ),
        ),
        title: Text(
          nombre,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17, letterSpacing: 0.5),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              Icon(Icons.workspace_premium_outlined, size: 14, color: Colors.white54),
              SizedBox(width: 6),
              Text(
                puesto.toUpperCase(),
                style: TextStyle(color: Colors.white54, fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${salario.toStringAsFixed(2)}',
              style: TextStyle(
                color: Color(0xFF60A5FA),
                fontWeight: FontWeight.w700,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'SALARIO',
              style: TextStyle(color: Colors.white30, fontSize: 9, letterSpacing: 2.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
