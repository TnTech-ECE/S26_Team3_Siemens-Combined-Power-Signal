clear

% Load the temperature data from a file
tempdata = readtable('Cable Data\Temp Data 11-24-26.csv');

% Extract all the parts of the temperature array and set the time
TxTemp = tempdata.TxTempCelsius;
TxTime = duration(string(tempdata.TxTimeDelta), 'InputFormat','mm:ss.S');
MiddleTemp = tempdata.MiddleTempCelsius;
MiddleTime = duration(string(tempdata.MiddleTimeDelta), 'InputFormat','mm:ss.S');
RxTemp = tempdata.RxTempCelsius;
RxTime = duration(string(tempdata.RxTimeDelta), 'InputFormat','mm:ss.S');

% Plot the temperatures on the same axis
scatter(TxTime, TxTemp, 'MarkerEdgeColor', '#ac00ff', 'DisplayName', 'Tx');
hold on
Midplt = scatter(MiddleTime, MiddleTemp, 'MarkerEdgeColor', '#00f907', 'DisplayName', 'Cable');
Rxplt = scatter(RxTime, RxTemp, 'MarkerEdgeColor', '#1c2cf5', 'DisplayName', 'Rx');
plot(TxTime, polyval(polyfit(seconds(TxTime), TxTemp, 1), seconds(TxTime)), 'Color', '#9e5ead')
plot(MiddleTime, polyval(polyfit(seconds(MiddleTime), MiddleTemp, 1), seconds(MiddleTime)), 'Color', '#43ad5e')
plot(RxTime, polyval(polyfit(seconds(RxTime), RxTemp, 1), seconds(RxTime)), 'Color', '#2d67ed')
hold off
xtickformat('mm:ss')
legend('Tx', 'Cable', 'Rx', 'Location','northwest');
xlabel('Time [mm:ss]')
ylabel('Temperature [\circ C]')
title('Temperature Data')