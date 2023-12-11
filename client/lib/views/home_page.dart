import 'package:flutter/material.dart';
import '../models/vehicle.dart';
import '../services/vehicle_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Vehicle>> vehiclesFuture;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final variantController = TextEditingController();

  @override
  void initState() {
    super.initState();
    vehiclesFuture = VehicleApi.getAllVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(
            "Vehicles Log",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<Vehicle>>(
          future: vehiclesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.teal),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching vehicles: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No vehicles available.'),
              );
            } else {
              return _buildVehicleList(snapshot.data!);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialogBox();
          },
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleList(List<Vehicle> vehicles) {
    return ListView.builder(
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return ListTile(
          title: Text(vehicle.name),
          subtitle: Text(vehicle.variant),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.teal,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDialogBox() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Vehicle'),
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    nameController.text = value;
                  },
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vehicle name cannot be empty.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) {
                    nameController.text = value;
                  },
                  decoration: const InputDecoration(labelText: 'Variant'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vehicle variant cannot be empty.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _addVehicle(
                      nameController.text.trim(), nameController.text.trim());
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addVehicle(String name, String variant) async {
    try {
      await VehicleApi.addVehicle(name, variant);
      setState(() {
        vehiclesFuture = VehicleApi.getAllVehicles();
      });
    } catch (e) {
      print('Error adding vehicle: $e');
    }
  }
}
