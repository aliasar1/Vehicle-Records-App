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
            "Vehicles Record",
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
            _showDialogBox(false, null);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: Colors.grey.shade200,
                  title: Text(vehicle.name),
                  subtitle: Text(vehicle.variant),
                  leading: IconButton(
                    onPressed: () {
                      _showDialogBox(true, vehicle);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.teal,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _deleteVehicle(vehicle.id);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vehicle deleted successfully."),
                      ));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 65,
        ),
      ],
    );
  }

  Future<void> _showDialogBox(bool isEdit, Vehicle? vehicle) async {
    if (isEdit) {
      nameController.text = vehicle!.name;
      variantController.text = vehicle.variant;
    }
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isEdit ? 'Edit Vehicle' : 'Add Vehicle',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.23,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
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
                      controller: variantController,
                      onChanged: (value) {
                        variantController.text = value;
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
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                clearFields();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isEdit) {
                    _editVehicle(vehicle!);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vehicle updated successfully.")));
                  } else {
                    _addVehicle(
                      nameController.text.trim(),
                      variantController.text.trim(),
                    );
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Vehicle added successfully.")));
                  }
                  clearFields();
                }
              },
              child: isEdit ? const Text('Edit') : const Text('Add'),
            ),
          ],
          scrollable: true,
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _deleteVehicle(String id) async {
    try {
      await VehicleApi.deleteVehicle(id);
      setState(() {
        vehiclesFuture = VehicleApi.getAllVehicles();
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _editVehicle(Vehicle vehicle) async {
    try {
      await VehicleApi.updateVehicle(vehicle.id, nameController.text.trim(),
          variantController.text.trim());

      setState(() {
        vehiclesFuture = VehicleApi.getAllVehicles();
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void clearFields() {
    nameController.clear();
    variantController.clear();
  }
}
