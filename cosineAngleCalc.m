%COSINE ANGLE CORRECTION FOR A SINGLE TRACKED VEHICLE
R=distance;
d=6;
cosineCorrectedSpeed=tracked_speed1;
for x=7:1:118
    R = R - (timeStep*(1-overlap))*(cosineCorrectedSpeed(x-1)/3.6);
    if (R-6)>d
            cosineAngle=atand(d/R);
            end
    cosineCorrectedSpeed(x) = cosineCorrectedSpeed(x)/cosd(cosineAngle);
end
plot(time,cosineCorrectedSpeed);