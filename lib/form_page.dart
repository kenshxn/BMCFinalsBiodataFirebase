import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // Biodata Controllers
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController careerGoalController = TextEditingController();
  final TextEditingController cellphoneController = TextEditingController();
  final TextEditingController civilStatusController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fieldOfInterestController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController hobbiesController = TextEditingController();
  final TextEditingController interestsController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveData() async {
    // Check if any field is empty
    if (aboutMeController.text.trim().isEmpty ||
        addressController.text.trim().isEmpty ||
        ageController.text.trim().isEmpty ||
        careerGoalController.text.trim().isEmpty ||
        cellphoneController.text.trim().isEmpty ||
        civilStatusController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty ||
        dateOfBirthController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        fieldOfInterestController.text.trim().isEmpty ||
        genderController.text.trim().isEmpty ||
        hobbiesController.text.trim().isEmpty ||
        interestsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    await firestore.collection('students').add({
      'aboutMe': aboutMeController.text.trim(),
      'address': addressController.text.trim(),
      'age': ageController.text.trim(),
      'careerGoal': careerGoalController.text.trim(),
      'cellphone': cellphoneController.text.trim(),
      'civilStatus': civilStatusController.text.trim(),
      'course': courseController.text.trim(),
      'dateOfBirth': dateOfBirthController.text.trim(),
      'email': emailController.text.trim(),
      'fieldOfInterest': fieldOfInterestController.text.trim(),
      'gender': genderController.text.trim(),
      'hobbies': hobbiesController.text.trim(),
      'interests': interestsController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Biodata saved successfully')),
    );

    // Clear all controllers
    aboutMeController.clear();
    addressController.clear();
    ageController.clear();
    careerGoalController.clear();
    cellphoneController.clear();
    civilStatusController.clear();
    courseController.clear();
    dateOfBirthController.clear();
    emailController.clear();
    fieldOfInterestController.clear();
    genderController.clear();
    hobbiesController.clear();
    interestsController.clear();
  }

  @override
  void dispose() {
    aboutMeController.dispose();
    addressController.dispose();
    ageController.dispose();
    careerGoalController.dispose();
    cellphoneController.dispose();
    civilStatusController.dispose();
    courseController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    fieldOfInterestController.dispose();
    genderController.dispose();
    hobbiesController.dispose();
    interestsController.dispose();
    super.dispose();
  }

  // Helper widget to reduce code repetition for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Biodata Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField(
              controller: aboutMeController,
              label: 'About Me',
              maxLines: 3,
            ),
            _buildTextField(
              controller: addressController,
              label: 'Address',
            ),
            _buildTextField(
              controller: ageController,
              label: 'Age',
              keyboardType: TextInputType.number,
            ),
            _buildTextField(
              controller: careerGoalController,
              label: 'Career Goal',
            ),
            _buildTextField(
              controller: cellphoneController,
              label: 'Cellphone',
              keyboardType: TextInputType.phone,
            ),
            _buildTextField(
              controller: civilStatusController,
              label: 'Civil Status',
            ),
            _buildTextField(
              controller: courseController,
              label: 'Course',
            ),
            _buildTextField(
              controller: dateOfBirthController,
              label: 'Date of Birth',
              hintText: 'MM/DD/YYYY',
            ),
            _buildTextField(
              controller: emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            _buildTextField(
              controller: fieldOfInterestController,
              label: 'Field of Interest',
            ),
            _buildTextField(
              controller: genderController,
              label: 'Gender',
            ),
            _buildTextField(
              controller: hobbiesController,
              label: 'Hobbies',
            ),
            _buildTextField(
              controller: interestsController,
              label: 'Interests',
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: saveData,
              child: const Text('Save Biodata to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}