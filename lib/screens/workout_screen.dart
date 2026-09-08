import 'package:flutter/material.dart';

import '../data/exercise_data.dart';
import '../models/exercise.dart';
import 'exercise_detail_page.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  static const _categories = ['All', 'Strength', 'Legs', 'Core', 'Cardio'];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isSearching = false;

  Color _categoryColor(String category) {
    switch (category) {
      case 'Strength':
        return Colors.blue;
      case 'Legs':
        return Colors.purple;
      case 'Core':
        return Colors.orange;
      case 'Cardio':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleExercises = exercises.where((exercise) {
      final matchesCategory = _selectedCategory == 'All' ||
          exercise.category == _selectedCategory;
      final query = _searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty ||
          exercise.name.toLowerCase().contains(query) ||
          exercise.description.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search exercises',
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() => _searchQuery = value),
              )
            : const Text('Workouts'),
        actions: [
          IconButton(
            tooltip: _isSearching ? 'Close search' : 'Search workouts',
            onPressed: () => setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) _searchQuery = '';
            }),
            icon: Icon(_isSearching ? Icons.close : Icons.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              'Choose a session that fits your energy today.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          SizedBox(
            height: 42,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => ChoiceChip(
                label: Text(_categories[index]),
                selected: _selectedCategory == _categories[index],
                onSelected: (selected) {
                  if (selected) {
                    setState(() => _selectedCategory = _categories[index]);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: visibleExercises.length,
              itemBuilder: (context, index) {
                final Exercise exercise = visibleExercises[index];
                final color = _categoryColor(exercise.category);
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ExerciseDetailPage(exercise: exercise),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: color.withAlpha(30),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(Icons.fitness_center, color: color),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  exercise.description,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 4,
                                  children: [
                                    _Pill(label: exercise.category, color: color),
                                    _Pill(
                                      label: '${exercise.duration} min',
                                      color: Colors.grey,
                                    ),
                                    _Pill(
                                      label: '${exercise.calories} kcal',
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
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
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  const _Pill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(28),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
