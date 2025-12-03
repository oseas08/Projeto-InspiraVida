import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mapa_page.dart';

class AppColors {
  static const primary = Color(0xFF031633);
  static const background = Color(0xFFEBF2FF);
  static const textDark = Color(0xFF0A1E40);
  static const textGrey = Color(0xFF6E7A91);
  static const gold = Color(0xFFFFC107);
}

void main() {
  runApp(const RestauranteApp());
}

class RestauranteApp extends StatelessWidget {
  const RestauranteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurantes Azuis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
        ),
      ),
      home: const RestauranteListScreen(),
    );
  }
}

class Restaurante {
  final String id;
  final String nome;
  final String categoria;
  final String imageUrl;
  final double rating;
  final String distancia;
  final bool isOpen;
  final String address;

  const Restaurante({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.imageUrl,
    required this.rating,
    required this.distancia,
    required this.isOpen,
    required this.address
  });
}

const List<Restaurante> _restaurantes = [
  Restaurante(
      id: '1',
      nome: 'Parrilla Grill',
      categoria: 'Restaurante',
      imageUrl: 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSyy0wEUKe55KKq_o0ipvy7BB3whxDfxTxsmfr-t9nDwbZagAMMzx62WHyh6LOJRvQro5BKHTqHV_Kpgi8MwRuHi8ZwdVatxNXoCA8wHv2fuT6JtoeZH_honUo6hFhhvx_FiXYCA_g=w532-h240-k-no',
      rating: 4.5,
      distancia: '1.2 km',
      isOpen: true,
      address: 'Av. Deputada Ceci Cunha - Itapoá, Arapiraca - AL'
  ),
  Restaurante(
      id: '2',
      nome: 'Martinêz Cozinha Contemporânea',
      categoria: 'Restaurante',
      imageUrl: 'https://lh3.googleusercontent.com/p/AF1QipP-8ztT8CJ2X2GdYfQBgm98NFOaGt9LYQDoz1ed=s680-w680-h510-rw',
      rating: 4.6,
      distancia: '2.5 km',
      isOpen: true,
      address: 'R. São João, 362 - Santa Esmeralda, Arapiraca - AL'
  ),
  Restaurante(
      id: '3',
      nome: 'Pecado da Gula',
      categoria: 'Doceria',
      imageUrl: 'https://lh3.googleusercontent.com/p/AF1QipOz-EAHVJ_eWJ7PayPgb3dFqfTC6ZU2ZShD3c-4=w408-h481-k-no',
      rating: 4.7,
      distancia: '0.8 km',
      isOpen: false,
      address: 'R: Estud, R. Est. José de Oliveira Leite, 543, Arapiraca - AL'
  ),
  Restaurante(
      id: '4',
      nome: 'Rodeios Churrascaria',
      categoria: 'Restaurante',
      imageUrl: 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSxKcerrMDMiEgof00jS6nYUqZBx2gU0D8Nuv6WFIErrkScV5cocaSxgFzMpXoVpFJ6LP8yWfCTAFtDdnkqCbvpZi0qxy6Mpm-uoMpz3irrsa6EG2MF5hhbYof9GiX2y8zP-5tBdMKzEeQc=w408-h544-k-no',
      rating: 4.6,
      distancia: '3.0 km',
      isOpen: true,
      address: 'AL-220, 105 - Anexo A - Canafístula, Arapiraca - AL'
  ),
];

class RestauranteListScreen extends StatelessWidget {
  const RestauranteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _restaurantes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => RestauranteCard(restaurante: _restaurantes[index]),
      ),
    );
  }
}

class RestauranteCard extends StatelessWidget {
  final Restaurante restaurante;

  const RestauranteCard({super.key, required this.restaurante});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RestaurantDetailScreen(restaurant: restaurante)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(restaurante.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurante.nome,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      restaurante.categoria,
                      style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 16, color: AppColors.gold),
                        const SizedBox(width: 4),
                        Text(
                          restaurante.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.circle, size: 4, color: AppColors.textGrey),
                        const SizedBox(width: 12),
                        Text(
                          restaurante.distancia,
                          style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                        ),
                        const Spacer(),
                        _StatusBadge(isOpen: restaurante.isOpen),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isOpen;

  const _StatusBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isOpen ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isOpen ? "Aberto" : "Fechado",
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isOpen ? Colors.green[700] : Colors.red[700],
        ),
      ),
    );
  }
}

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurante restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  int _rating = 0;
  late Future<List<Location>> locations =  locationFromAddress(widget.restaurant.address);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder(
                future: locations,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return GoogleMapsPage(
                    position: LatLng(
                      snapshot.requireData[0].latitude,
                      snapshot.requireData[0].longitude,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.restaurant.nome,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      _StatusBadge(isOpen: widget.restaurant.isOpen),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "${widget.restaurant.categoria} • ${widget.restaurant.distancia}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textGrey,
                    ),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: widget.restaurant.isOpen ? () {} : null,
                          icon: const Icon(Icons.call, size: 18),
                          label: const Text("Entrar em contato"),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_bubble_outline, size: 18),
                          label: const Text("Conversar"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 24),

                  const Center(
                    child: Text(
                      "Avalie o estabelecimento",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        iconSize: 32,
                        color: AppColors.gold,
                        icon: Icon(
                          index < _rating
                              ? Icons.star
                              : Icons.star_border_rounded,
                        ),
                        onPressed: () {
                          setState(() => _rating = index + 1);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}