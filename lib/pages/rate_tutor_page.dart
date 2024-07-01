import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reviews_slider/reviews_slider.dart';   
import 'package:http/http.dart' as http;


class RatingPage extends StatefulWidget { 
    const RatingPage({ 
        super.key, 
    }); 
    @override 
    State < RatingPage > createState() => _RatingPageState(); 
} 
  
class _RatingPageState extends State <RatingPage> { 
  void sendRating(int rating) async {
    String apiUrl = 'https://ejemplo.com/api/datos'; 
    Map<int, dynamic> data = {
      rating : rating,
    };

    var response = await http.post(
      Uri.parse(apiUrl),
      body: data,
    );

    if (response.statusCode == 200) {
    } else {
    }
  }

  List < String > list = ['Horrible', 'Mal', 'Regular', 'Bueno', 'Genial']; 
  String selected_value = ""; 
  
    @override 
    Widget build(BuildContext context) { 
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
      return Scaffold( 
        appBar: AppBar(
          title: const Text("Calificar Tutoría",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 20)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.grey,
              height: 0.5,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
            child: ListBody(
              children: [
              const SizedBox(height: 100),
              const Text(
                '¿Qué opinas de tu tutor?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 65),
              Center( 
                child: ReviewSlider(  
                            initialValue: 2,  
                            options: list, 
                            onChange: (int value) { 
                                selected_value = list[value]; 
                                setState(() { 
                                }); 
                            } 
                        ), 
                    ), 
                const SizedBox(height: 25),
                Center(
                  child: 
                    Text(selected_value, style: const TextStyle( 
                          color: Colors.black, 
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                      ), 
                    ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: 
                    Text('Calificación: ${(list.indexOf(selected_value))+1}/5', style: const TextStyle( 
                          color: Colors.black, 
                          fontSize: 16,
                      ), 
                    ),
                ),
              const SizedBox(height: 65),
              SizedBox(
              width: 200,
              child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text("Gracias por calificarnos", style: TextStyle( 
                          color: Color(0xffEE8A6F), 
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                      ),),
                    content: const Text("Trabajamos para ayudarte siempre y cuando lo necesites!"),
                    actions: [
                    TextButton(
                      onPressed: (){
                         Navigator.pop(context);
                      }, 
                      child: const Text("De nada!",  style: TextStyle( 
                          color: Color(0xffEE8A6F), 
                      ),)
                    ),
                    ],
                  ),
                );
                var ratetoSend = list.indexOf(selected_value)+1;
                sendRating(ratetoSend);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:const Color(0xffEE8A6F),
                padding: const EdgeInsets.symmetric(
                horizontal: 60, vertical: 10),
              ),
              child: const Text(
                'Envíar!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:  Colors.white,
                ),
              ),
              
              ),
            ), 
            ], 
            ), 
            ),
        ); 
    } 
}




