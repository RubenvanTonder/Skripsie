%TRACKING OF A SINGLE VEHCILE
num = 1;
frequencyBin = Length/50;
BinRange = Length/frequencyBin;
DArray = zeros(BinRange,round(frames/(1-overlap)));
SNR=0.2;
speed=zeros(1,round(frames/(1-overlap)));
number=zeros(1,round(frames/(1-overlap)));
%Tracking calculation
for n=startFrame:1:round(endFrame/(1-overlap))
    sample_Array = [0 0];
    for b = 1:1:Length
       sample_Array(b)=y(b+Length*(n-1)-(overlap*Length)*(n-1));
    end
    g=abs(fft(sample_Array));
    for i=1:1:BinRange
        for x =(1+(i-1)*frequencyBin):1:(i*frequencyBin)
            if SNR<g(x)
               DArray(i,n)=x*Fs/Length/19.49;
            end
        end
     end
end
answer=size(DArray);
for i=1:1:answer(1)
        for n=1:1:answer(2)
            if DArray(i,n)>20 && DArray(i,n)<50
                speed(n)=speed(n) + DArray(i,n);
                number(n)=number(n)+1;
            end
        end     
end

for n=1:1:answer(2)
    if number(n)>1
       speed(n)=speed(n)/number(n) ;
    end
end

%Improve Accuracy
for x=1:1:length(speed)
   if speed(x)==0 && x>2
      if (speed(x-1)>speedLimit && speed(x+1)>speedLimit) 
          speed(x) = (speed(x-1)+speed(x+1))/2;
      end
      
   end
end
%Improve Accuracy
for x=1:1:length(speed)
   if speed(x)==0 && x>2
      if (speed(x-1)>speedLimit && speed(x+1)>speedLimit) 
          speed(x) = (speed(x-1)+speed(x+1))/2;
      end
      
   end
end
time = zeros(1,length(speed));
for x=1:1:length(speed)
    time(x) = (x-1)*(Length/Fs)*(1-overlap);
end

plot(time,speed);
ylabel('Speed(km/h)');
xlabel('Time(s)');
