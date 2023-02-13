import 'package:flutter/material.dart';
import '../api.dart';



class CommentPage extends StatefulWidget {
  final int index;
  final List items;

  CommentPage({
    required this.index,
    required this.items
});



  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var comments = [];

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    final commentIds = List<int>.from(widget.items[widget.index]['kids']);
    final response = commentIds.map((id) => Api.getItem(id));
    final commentData = await Future.wait(response);
    setState(() {
      comments = commentData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        title: Text('Comments'),
      ),
      body: comments.isEmpty ? Center(child: CircularProgressIndicator(color: Colors.amber,)) : ListView.builder(
        itemCount: comments.length,
          itemBuilder: (context, index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,

            ),
            margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ListTile(
              minLeadingWidth: 10,
              leading: Text('${index + 1}.', style: TextStyle(fontSize: 18)),
              title: Text((comments[index]['text']??'')),


            ),

          );

          }
      ),

    );
  }
}
