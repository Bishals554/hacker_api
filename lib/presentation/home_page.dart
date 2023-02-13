import 'package:flutter/material.dart';
import '../api.dart';
import 'comment_page.dart';






class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final topStories = [];
  var items = [];

  @override
  void initState() {
    super.initState();
    getTopStories();
  }

  getTopStories() async {
    final topStories = await Api.getTopStories();
    final response = topStories.take(20).map((itemId) => Api.getItem(itemId));
    final itemData = await Future.wait(response);


    setState(() {
      items = itemData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: Text('Top News'),
      ),
      body: items.isEmpty ? Center(child: CircularProgressIndicator(color: Colors.amber,)): ListView.builder(
        itemCount: items.length,
          itemBuilder: (context, index){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ListTile(
                  minLeadingWidth: 20,
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentPage(index: index, items: items)));
                 },
                  leading: Text('${index + 1}.', style: TextStyle(fontSize: 18)),
                  title: Text(items[index]['title'],style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),),
                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                ),
              );
          }
      ),
    );
  }
}
