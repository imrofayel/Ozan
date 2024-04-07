import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:gap/gap.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:ozan/markdown/markdown_style.dart';
import 'package:ozan/views/update_view.dart';
import 'package:provider/provider.dart';


class NotesView extends StatefulWidget {
  
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {

  @override
  void initState(){    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DatabaseProvider>(

      builder: (context, value, child){
      
      return Scaffold(

        appBar: AppBar(

          leadingWidth: 80,

          leading: IconButton.filled(onPressed: (){
            Navigator.pop(context);
          }, 
          
          icon: Icon(CupertinoIcons.arrow_left, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent)),
          
          ),
        ),

        body: Column(
          
          children: [
            
              FutureBuilder(
        
                future: value.notesList,
        
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  
                  if(snapshot.hasData && snapshot.data!.isNotEmpty){
                    
                    return Expanded(

                      child: Column(
                      
                        children: [
                      
                          FilledButton(onPressed: (){}, style: ButtonStyle(
                            
                            side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                      
                            padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text('${snapshot.data!.length} entries', style: TextStyle(fontSize: 17, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),
                          
                          const Gap(14),
                      
                          Expanded(
                                                    
                            child: Padding(

                              padding: const EdgeInsets.all(12),

                              child: GridView.builder(
                                                        
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400),
                              
                                scrollDirection: Axis.vertical,
                                              
                                itemCount: snapshot.data!.length,
                                
                                itemBuilder:(context, index) {
                                  
                                  return InkWell(
                              
                                    overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                                                            
                                    highlightColor: Colors.transparent,
                                                                            
                                    splashFactory: null,
                              
                                    onTap: (){
                                      
                                      Navigator.push(context, MaterialPageRoute(builder:(context){
                                                  
                                        return Scaffold(
                                                      
                                          body: Row(
                                                      
                                            children: [
                                                      
                                              Expanded(flex: 2, child: SizedBox(
                                                      
                                                child: Padding(
                                                      
                                                  padding: const EdgeInsets.all(20.0),
                                                      
                                                  child: Column(
                                                                
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                
                                                  children: [
                                                    
                                                    IconButton(onPressed: (){
                                                      
                                                      Navigator.pop(context);
                                                                      
                                                    }, 
                                                                    
                                                    icon: Icon(CupertinoIcons.arrow_left, size: 22, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.6)), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent))),
                                                                    
                                                  ],
                                                ),
                                              ),
                                            )),
                                                      
                                            Expanded(flex: 10, child: Padding(
                                                      
                                              padding: const EdgeInsets.all(26),
                                                      
                                              child: Update(note: snapshot.data![index]),
                                            )),
                                                      
                                            const Expanded(flex: 2, child: SizedBox()),
                                                      
                                          ],
                                        ),
                                      );
                                    }));
                                  },
                              
                                    child: Container(
                                      
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                                              
                                        border: Border.all(color: Theme.of(context).colorScheme.secondary),
                                                              
                                        borderRadius: BorderRadius.circular(14)
                                      ),
                                                              
                                      margin: const EdgeInsets.all(8),
                                                              
                                      padding: const EdgeInsets.all(8),
                                                            
                                      child: Column(
                                      
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      
                                        children: [
                                      
                                          Row(
                              
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              
                                            children: [
                              
                                              FilledButton(onPressed: (){}, style: ButtonStyle(
                                                
                                                side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                                                                                  
                                                padding: const MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background)), child: Text(snapshot.data![index].date, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),
                              
                                                Row(

                                                  children: [

                                                  FilledButton(onPressed: (){

                                                    value.dbHelper.update(NotesModel(title: snapshot.data![index].title, description: snapshot.data![index].description, date: snapshot.data![index].date, id: snapshot.data![index].id, favourite: 1));

                                                    value.initDatabase();
                                                    
                                                    value.setLength();

                                                  }, style: const ButtonStyle(
                                                    
                                                    padding: MaterialStatePropertyAll(EdgeInsets.all(14)), overlayColor: MaterialStatePropertyAll(Colors.transparent), shadowColor: MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Colors.transparent)), child: Icon(snapshot.data![index].favourite == 0 ? CupertinoIcons.heart : CupertinoIcons.heart_fill, color: snapshot.data![index].favourite == 0 ? Theme.of(context).colorScheme.tertiary : Colors.red)),

                                                    SizedBox(child: Delete(id: snapshot.data![index].id)),

                                                  ],
                                                ),
                                            ],
                                          ),
                                                  
                                          const Gap(10),
                                    
                                          Padding(
                                    
                                            padding: const EdgeInsets.only(left: 8),
                                    
                                            child: Text(snapshot.data![index].title, textScaler: const TextScaler.linear(1.5)),
                                          ),
                                    
                                          const Gap(14),
                                    
                                          Expanded(
                                            
                                            child: Container(
                                              
                                              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background, border: Border.all(color: Theme.of(context).colorScheme.secondary), borderRadius: BorderRadius.circular(10)),
                                              
                                              child: markdown(snapshot.data![index].description, 1.14, context))
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },  
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
        
                  else {
                    
                    return Visibility(
        
                      visible: snapshot.connectionState == ConnectionState.done,
        
                      child: Row(
                          
                        mainAxisAlignment: MainAxisAlignment.center,
                      
                        children: [
                              
                          FilledButton(onPressed: (){}, style: ButtonStyle(
                                              
                            side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)),
                                                                                
                            padding: const MaterialStatePropertyAll(EdgeInsets.all(20)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), shadowColor: const MaterialStatePropertyAll(Colors.transparent), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), child: Text('Your canvas is blank', style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8), fontFamily: 'Inter'))),
                        ],
                      ),
                    );
                  }
                },
              ),
            ]
          )
        );
      }
    );
  }
}

// ignore: must_be_immutable
class Delete extends StatelessWidget {

  Delete({super.key, required this.id});

  int? id;

  @override
  Widget build(BuildContext context) {

    return Consumer<DatabaseProvider>(builder:(context, value, child) =>

      Builder(
                                                                                  
      builder: (context) {
      
      return IconButton(onPressed: (){
                                                                
        showPopover(context: context,

           barrierColor: Colors.transparent,
           
           backgroundColor: Colors.transparent,
           
           direction: PopoverDirection.left,
          
           shadow: List.empty(),
          
           arrowWidth: 0, arrowHeight: 0,
                                                                  
           bodyBuilder:(context) {
                                                                
            return SizedBox(
                                                                
              child: IconButton(onPressed: (){
                
                value.dbHelper.delete(id);
                                                                      
                value.initDatabase();
                                                                      
                value.setLength();

                Navigator.pop(context);
              }, 
              
              icon: Icon(CupertinoIcons.delete, size: 20, 
              
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.8)), 
              
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.background), side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.secondary)), overlayColor: const MaterialStatePropertyAll(Colors.transparent), padding: const MaterialStatePropertyAll(EdgeInsets.all(13)), shadowColor: const MaterialStatePropertyAll(Colors.transparent), surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent)))                                                 
              );
            },
          );                                                       
         }, icon: const Icon(CupertinoIcons.ellipsis, size: 20), padding: EdgeInsets.zero);
        }
      ),
    );
  }
}