import 'package:flutter/material.dart';
import 'package:inspiravida/domain/Comida_api_verdadeira.dart';
import '../domain/Comida.dart';

class Cardcomida extends StatefulWidget {
  final dynamic comida;

  const Cardcomida({super.key, required this.comida});

  @override
  State<Cardcomida> createState() => _CardcomidaState();
}

class _CardcomidaState extends State<Cardcomida> {
  late String nome = "";
  late String descricao = "";
  late String pathImage = "";

  @override
  Widget build(BuildContext context) {
    if (widget.comida is Comida) {
      nome = widget.comida.nome;
      descricao = widget.comida.descricao;
      pathImage = widget.comida.pathImage;
    } else if (widget.comida is Items) {
      nome = widget.comida.receita;
      descricao = widget.comida.ingredientes;
      pathImage = widget.comida.linkImagem;
    }

    return Container(
      padding: EdgeInsets.all(8),
      width: 200,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFd3e0ed), width: 2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              pathImage,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
          ),

          SizedBox(height: 8),

          Text(
            nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 6),

          Expanded(
            child: Text(
              descricao,
              style: TextStyle(fontSize: 13, color: Colors.black87),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
