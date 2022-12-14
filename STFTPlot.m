%STFT plot


%Spectrum plot

z=[0 0];
p=0;
s=[0 0];
s_index=[0 0];
num=1;
SNR_Average=0;
for l=120:1:130
    for x = 1:1:Length
        z(x) =y(x+Length*(l-1)-(overlap*Length)*(l-1)); 
    end
    
    p = abs(fft(z));
    stem(p);
    for x = 1:1:Length
       SNR_Average = SNR_Average + p(x); 
    end
    SNR_Average = SNR_Average/Length;
     for x = 1:1:Length
        if p(x)>(SNR_Average)
            s(num)=p(x);
            s_index(num)=x;
            num=num+1;
        end
     end
    SNR_Average=0;
    for x = 1:1:length(s)
       SNR_Average = SNR_Average + s(x); 
    end
    SNR_Average = SNR_Average/length(s);
    SNR_Average = SNR_Average*2;
end
