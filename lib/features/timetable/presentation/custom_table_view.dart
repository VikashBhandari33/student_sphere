import 'package:flutter/material.dart' hide TableRow;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_sphere/features/timetable/domain/custom_table_entity.dart';
import 'package:student_sphere/features/timetable/presentation/custom_table_controller.dart';
import 'package:uuid/uuid.dart';

class CustomTableView extends ConsumerWidget {
  final String tableId;

  const CustomTableView({super.key, required this.tableId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableState = ref.watch(customTableControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Table View')),
      body: tableState.when(
        data: (tables) {
          final table = tables.firstWhere(
            (t) => t.id == tableId,
            orElse: () => CustomTableEntity(
              id: '',
              title: 'Not Found',
              columns: [],
              rows: [],
              userId: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

          if (table.id.isEmpty) {
            return const Center(child: Text('Table not found'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      table.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ElevatedButton.icon(
                      onPressed: () =>
                          _showAddColumnDialog(context, ref, tableId),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Column'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: table.columns.isEmpty
                    ? const Center(
                        child: Text(
                            'No columns added. Click "Add Column" to start.'))
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          child: DataTable(
                            columns: [
                              ...table.columns.map((col) => DataColumn(
                                    label: Text(col.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ],
                            rows: table.rows.map((row) {
                              return DataRow(
                                cells: table.columns.map((col) {
                                  final cellValue = row.cells[col.id] ?? '';
                                  return DataCell(
                                    Text(cellValue.toString()),
                                    onTap: () => _editCell(context, ref,
                                        tableId, row, col, cellValue),
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addRow(ref, tableId),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addRow(WidgetRef ref, String tableId) {
    final newRow = TableRow(
      id: const Uuid().v4(),
      cells: {},
    );
    ref.read(customTableControllerProvider.notifier).addRow(tableId, newRow);
  }

  void _showAddColumnDialog(
      BuildContext context, WidgetRef ref, String tableId) {
    final nameController = TextEditingController();
    ColumnType selectedType = ColumnType.text;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Column'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Column Name'),
              ),
              const SizedBox(height: 16),
              DropdownButton<ColumnType>(
                value: selectedType,
                items: ColumnType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => selectedType = val);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  final newColumn = TableColumn(
                    id: const Uuid().v4(),
                    name: nameController.text,
                    type: selectedType,
                  );
                  ref
                      .read(customTableControllerProvider.notifier)
                      .addColumn(tableId, newColumn);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _editCell(BuildContext context, WidgetRef ref, String tableId,
      TableRow row, TableColumn col, dynamic currentValue) {
    final controller = TextEditingController(text: currentValue.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${col.name}'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          keyboardType: col.type == ColumnType.number
              ? TextInputType.number
              : TextInputType.text,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final updatedCells = Map<String, dynamic>.from(row.cells);
              updatedCells[col.id] = controller.text;

              // We need a way to update a specific row.
              // For now, let's assume we update the whole table or add a specific method.
              // Since our repository only has addRow, we might need to implement updateRow or just update the whole table entity.
              // For simplicity in this iteration, let's update the whole table entity logic in controller or add updateRow to repo.
              // Actually, let's just re-use updateTable from controller by constructing the new table object.

              final tables = ref.read(customTableControllerProvider).value;
              if (tables != null) {
                final table = tables.firstWhere((t) => t.id == tableId);
                final updatedRows = table.rows.map((r) {
                  if (r.id == row.id) {
                    return r.copyWith(cells: updatedCells);
                  }
                  return r;
                }).toList();

                final updatedTable = table.copyWith(
                    rows: updatedRows, updatedAt: DateTime.now());
                ref
                    .read(customTableControllerProvider.notifier)
                    .updateTable(updatedTable);
              }

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
