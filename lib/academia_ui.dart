import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AppColors {
  static const primary = Color(0xFF0B1E3B);
  static const accent = Color(0xFF00E676);
  static const background = Color(0xFFF4F6F8);
  static const textDark = Color(0xFF1A1A1A);
  static const textGrey = Color(0xFF757575);
  static const star = Color(0xFFFFC107);
}

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspiravida',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const GymListScreen(),
    );
  }
}

class Gym {
  final String id;
  final String name;
  final String category;
  final String address;
  final String imageUrl;
  final double rating;
  final String distance;
  final bool isOpen;

  const Gym({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.isOpen
  });
}

const List<Gym> _gyms = [
  Gym(
      id: '1',
      name: 'Academia Smart Fit - Arapiraca',
      category: 'Musculação • Bodybuilding',
      address: 'R. São João, 351 - Caititus, Arapiraca - AL, 57312-265',
      imageUrl: 'https://lh3.googleusercontent.com/p/AF1QipN3f1c_t246DqcJITAmnPoSV8KHg_ehDftlRyN-=w426-h240-k-no',
      rating: 4.7,
      distance: '0.5 km',
      isOpen: true
  ),
  Gym(
      id: '2',
      name: 'Selfit Academias Arapiraca',
      category: 'Musculação',
      address: 'Av. Deputada Ceci Cunha, 08 - Itapoá, Arapiraca - AL, 57314-105',
      imageUrl: 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSyCvgRJXZ2rvjkdg2MLRAlv52JKPs5couaeuIxBQjS0Pw9Vi1GG4zJhUF2-YdY07CnTed40oFsJ-2XifRio0mcA_R6iNsFH9DuTTQ8nB0xJhRZMkFTsVXkC2lzCnN49RllsKRD9Mw=w408-h544-k-no',
      rating: 4.8,
      distance: '1.8 km',
      isOpen: true),
  Gym(
      id: '3',
      name: 'CentralFit',
      category: 'Musculação',
      address: 'R. Ver. Domingos Vital - Alto do Cruzeiro, Arapiraca - AL, 57312-250',
      imageUrl: 'https://lh3.googleusercontent.com/p/AF1QipME4a5aPOHDfH0idjJXEwC8bVzAiOlXJ8cPpLR_=w430-h240-k-no',
      rating: 4.5,
      distance: '3.2 km',
      isOpen: false),
  Gym(
      id: '4',
      name: 'X7 Academia',
      category: 'Musculação',
      address: 'Jardim Tropical, Arapiraca - AL, 57316-065',
      imageUrl: 'https://lh3.googleusercontent.com/gps-cs-s/AG0ilSzEsNLYNcfIGzLl8rdMRcwWr-_VBcsCmSWxnIUbAv9UFdwjONfRgJrhEfkWKLOqamR9O2SGuLH5u_kqOcuz4goAlm4QBUkMY-N1zVNaJniW-amG5VAbIMOIwQ6HSHe82aeF5NJaI24ga-lA=w408-h408-k-no',
      rating: 4.7,
      distance: '4.0 km',
      isOpen: true),
];

class GymListScreen extends StatelessWidget {
  const GymListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academias'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _gyms.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => GymCard(gym: _gyms[index]),
      ),
    );
  }
}

class GymCard extends StatelessWidget {
  final Gym gym;

  const GymCard({super.key, required this.gym});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GymDetailScreen(gym: gym)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(gym.imageUrl),
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
                      gym.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      gym.category.toUpperCase(),
                      style: const TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            gym.address,
                            style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 18, color: AppColors.star),
                        const SizedBox(width: 2),
                        Text(
                          gym.rating.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        const Spacer(),
                        _StatusBadge(isOpen: gym.isOpen),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: isOpen ? AppColors.accent.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: isOpen ? AppColors.accent.withOpacity(0.5) : Colors.grey.withOpacity(0.3),
              width: 1
          )
      ),
      child: Text(
        isOpen ? "ABERTO" : "FECHADO",
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: isOpen ? Colors.green[800] : Colors.grey[600],
        ),
      ),
    );
  }
}

class GymDetailScreen extends StatefulWidget {
  final Gym gym;

  const GymDetailScreen({super.key, required this.gym});

  @override
  State<GymDetailScreen> createState() => _GymDetailScreenState();
}

class _GymDetailScreenState extends State<GymDetailScreen> {
  int _rating = 0;

  late Future<List<Location>> locations = locationFromAddress(widget.gym.address);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            leading: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black26,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: FutureBuilder<List<Location>>(
                future: locations,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
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
                          widget.gym.name,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark),
                        ),
                      ),
                      _StatusBadge(isOpen: widget.gym.isOpen),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.gym.category,
                    style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.gym.address,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textDark,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Distância: ${widget.gym.distance} de você",
                                style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.map_outlined, color: AppColors.primary.withOpacity(0.5)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: widget.gym.isOpen ? () {} : null,
                          icon: const Icon(Icons.calendar_today_outlined, size: 18),
                          label: const Text("AGENDAR"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          label: const Text("CONTATO"),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                      "Como foi seu treino?",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        iconSize: 36,
                        color: AppColors.star,
                        icon: Icon(index < _rating ? Icons.star : Icons.star_border_rounded),
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

class GoogleMapsPage extends StatelessWidget {
  final LatLng position;

  const GoogleMapsPage({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: position,
        zoom: 15,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('gym_location'),
          position: position,
        ),
      },
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      liteModeEnabled: false,
      myLocationButtonEnabled: false,
    );
  }
}