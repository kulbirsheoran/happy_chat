import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_chat/model/chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user ;
  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {

  @override
  Widget build(BuildContext context) {
    return Card(//color: Colors.lightBlue,
      elevation: 15,

      margin: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(color: Colors.grey),),

      child: InkWell(onTap: (){},
        child:  ListTile(
          leading: Icon(CupertinoIcons.person),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about,maxLines: 1,),
          trailing: Text('time'),
        ),
      ),

    );
  }
}
