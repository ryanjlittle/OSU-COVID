data = csvread("BentonCountyCasesFromJan21.csv")';
t = (1:size(data))';

N = 85579; % Population of Benton County

params0 = [0.1, 1];
SEIR_I = @(p, x) SEIR(p, x)(:,3)*N;
params = lsqcurvefit(SEIR_I, params0, t, data, [0 0], [1 10]);

hold on
plot(t, SEIR(params, t)(:,2:end)*N)
plot(data)
legend('Exposed', 'Infected', 'Recovered', 'Confirmed cases')

