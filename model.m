data = csvread("BentonCountyCasesFromJan21.csv")';
t = (1:size(data))';

startDate = datenum('21-Jan-2020');
endDate = addtodate(startDate, size(data)-1, "day")(1);
dates = startDate:endDate;

N = 85579; % Population of Benton County

SEIR_IR = @(p, x) sum(N*SEIR(p, x)(:,[3 4]), 2);
params0 = [0.1, 1];
params = lsqcurvefit(SEIR_IR, params0, t, data, [0 0], [1 10]);
model = SEIR(params, t)*N;

hold on
plot(dates, model(:,2:end), 'linewidth', 2)
plot(dates, data, 'linewidth', 2)
plot(dates, sum(model(:,[3 4]), 2), 'color', [0.5 0.5 0.5], '--', 'linewidth', 2)
axis([startDate endDate])
legend('Exposed', 'Infected', 'Recovered', 'Confirmed cases', 'Infected + Recovered', 'location', 'northwest')
datetick("x", "mm/dd/yy", "keeplimits")
ylabel("People")
xlabel("Date")

