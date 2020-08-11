function y = SEIR(params, x)
    beta = params(1);
    E0 = params(2);
    
    sigma = 0.196; % 1/(5.1 days), the average latent period of COVID-19 
    gamma = 0.071; % 1/(14 days), the average time from symptom onset to recovery (WHO)

    ode = @(t,y) [-beta*y(1)*y(3);             % dS/dt = -beta*S*I
                  beta*y(1)*y(3) - sigma*y(2); % dE/dt = beta*S*I - sigma*E
                  sigma*y(2) - gamma*y(3);     % dI/dt = sigma*E - gamma*I
                  gamma*y(3)                   % dR/dt = gamma*I
                 ];

    [t,y] = ode45(ode, 1:max(x), [1-E0 E0 0 0]); 

