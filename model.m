data = csvread("BentonCountyCasesFromJan21.csv")';
t = (1:size(data))';

startDate = datenum('21-Jan-2020');
endDate = addtodate(startDate, size(data)-1, "day")(1);
%OSUStart = datenum('23-Sep-2020');
daysAhead = 2000; % OSU start is 246 days ahead
OSUStart = addtodate(startDate, daysAhead-1, "day")(1);
dates = startDate:endDate;
datesUntilOSU = startDate:OSUStart;
t2 = (1:daysAhead)';

N = 85579; % Population of Benton County

SEIR_IR = @(p, x) sum(N*SEIR(p, x)(:,[3 4]), 2);
params0 = [0.1, 1];
params = lsqcurvefit(SEIR_IR, params0, t, data, [0 0], [1 10])
model = SEIR(params, t2)*N;

model(199, :)
model(246, :)

hold on
%plot(datesUntilOSU', model(:,2:end), 'linewidth', 2)
plot(datesUntilOSU', model, 'linewidth', 2)
%plot(dates, data, 'linewidth', 2)
%plot(datesUntilOSU', sum(model(:,[3 4]), 2), '--', 'linewidth', 2)
%plot([OSUStart, OSUStart], [400 0], 'b')
plot([endDate, endDate], [100000 0], 'b')
axis([startDate OSUStart])
legend('Susceptible', 'Exposed', 'Infected', 'Recovered', 'location', 'northeast')
%legend('Exposed', 'Infected', 'Recovered', 'Confirmed cases', 'Infected + Recovered', 'location', 'northwest')
datetick("x", "mm/dd/yy", "keeplimits")
ylabel("People")
xlabel("Date")

