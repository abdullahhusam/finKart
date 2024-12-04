import 'package:finkart/features/orders/view_models/orders_view_model.dart';
import 'package:finkart/features/shared/colors/colors.dart';
import 'package:finkart/features/shared/components/custom_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrdersGraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ordersByDate = context.watch<OrdersViewModel>().ordersByDate;
    int? previousMonth;

    return Scaffold(
      // appBar: AppBar(title: Text('Orders Graph')),
      body: ordersByDate.isEmpty
          ? Center(
              child: CustomButton(
              borderRadius: 20,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              backgroundColor: whiteColor,
              fontColor: primaryColor,
              width: 250,
              text: "Unable to load graph, Reload?",
              onPressed: () =>
                  context.read<OrdersViewModel>().loadOrdersByDate(),
            )
              // ElevatedButton(
              //   onPressed: () =>
              //       context.read<OrdersViewModel>().loadOrdersByDate(),
              //   child: Text('Load Orders'),
              // ),
              )
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getGraphData(ordersByDate),
                      isCurved: true,
                      barWidth: 4,
                      color: primaryColor,
                      belowBarData: BarAreaData(
                          show: false), // Hide the area below the line
                      dotData: FlDotData(show: false), // Hide dots
                    ),
                  ],
                  minY: 0,
                  maxY: 120, // Limit the Y-axis maximum value to 120
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final date = DateTime.fromMillisecondsSinceEpoch(
                              value.toInt());
                          if (value.toInt() % 2 == 0) {
                            if (previousMonth == null ||
                                previousMonth != date.month) {
                              previousMonth =
                                  date.month; // Update the last displayed month
                              print(value);
                              return Text(DateFormat('MM/dd').format(date));
                            } else {
                              // Skip rendering
                              return const SizedBox.shrink();
                            }
                          }
                          return const SizedBox
                              .shrink(); // Default for other cases
                        },
                        reservedSize: 30, // Space for X-axis labels
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(value
                              .toInt()
                              .toString()); // Y-axis label formatting
                        },
                        reservedSize: 30, // Y-axis labels Space
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: false), // Disable the right axis
                    ),
                    topTitles: const AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: false), // Disable the top axis
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  gridData: const FlGridData(
                    show: true,
                    drawVerticalLine: false, // Hide vertical grid lines
                    drawHorizontalLine: true, // Show horizontal grid lines
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      // tooltip: Colors.blueAccent,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final date = DateTime.fromMillisecondsSinceEpoch(
                              spot.x.toInt());
                          final formattedDate =
                              DateFormat('MM/dd/yyyy').format(date);
                          return LineTooltipItem(
                            formattedDate,
                            const TextStyle(
                                color: whiteColor, fontWeight: FontWeight.bold),
                          );
                        }).toList();
                      },
                    ),
                    touchCallback: (event, touchResponse) {
                      // Optional: Implement additional functionality on touch
                    },
                    handleBuiltInTouches: true,
                  ),
                ),
              ),
            ),
    );
  }

  List<FlSpot> _getGraphData(Map<String, int> ordersByDate) {
    int cumulativeCount = 0;
    return ordersByDate.entries.map((entry) {
      cumulativeCount += entry.value;
      final date = DateTime.parse(entry.key);
      return FlSpot(
        date.millisecondsSinceEpoch.toDouble(),
        cumulativeCount.toDouble(),
      );
    }).toList();
  }
}
