import 'package:flutter/material.dart';
import 'package:weather_app/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic> data = {};

  void loadData() async {
    if (_controller.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some city name'),
        ),
      );
    } else {
      data = await fetchWeatherData(_controller.text);

      if (data.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong or City name not valid'),
          ),
        );
      } else {
        // Update the ui using setstate.
        setState(() {});
        // ignore: avoid_print
        print(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JOY WEATHER APP"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter your city name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.amber, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: ElevatedButton(
                    onPressed: loadData, child: const Text("SUBMIT")),
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width - 40,
                child: data.isEmpty
                    ? const Center(
                        child: Text("No data avilable"),
                      )
                    : Column(children: [
                        Text("City Name : ${data["location"]["name"]}"),
                        Text("Country Name : ${data["location"]["country"]}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Weather Condition : ${data["current"]["condition"]["text"]}"),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.network(
                              "https:${data["current"]["condition"]["icon"]}",
                              height: 50,
                              width: 50,
                            )
                          ],
                        ),
                        Text(
                            "Temperature : ${data["current"]["feelslike_c"]} degree C"),
                        Text("Wind Speed : ${data["current"]["wind_kph"]} KMP"),
                      ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
