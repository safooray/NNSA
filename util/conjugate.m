function StepSize = conjugate(Xred_train,y_train,c_train,b,nn)


%calculate step size based on tthe conjugate gradient descent method

alpha = 0.1;

for i=1:100
    S = alpha*i;
    f(i) = LogPartial(Xred_train+S*nn ,y_train, c_train, b(2:end));
end

m = min(f);

for i=1:100
    if(f(i) == m)
        StepSize = alpha * i;
    end
end