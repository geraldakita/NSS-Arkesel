import 'package:flutter/material.dart';
import 'package:weather_app/client.dart';
import 'package:weather_app/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  WeatherModel? weather;
  List<dynamic>? hourly_temp;
  List<dynamic>? hourly_date;
  List<Widget>? hourly_cast;
  List<Widget>? hourly_cast_date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x212121),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Current Weather",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              const Icon(
                Icons.sunny,
                color: Colors.amber,
                size: 64,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "${weather?.currentWeather["temperature"] ?? 0}°C",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () async {
                  print("test");
                  weather = await WeatherApiClient().request();
                  print(weather?.currentWeather);
                  hourly_temp = weather?.hourly["temperature_2m"];
                  hourly_date = weather?.hourly["time"];
                  hourly_cast = hourly_temp
                      ?.map((e) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$e°C",
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ))
                      .toList();

                  hourly_cast_date = hourly_date
                      ?.map((e) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "$e",
                              style:
                                  const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ))
                      .toList();

                  setState(() {});
                },
                child: const Text("Get Data"),
              ),
              Container(
                margin: const EdgeInsets.all(22),
                color: const Color(0xFF313131),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: hourly_cast_date == null
                          ? [const Text("Empty")]
                          : hourly_cast_date!,
                    ),
                    Column(
                      children:
                          hourly_cast == null ? [const Text("Empty")] : hourly_cast!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
