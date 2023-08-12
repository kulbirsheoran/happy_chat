import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:happy_chat/model/chat_user.dart';

class ApiService {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  //for storing self information
  static late  ChatUser me;

  static Future<bool> userExists() async {
    return (await fireStore.collection('users').doc(user.uid).get()).exists;
  }
  // for user info
  static Future<void> getSelfInfo() async {
     await fireStore.collection('users').doc(user.uid).get().then((user) async => {
       if(user.exists){
         me = ChatUser.fromJson(user.data()!)
       }else{
         await createUser().then((value) => getSelfInfo())
    }
     });
  }

  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: user.photoURL.toString(),
        name: user.displayName.toString(),
        about: 'Hey I am using happy chat',
        createdAt: time,
        isOnline: false,
        lastActive: time,
        id: user.uid,
        email: user.email.toString(),
        pushToken: '');
    return (await fireStore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson()));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return fireStore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
