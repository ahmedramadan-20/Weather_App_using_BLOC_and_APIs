import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/my_data.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(
          API_Key,
          language: Language.ENGLISH,
        );

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        print(weather);
        emit(
          WeatherBlocSuccess(weather),
        );
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
