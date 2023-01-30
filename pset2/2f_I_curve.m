dt = 0.0001;
k = ceil(1/dt);
Ie = dt.*(1: k);
firerate = zeros(1, k);
for j = 1 : k
    [V,I,t,spikeTimes] = LIFmodel(Ie(j));
    if isempty(spikeTimes)
        firerate(j) = 0;
    else
        time = spikeTimes(1);
        firerate(j) = 1 / (time - 200);
    end
end

figure;
plot(Ie, firerate);
title("f-I curve")
xlabel("I_e")
ylabel("f.r.")
hold off
