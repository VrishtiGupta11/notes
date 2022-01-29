import 'package:notes/notes_db.dart';
import 'package:notes/notes_model.dart';
import 'package:notes/notes_viewer.dart';
import 'package:flutter/material.dart';
import 'package:notes/notes_db.dart';

class NotesEditor extends StatefulWidget {
  String title = "", content = "";
  NotesEditor({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  _NotesEditorState createState() => _NotesEditorState();
}

class _NotesEditorState extends State<NotesEditor> {

  late NotesDatabase handler;
  final _formKey = GlobalKey<FormState>();

  bool focus = true;

  FocusNode titleFocus = FocusNode();
  FocusNode contentFocus = FocusNode();
  FocusNode addButtonFocus = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<int> addNotes() async{
    List<Notes> listofNotes = [];
    Notes notes = Notes(
      title: titleController.text,
      content: contentController.text,
    );
    listofNotes.add(notes);
    return await handler.insert(listofNotes);
  }

  bool bold = false;
  bool fontSize = false;

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.title;
    contentController.text = widget.content;
    Size sized = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        // focus = false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Notes"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesEditor(title: "", content: "",),));
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesView(handler: handler,),));
              },
              icon: const Icon(Icons.notes),
            ),
          ],
        ),
        body: Scrollbar(
            child: SizedBox(
              child: StatefulBuilder(
                builder: (context, setState) {
                  handler = NotesDatabase();
                  handler.initializeDB();
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                              )
                            ]
                        ),
                        child: TextFormField(
                          cursorColor: Colors.deepPurple,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: titleFocus,
                          controller: titleController,
                          autofocus: true,
                          textCapitalization: TextCapitalization.words,
                          validator: (value){
                            if(value!.isEmpty || value.trim().isEmpty){
                              return 'Title is required';
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Title',
                            filled: true,
                            isDense: true,
                            prefixIcon: const Icon(Icons.title, size: 25, color: Colors.grey,),
                            // contentPadding: EdgeInsets.only(left: 30),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              gapPadding: 0,
                              borderSide: BorderSide.none,
                            ),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder : OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 8,
                        child: Container(
                            margin: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                  )
                                ]
                            ),
                            child: Scrollbar(
                              child: TextFormField(
                                style: bold ? const TextStyle(fontWeight: FontWeight.bold) : const TextStyle(fontWeight: FontWeight.normal),
                                cursorColor: Colors.deepPurple,
                                maxLines: 35,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                focusNode: contentFocus,
                                controller: contentController,
                                autofocus: false,
                                textCapitalization: TextCapitalization.sentences,
                                validator: (value){
                                  if(value!.isEmpty || value.trim().isEmpty){
                                    return 'Content is required';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Content',
                                  filled: true,
                                  isDense: true,
                                  // prefixIcon: Icon(Icons.restaurant, size: 25, color: Colors.grey,),
                                  // icon: Icon(Icons.content_paste),
                                  // contentPadding: EdgeInsets.only(left: 30),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    gapPadding: 0,
                                    borderSide: BorderSide.none,
                                  ),
                                  enabled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder : OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none
                                  ),
                                ),
                                // maxLength: int.parse(sized.height.toString()),
                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 20,),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: 35,
                          width: 100,
                          child: TextButton(
                            focusNode: addButtonFocus,
                            onPressed: () {
                              if(titleController.text.isNotEmpty && contentController.text.isNotEmpty){
                                handler = NotesDatabase();
                                handler.initializeDB().whenComplete(() async{
                                  await addNotes();
                                  setState(() {});
                                });
                                // addNotes();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotesView(handler: handler,),));
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and Content are required")));
                              }
                            },
                            child: Text('Add', style: TextStyle(color: Colors.white),),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.deepPurpleAccent,
                              elevation: 8,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          // height: 35,
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: (){
                                    bold = !bold;
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.format_bold)
                              ),
                              // SizedBox(width: 5,),
                              IconButton(
                                  onPressed: (){

                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.format_italic)
                              ),
                              // SizedBox(width: 5,),
                              IconButton(
                                  onPressed: (){

                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.format_underline)
                              ),
                              // SizedBox(width: 5,),
                              IconButton(
                                  onPressed: (){

                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.format_size)
                              ),
                              // SizedBox(width: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: (){

                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.circle, color: Colors.black,)
                                    ),
                                    IconButton(
                                        onPressed: (){

                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.circle, color: Colors.red,)
                                    ),
                                    IconButton(
                                        onPressed: (){

                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.circle, color: Colors.yellow,)
                                    ),
                                    IconButton(
                                        onPressed: (){

                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.circle, color: Colors.blue,)
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
        ),
      ),
    );
  }
}
