import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multithreading_test/cubits/quotes_cubit.dart';
// import 'package:multithreading_test/quotesModel.dart';
// import 'package:multithreading_test/quotesModel.dart';

// import 'apicall.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final QuotesCubit quotesCubit = QuotesCubit();
  // final apiCall = RemoteServices();
  @override
  void initState() {
    super.initState();
    quotesCubit.getQuotes();
  }

  @override
  void dispose(){
    quotesCubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       
      ),
      body: StreamBuilder(
        stream: quotesCubit.stream,
        builder: (context, snapshot){
          if(snapshot.hasData){
           List quotes = snapshot.data as List;
            // return Text(quotes[0].toString());
            return ListView.builder(
                  itemCount: quotes.length,
                  itemBuilder: (context, index) {
                    final quote = quotes[index];
                    // print(quotes.length);
                    return InkWell(
                      onTap: () {
                        // quotesCubit.deleteQuotes();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(25)),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        elevation: 25,
                        color: Colors.green.shade100,
                        child: Container(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            children: [
                              Text(
                                quote.text?? "RANDOM QUOTES",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                quote.author == null
                                    ? "Random"
                                    : "- " + quote.author,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
            );

          }return const Center(child: CircularProgressIndicator());
          
        },
      ),
    );
  }
}