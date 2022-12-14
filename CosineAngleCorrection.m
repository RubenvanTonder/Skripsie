%COSINE ANGLE CORRECTION FOR A SINGLE TRACKED VEHICLE
num=1;
%Tracking calculation
for n=startFrame:1:endFrame
    max_FFT_index=0;
    max_FFT=0;
    sample_Array = [0 0];
    for b = 1:1:Length
       sample_Array(b)=y(b+Length*(n-1)-(overlap*Length)*(n-1));
    end
    g=abs(fft(sample_Array));
    %Get max FFT
    for x = (round(speedLimit*19.49*Length/Fs)):1:Length/2
        if max_FFT<g(x)
           max_FFT=g(x);
           max_FFT_index=x;
        end
    end
    %Test if Signal is above noise level
    if max_FFT>SNR
        if abs(frequency-max_FFT_index)<=round(bins)
            if tracked==1 & num>=2
               R = R - (timeStep*(1-overlap))*(tracked_speed2(num-1)/3.6); 
            end
            tracked=1;
            %Convert to speed and correct cosine angle
            speed=(frequency*Fs/Length)/19.49;
            if (R-3)>d
            cosineAngle=atand(d/R);
            end
            speed = speed/cosd(cosineAngle);
            %Checked if signal is above speed limit threshold
            if speed>=speedLimit
                tracked_speed2(num)=speed;
                num=num+1;
            end
        else
           speed=0;
           R=Rmax;
           tracked=0;
        end
    end
     frequency=max_FFT_index;
end
time = zeros(1,length(tracked_speed2));
for x=1:1:length(tracked_speed2)
    time(x) = (x-1)*(Length/Fs)*(1-overlap);
end
tracked_speed2(1)=0;
plot(time,tracked_speed2);
