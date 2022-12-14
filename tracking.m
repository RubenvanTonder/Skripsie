%TRACKING OF A SINGLE VEHCILE
distance=0;
for n=startFrame:1:(endFrame/(1-overlap))
    z=[0 0];
    p=0;
    s=[0 0];
    s_index=[0 0];
    num=1;
    SNR_Average=0;
    max_FFT_index=0;
    max_FFT=0;
    sample_Array = [0 0];
    for b = 1:1:Length
       sample_Array(b)=y(b+Length*(n-1)-(overlap*Length)*(n-1));
    end
    g=abs(fft(sample_Array));
    if n==5
      
    end
    for x =(round(speedLimit*19.49*Length/Fs)):1:Length/2
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
    SNR_Average=0;
    for x = 1:1:length(s)
       SNR_Average = SNR_Average + s(x); 
    end
    SNR_Average = SNR_Average/length(s);
    SNR_Average = SNR_Average*0.1;
    SNR=SNR_Average;
    if n==5
       SNR; 
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
 
    
    if max_FFT>SNR
        if abs(frequency-max_FFT_index)<=round(bins)
            speed=(frequency*Fs/Length)/19.49;
            if speed>=speedLimit 
                tracked_speed1(n)=speed;
               
            end
        else
            speed=0;
            
        end
    end
     frequency=max_FFT_index;
end
%Improve Accuracy
for x=1:1:length(tracked_speed1)
   if tracked_speed1(x)==0 && x>2
      if (tracked_speed1(x-1)>speedLimit && tracked_speed1(x+1)>speedLimit) 
          tracked_speed1(x) = (tracked_speed1(x-1)+tracked_speed1(x+1))/2;
      end
      
   end
end
time = zeros(1,length(tracked_speed1));
for x=1:1:length(tracked_speed1)
    time(x) = (x-1)*(Length/Fs)*(1-overlap);
end
for x=4:1:121
    %distance=distance+tracked_speed1(x)*timeStep/3.6*(1-overlap);
    
end
plot(time,tracked_speed1);
title('Measured Speed');
xlabel('Time(s)');
ylabel('Speed(km/h)');
grid on;
%spectrogram(y,kaiser(256,5),220,512,Fs,'yaxis')

