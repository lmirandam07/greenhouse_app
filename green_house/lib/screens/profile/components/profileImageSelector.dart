import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/firestore_services/firestore_services.dart';

class ProfileImageSelector extends StatefulWidget {
  final String userId;
  final String currentImageUrl;
  final Function(String) onImageSelected;
  final firestoreService = FirestoreService();

  ProfileImageSelector({
    required this.userId,
    required this.currentImageUrl,
    required this.onImageSelected,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileImageSelectorState createState() => _ProfileImageSelectorState();
}

class _ProfileImageSelectorState extends State<ProfileImageSelector> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late Reference _storageReference;
  String? _imageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _storageReference = _storage.ref().child('user/${widget.userId}/profile');
    _imageUrl = widget.currentImageUrl;
  }

  Future<void> _getImage() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final url = await _storageReference.getDownloadURL();
      setState(() {
        _imageUrl = url;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error getting profile image URL: $e');
    }
  }

  Future<void> _uploadImage() async {
    try {
      final image = await ImagePicker().getImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _isLoading = true;
        });
        final file = File(image.path);
        final uploadTask = _storageReference.putFile(file);
        final snapshot = await uploadTask;
        final imageUrl = await snapshot.ref.getDownloadURL();
        widget.onImageSelected(imageUrl);
        setState(() {
          _imageUrl = imageUrl;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error uploading profile image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : () => _uploadImage(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_imageUrl != null)
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(_imageUrl!),
            ),
          if (_isLoading) CircularProgressIndicator(),
        ],
      ),
    );
  }
}
