function [alpha] = backtrack(alpha_guess, X, T, C, nn, gamma,delta,rhok)
%% BACKTRACKING ARMIJO-TYPE
% DESCRIPTION:
% Search method along a coordinate axis in which the search should be conducted 
% in both directions of the axis. It should also take into account the fact that 
% one direction nn.deltaW can be assigned such that alpha=0 represents a 
% local minimum point of the function g(alpha)=F(xk+alpha*nn.deltaW), for which 
% may not be able to find positive or negative values ??of alpha 
% close to 0 for which g(alpha)<g(0). If you do not want to use any 
% derivative, numerical "finished" procedures must define can 
% discriminate the situation. The model presented is an outline 
% Backtracking Armijo-type, based on the condition of acceptability of type "Parabolic". 
%
% function [alpha] = backtr(alpha_guess,nn.W,nn.deltaW,F,gamma,delta,rhok)
% INPUT:
%       NOTE: (*) indicates necessary input, the other variables are optional 
%       (*) alpha _guess - current steplength (1*1) [>0];
%       (*) nn.W           - current iterate    (N*1);
%       (*) nn.deltaW           - search direction   (N*1);
%           gamma        - constant provided by the user (1*1) [>0];
%           delta        - constant provided by the user (1*1) into the range [0,  1];
%           rhok         - constant provided by the user (1*1) into the range [0,  1];
%       (*) F            - function handle of the objective function (RN->R );
% OUTPUT:
%       alpha - value of alpha whether the condition holds (1*1);
% REVISION:
%       Ennio Condoleo - 21.15 13 Feb 2014 
% REFERENCE:
%       http://books.google.it/books?id=wXyLzZahvmsC&pg=PA123&lpg=PA123&dq=ottimizzazione+unidimensionale+senza+derivata&source=bl&ots=p5Be0KpbtX&sig=tLnygv0XZwzQYHoyPPfCZ2-e4C4&hl=it&sa=X&ei=CfL7UqfpFcXRhAfujYHIBA&ved=0CDQQ6AEwAQ#v=onepage&q=ottimizzazione%20unidimensionale%20senza%20derivata&f=false

if (nargin < 6)
    gamma = 1e-4;
    delta = 0.5;
    rhok  = 1e-8;
elseif (nargin < 7)
    delta = 0.5;
    rhok = 1e-8;
elseif (nargin < 8)
    rhok = 1e-8;
end
    J = nn.n - 1;
    nn = mynnff(nn, X, y_train, c_train);
    x_red = nn.a{nn.n - 1};
    b = nn.W{nn.n - 1};
    
    dWNorm = norm(cell2mat(nn.deltaW), 2);
    % positive direction (+)alpha
    alpha = alpha_guess;
    
    nn1 = nn;
    for j = 1:nn.n
        nn1.W{j} = nn1.W{j} + alpha .* nn1.deltaW{j};
    end
    
    nn1 = mynnff(nn1, X, y_train, c_train);
    x_red1 = nn1.a{nn1.n - 1};
    b1 = nn1.W{nn1.n - 1};
    
    L1 = LogPartialL(x_red1, T, C, b1);
    L = LogPartialL(x_red, T, C, b);
    while (L1 > L - gamma * alpha ^ 2 * dWNorm ^ 2) 
        if (alpha * dWNorm < rhok)   
            alpha  = 0;              % <-- failure to search for a value of alpha nonzero
        else
            alpha = alpha*delta;     % <-- reduction of the steplength
        end
        for j = 1:nn.n
            nn1.W{j} = nn1.W{j} + alpha .* nn1.deltaW{j};
        end
    
        nn1 = mynnff(nn1, X, y_train, c_train);
        x_red1 = nn1.a{nn1.n - 1};
        b1 = nn1.W{nn1.n - 1};

        L1 = LogPartialL(x_red1, T, C, b1);
    end 
    alpha1 = alpha;
    
    F1 = L1 - (L - gamma * alpha1 ^ 2 * (dWNorm ^ 2);
    
    % negative direction (-)alpha
    alpha = alpha_guess;
    
    for j = 1:nn.n
        nn1.W{j} = nn1.W{j} - alpha .* nn1.deltaW{j};
    end
    
    nn1 = mynnff(nn1, X, y_train, c_train);
    x_red1 = nn1.a{nn1.n - 1};
    b1 = nn1.W{nn1.n - 1};
    
    L1 = LogPartialL(x_red1, T, C, b1);
    L = LogPartialL(x_red, T, C, b);
    while (L1 > L - gamma * alpha ^ 2 * (dWNorm ^ 2))  
        if (alpha * dWNorm < rhok)
            alpha = 0;              % <-- failure to search for a value of alpha nonzero
        else
            alpha = alpha * delta;      % <-- reduction of the steplength
        end
    end
    alpha2 = -alpha;
    F2     = L1 - (L - gamma * alpha2 ^ 2 * (dWNorm ^ 2);

    % choice of the value of alpha for which it is provided with sufficient reduction 
    if (F1 < F2)           
        alpha = alpha1;
    else
        alpha = alpha2;
    end  
    
end