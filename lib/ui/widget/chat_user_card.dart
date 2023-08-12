import 'package:cached_network_image/cached_network_image.dart';
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

      margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: const BorderSide(color: Colors.grey),),

      child: InkWell(onTap: (){},
        child:  ListTile(
         // leading: const Icon(CupertinoIcons.person),
        leading:  ClipRRect( borderRadius: const BorderRadius.all(Radius.circular(35 )),
          child: CircleAvatar(
            child: CachedNetworkImage(
              height: 50,width: 60,fit: BoxFit.cover,
                imageUrl: widget.user.image,
             //   placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const CircleAvatar(child: Icon(Icons.person),),
              ),
          ),
        ),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about,maxLines: 1,),
          trailing: ClipRRect(
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle,  color: Colors.green,),
              height: 15,width: 20,)),
        ),
      ),

    );
  }
}
