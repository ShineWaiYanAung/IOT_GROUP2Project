import 'package:firebase_database/firebase_database.dart';

class DataBaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Read data from Firebase
  Future<Map<String, dynamic>> readData(String path) async {
    try {
      final snapshot = await _dbRef.child(path).get();
      if (snapshot.exists) {
        final data = snapshot.value;
        print('Raw data from Firebase: $data');

        // Convert _Map<Object?, Object?> to Map<String, dynamic>
        if (data is Map<Object?, Object?>) {
          final typedData = data.map((key, value) {
            if (value is Map<Object?, Object?>) {
              return MapEntry(key.toString(), value.map((k, v) => MapEntry(k.toString(), v)));
            }
            return MapEntry(key.toString(), value);
          });
          return typedData;
        } else {
          throw Exception('Data is not in expected format');
        }
      } else {
        throw Exception('Data not found');
      }
    } catch (e) {
      print('Error reading data: $e');
      throw e; // Rethrow the exception for further handling
    }
  }

  // Listen to data changes
  void listenToData(String path, Function(Map<String, dynamic>) onUpdate) {
    _dbRef.child(path).onValue.listen((event) {
      final data = event.snapshot.value;
      print('Snapshot value: $data');

      // Convert _Map<Object?, Object?> to Map<String, dynamic>
      if (data is Map<Object?, Object?>) {
        final typedData = data.map((key, value) {
          if (value is Map<Object?, Object?>) {
            return MapEntry(key.toString(), value.map((k, v) => MapEntry(k.toString(), v)));
          }
          return MapEntry(key.toString(), value);
        });
        onUpdate(typedData);
      } else {
        print('Data is not in expected format');
      }
    }).onError((error) {
      print('Error listening to data: $error');
    });



  }
  Future<void> updateData(String path, Map<String, dynamic> newData) async {
    try {
      await _dbRef.child(path).update(newData);
    } catch (e) {
      print('Error updating data at path $path: $e');
      throw Exception('Failed to update data: $e');
    }
  }
}
