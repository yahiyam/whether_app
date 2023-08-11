import 'package:flutter/material.dart';
import '../constants/images.dart';

class WeatherDataTable extends StatelessWidget {
  final int? temperature;
  final int? pressure;
  final int? humidity;
  final int? cloudCover;

  const WeatherDataTable({
    super.key,
    this.temperature,
    this.pressure,
    this.humidity,
    this.cloudCover,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.0),
        1: FlexColumnWidth(2.0),
        2: FlexColumnWidth(1.0),
      },
      children: [
        _buildTableRow(AppImages.temp, 'Temperature', '$temperature °C'),
        _buildTableRow(AppImages.pressure, 'Pressure', '$pressure hPa'),
        _buildTableRow(AppImages.humidity, 'Humidity', '$humidity%'),
        _buildTableRow(AppImages.cover, 'Cloud Cover', '$cloudCover%'),
      ],
    );
  }

  TableRow _buildTableRow(
    String icon,
    String label,
    String? value,
  ) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            icon,
            height: 50,
            alignment: Alignment.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                value ?? 'N/A',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
