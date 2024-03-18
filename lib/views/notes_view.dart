import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ozan/db/db_provider.dart';
import 'package:ozan/db/notes.dart';
import 'package:ozan/views/update_view.dart';
import 'package:provider/provider.dart';
import 'package:popover/popover.dart';


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
          }, icon: Icon(CupertinoIcons.arrow_left, color: Theme.of(context).colorScheme.tertiary),
          
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
        
                          Expanded(
        
                            child: Row(

                              children: [

                                const Expanded(flex: 2,child: SizedBox()),

                                Expanded(
                                
                                  flex: 7,
                                
                                  child: ListView.builder(
                                  
                                    scrollDirection: Axis.vertical,
                                                                                          
                                    itemCount: snapshot.data!.length,
                                    
                                    itemBuilder:(context, index) {
                                      
                                      return Column(
                                      
                                        children: [
                                      
                                          Text(snapshot.data![index].date, textScaler: const TextScaler.linear(1.5),),
                                      
                                          InkWell(
                                  
                                          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                                  
                                          highlightColor: Colors.transparent,
                                  
                                          splashFactory: null,
                                                                  
                                          onTap: (){
                                  
                                            Navigator.push(context, MaterialPageRoute(builder:(context){
                                              
                                              return Scaffold(

                                                    body: Row(

                                                      children: [

                                                        Expanded(flex: 3, child: SizedBox(

                                                          child: Padding(

                                                            padding: const EdgeInsets.all(20.0),

                                                            child: Column(
                                                            
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                            
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            
                                                              children: [
                                                                IconButton(onPressed: (){
                                                                  Navigator.pop(context);
                                                                }, icon: const Icon(CupertinoIcons.arrow_left)),
                                                              ],
                                                            ),
                                                          ),
                                                        )),

                                                        Expanded(flex: 8, child: Padding(

                                                          padding: const EdgeInsets.all(26),

                                                          child: Update(note: snapshot.data![index]),
                                                        )),

                                                        const Expanded(flex: 3, child: SizedBox()),

                                                      ],
                                                    ),
                                                  );
                                            }));
                                          },
                                  
                                          child: Container(
                                            
                                              margin: const EdgeInsets.fromLTRB(14, 14, 14, 20),
                                                                
                                              padding: const EdgeInsets.all(20),
                                            
                                              decoration: BoxDecoration(
                                            
                                                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                                            
                                                border: Border.all(width: 1, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.4)),
                                            
                                                borderRadius: BorderRadius.circular(23)
                                              ),
                                                                
                                              child: Column(
                                                              
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                              
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                              
                                                children: [
                                                              
                                                  Row(
                                                              
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                              
                                                    children: [
                                                      
                                                      Text(snapshot.data![index].title, textScaler: const TextScaler.linear(2)),
                                              
                                                      Builder(
                                                                            
                                                        builder: (context) {
                                                                                              
                                                          return IconButton(onPressed: (){
                                                          
                                                            showPopover(context: context, 
                                                                                              
                                                            backgroundColor: Colors.transparent,
                                                                                              
                                                            direction: PopoverDirection.left,
                                                                                              
                                                            shadow: List.empty(),
                                                                                              
                                                            arrowWidth: 0, arrowHeight: 0,
                                                            
                                                            bodyBuilder:(context) {
                                                          
                                                              return SizedBox(
                                                          
                                                                child: IconButton(onPressed: (){
                                                                                              
                                                                                                                                                                        value.dbHelper.delete(snapshot.data![index].id);
                                                                
                                                                value.initDatabase();
                                                                
                                                                value.setLength();
                                                                                              
                                                                Navigator.pop(context);
                                                                                              
                                                                }, icon: Icon(CupertinoIcons.delete, size: 20, color: Theme.of(context).colorScheme.tertiary), style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary), padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(18, 18, 18, 18))))
                                                          
                                                              );
                                                            },
                                                          );
                                                          
                                                          }, icon: const Icon(CupertinoIcons.ellipsis_vertical, size: 24), padding: EdgeInsets.zero);
                                                        }
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },  
                                  ),
                                ),

                                const Expanded(flex: 2,child: SizedBox()),
                              ],
                            ),
                          ),
                        ],
                      )
                    );
                  }
        
                  else {
                    
                    return Visibility(
        
                      visible: snapshot.connectionState == ConnectionState.done,
        
                      child: Expanded(
                
                        child: Column(
        
                          mainAxisAlignment: MainAxisAlignment.center,
        
                          children: [
        
                            Center(
                            
                              child: Icon(FluentIcons.add_48_regular, size: 100, color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3))

                            ),
        
                            const Gap(25),
        
                            Text("Your canvas is blank.", textScaler: const TextScaler.linear(2.2), style: TextStyle(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.3))),

                            const Gap(100),
                          ],
                        ),
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

Color categoryColor(String category, context){

    if(category == 'Personal'){
      return Theme.of(context).colorScheme.tertiaryContainer;
    }
    else if(category == 'Office'){
      return Theme.of(context).colorScheme.primaryContainer;
    }
    return Theme.of(context).colorScheme.secondaryContainer;
}