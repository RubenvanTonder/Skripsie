%SPEED CALCULATIONS FROM SAMPLED DOPPLER RADAR
%read data in from WAV file
%[y,Fs] = audioread('real_car_testE.wav');

% Define parameters
speed= [0 0];
speed_kmh=0;
frequency=0;
sample_Array = zeros(Length,1);
time = zeros(1,length(speed));
hold on;
%STFT calculation
for n=startFrame:1:(endFrame/(1-overlap))
    max_FFT_index=0;
    max_FFT=0;
    s=[0 0];
    s_index=[0 0];
    num=1;
    SNR_Average=0;
    for b = 1:1:Length
       sample_Array(b)=y(b+Length*(n-1)-(overlap*Length)*(n-1));
    end
    g=abs(fft(sample_Array));

    for x = (round(speedLimit*19.49*Length/Fs)):1:Length/2
        if max_FFT<g(x)
           max_FFT=g(x);
           max_FFT_index=x;
        end
    end
    
    %Dyaminc SNR
    for x = 1:1:Length
       SNR_Average = SNR_Average + g(x); 
    end
    SNR_Average = SNR_Average/Length;
     for x = 1:1:Length
        if g(x)>(SNR_Average)
            s(num)=g(x);
            s_index(num)=x;
            num=num+1;
        end
     end
    
    for x = 1:1:length(s)
       SNR_Average = SNR_Average + s(x); 
    end
    SNR_Average = SNR_Average/length(s);
    SNR_Average = SNR_Average*0.1;
    SNR=SNR_Average;

    if max_FFT>SNR
        speed_kmh=(max_FFT_index*Fs/Length)/19.49;
       if speed_kmh>=speedLimit 
            speed(n)=speed_kmh;
            
       end
    end
end

xlabel("Time(s)");
ylabel("Speed(km/h)");
title("Measured Speed from Doppler sensor");
grid on