import 'package:notes/notes_db.dart';
import 'package:notes/notes_editor.dart';
import 'package:notes/notes_model.dart';
import 'package:flutter/material.dart';

class NotesView extends StatefulWidget {
  NotesDatabase? handler;
  NotesView({Key? key, this.handler}) : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesEditor(title: "", content: "",),));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget.handler!.getNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text("Something Went Wrong", style: TextStyle(color: Colors.red),),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title.toString()),
                  subtitle: Text(snapshot.data![index].content.toString(), style: TextStyle(overflow: TextOverflow.ellipsis),),
                  tileColor: index%2 == 0? Colors.deepPurple.shade100 : Colors.white,
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      widget.handler!.delete(int.parse(snapshot.data![index].id.toString()));
                      setState(() {});
                    },
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesEditor(title: snapshot.data![index].title.toString(), content: snapshot.data![index].content.toString(),),));
                  },
                );
              },);
          }
          else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
