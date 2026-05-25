import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class UserDetailScreen extends StatefulWidget {
  final String userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _currentUid = FirebaseAuth.instance.currentUser!.uid;
  bool _isFollowing = false;
  bool _isLoading = true;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userDoc =
    await _firestore.collection('users').doc(widget.userId).get();
    final followDoc = await _firestore
        .collection('users')
        .doc(_currentUid)
        .collection('following')
        .doc(widget.userId)
        .get();

    setState(() {
      _userData = userDoc.data();
      _isFollowing = followDoc.exists;
      _isLoading = false;
    });
  }

  Future<void> _toggleFollow() async {
    final currentUserRef =
    _firestore.collection('users').doc(_currentUid);
    final targetUserRef =
    _firestore.collection('users').doc(widget.userId);

    if (_isFollowing) {
      // Unfollow
      await currentUserRef
          .collection('following')
          .doc(widget.userId)
          .delete();
      await targetUserRef
          .collection('followers')
          .doc(_currentUid)
          .delete();
      await targetUserRef
          .update({'followers': FieldValue.increment(-1)});
      await currentUserRef
          .update({'following': FieldValue.increment(-1)});
    } else {
      // Follow
      await currentUserRef
          .collection('following')
          .doc(widget.userId)
          .set({'followedAt': FieldValue.serverTimestamp()});
      await targetUserRef
          .collection('followers')
          .doc(_currentUid)
          .set({'followedAt': FieldValue.serverTimestamp()});
      await targetUserRef
          .update({'followers': FieldValue.increment(1)});
      await currentUserRef
          .update({'following': FieldValue.increment(1)});
    }

    setState(() => _isFollowing = !_isFollowing);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Text(_userData?['name'] ?? 'Profile',
            style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade700,
                    child: Text(
                      (_userData?['name'] ?? 'U')[0].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_userData?['name'] ?? '',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(_userData?['email'] ?? '',
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  if ((_userData?['bio'] ?? '').isNotEmpty)
                    Text(_userData!['bio'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 16),
                  // Follow + Message buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _toggleFollow,
                        icon: Icon(
                            _isFollowing
                                ? Icons.person_remove
                                : Icons.person_add,
                            size: 18),
                        label: Text(_isFollowing ? 'Unfollow' : 'Follow'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFollowing
                              ? Colors.grey
                              : Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              receiverId: widget.userId,
                              receiverName: _userData?['name'] ?? '',
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.message, size: 18),
                        label: const Text('Message'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue.shade700,
                          side: BorderSide(color: Colors.blue.shade700),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _stat('Followers',
                          _userData?['followers']?.toString() ?? '0'),
                      Container(
                          height: 40, width: 1, color: Colors.grey.shade300),
                      _stat('Following',
                          _userData?['following']?.toString() ?? '0'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label,
            style:
            const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}