import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/emotion_type.dart';
import '../../domain/providers/garden_provider.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  String _searchQuery = '';
  EmotionType? _filterType;
  bool _sortAscending = false;

  @override
  Widget build(BuildContext context) {
    final plants = ref.watch(gardenProvider);

    // Filter and sort
    final filteredPlants = plants.where((p) {
      if (_filterType != null && p.type != _filterType) return false;
      if (_searchQuery.isNotEmpty && !p.note.toLowerCase().contains(_searchQuery.toLowerCase())) return false;
      return true;
    }).toList();

    filteredPlants.sort((a, b) {
      if (_sortAscending) {
        return a.createdAt.compareTo(b.createdAt);
      } else {
        return b.createdAt.compareTo(a.createdAt);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        title: const Text('I Nostri Ricordi', style: TextStyle(color: Color(0xFF5D4037), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF5D4037)),
      ),
      body: Column(
        children: [
          // Filter and Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Cerca nei ricordi...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF8D6E63)),
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Emotion Filter
                    DropdownButton<EmotionType?>(
                      value: _filterType,
                      hint: const Text('Tutte le emozioni'),
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8D6E63)),
                      items: [
                        const DropdownMenuItem(value: null, child: Text('Tutte le emozioni')),
                        ...EmotionType.values.map((type) => DropdownMenuItem(
                          value: type,
                          child: Text('${type.emoji} ${type.label}'),
                        )),
                      ],
                      onChanged: (val) => setState(() => _filterType = val),
                    ),
                    // Sort order
                    IconButton(
                      icon: Icon(_sortAscending ? Icons.arrow_upward : Icons.arrow_downward),
                      color: const Color(0xFF8D6E63),
                      tooltip: 'Ordina per data',
                      onPressed: () => setState(() => _sortAscending = !_sortAscending),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Expanded(
            child: filteredPlants.isEmpty
                ? const Center(child: Text('Nessun ricordo trovato 🥀', style: TextStyle(color: Colors.grey, fontSize: 16)))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPlants.length,
                    itemBuilder: (context, index) {
                      final plant = filteredPlants[index];
                      final dateStr = DateFormat('d MMM yyyy, HH:mm', 'it').format(plant.createdAt);
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 1,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(plant.type.emoji, style: const TextStyle(fontSize: 28)),
                          ),
                          title: Text(dateStr, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              plant.note.isEmpty ? 'Nessun pensiero allegato' : plant.note,
                              style: const TextStyle(color: Color(0xFF37474F), fontSize: 15),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () {
                              _showDeleteConfirmation(context, ref, plant.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, String plantId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminare il ricordo?'),
        content: const Text('Questa azione non pùo essere annullata.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              ref.read(gardenProvider.notifier).removePlant(plantId);
              Navigator.of(ctx).pop();
            },
            child: const Text('Elimina', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
