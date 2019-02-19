%% Planet Data
% Set up initial and expected positions, velocities, and masses.

clear all; close all;

names = [{'Sun'}, {'Mercury'}, {'Venus'}, {'Earth'}, {'Moon'}, {'Mars'}, ...
    {'Jupiter'}, {'Saturn'}, {'Uranus'}, {'Neptune'}, {'Pluto'}];

N = length(names); % Number of bodies

%% Mass
% Mass * gravitational constant (GM) in au^3/day^2 courtesy of NASA. 

masses = [0.295912208285591100E-03, ... Sun
          0.491248045036476000E-10, ... Mercury
          0.724345233264412000E-09, ... Venus
          0.888769244512563400E-09, ... Earth
          0.109318945074237400E-10, ... Moon
          0.954954869555077000E-10, ... Mars
          0.282534584083387000E-06, ... Jupiter
          0.845970607324503000E-07, ... Saturn
          0.129202482578296000E-07, ... Uranus
          0.152435734788511000E-07, ... Neptune
          0.217844105197418000E-11]; ... Pluto

%% Initial Position and Velocity Values
% Initial positions (au) and velocities (au/day) of the Sun and planets at
% Julian day (TDB) 2440400.5 (June 28, 1969), given with respect to the
% integration origin in the ICRF2 frame. Courtesy of NASA.

posSun = [0.00450250878464055477 0.00076707642709100705 0.00026605791776697764];
velSun = [-0.00000035174953607552 0.00000517762640983341 0.00000222910217891203];
posMerc = [0.36176271656028195477 -0.09078197215676599295 -0.08571497256275117236];
velMerc = [0.00336749397200575848 0.02489452055768343341 0.01294630040970409203];
posV = [0.61275194083507215477 -0.34836536903362219295 -0.19527828667594382236];
velV = [0.01095206842352823448 0.01561768426786768341 0.00633110570297786403];
posE = [0.12051741410138465477 -0.92583847476914859295 -0.40154022645315222236];
velE = [0.01681126830978379448 0.00174830923073434441 0.00075820289738312913];
posMoon = [-0.00080817735147818490 -0.00199462998549701300 -0.00108726268307068900];
velMoon = [0.00060108481561422370 -0.00016744546915764980 -0.00008556214140094871];
posMars = [-0.11018607714879824523 -1.32759945030298299295 -0.60588914048429142236];
velMars = [0.01448165305704756448 0.00024246307683646861 -0.00028152072792433877];
posJ = [-5.37970676855393644523 -0.83048132656339789295 -0.22482887442656542236];
velJ = [0.00109201259423733748 -0.00651811661280738459 -0.00282078276229867897];
posS = [7.89439068290953155477 4.59647805517127300705 1.55869584283189997764];
velS = [-0.00321755651650091552 0.00433581034174662541 0.00192864631686015503];
posU = [-18.26540225387235944523 -1.16195541867586999295 -0.25010605772133802236];
velU = [0.00022119039101561468 -0.00376247500810884459 -0.00165101502742994997];
posN = [-16.05503578023336944523 -23.94219155985470899295 -9.40015796880239402236];
velN = [0.00264276984798005548 -0.00149831255054097759 -0.00067904196080291327];
posP = [-30.48331376718383944523 -0.87240555684104999295 8.91157617249954997764];
velP = [0.00032220737349778078 -0.00314357639364532859 -0.00107794975959731297];

positions = [posSun(:) posMerc(:) posV(:) posE(:) posMoon(:) ...
    posMars(:) posJ(:) posS(:) posU(:) posN(:) posP(:)]; % [au]
velocities = [velSun(:) velMerc(:) velV(:) velE(:) velMoon(:) ...
    velMars(:) velJ(:) velS(:) velU(:) velN(:) velP(:)]; % [au/day]

save planets.mat names N masses positions velocities;

%% Expected Position and Velocity Values
% Actual positions and velocities for June 28, 1970 were pulled from NASA
% JPL data through Matlab's built-in planetEphemeris() function. Distances
% are in au and velocities are in au/day with respect to the solar system's
% barycenter in the DE421 model.

[posSunf, velSunf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Sun','421','AU');
[posMercf, velMercf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Mercury','421','AU');
[posVf, velVf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Venus','421','AU');
[posEf, velEf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Earth','421','AU'); 
[posMoonf, velMoonf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Moon','421','AU');
[posMarsf, velMarsf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Mars','421','AU');
[posJf, velJf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Jupiter','421','AU');
[posSf, velSf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Saturn','421','AU');
[posUf, velUf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Uranus','421','AU');
[posNf, velNf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Neptune','421','AU');
[posPf, velPf] = planetEphemeris(juliandate(1970,6,28),'SolarSystem','Pluto','421','AU');

expectedPos = [posSunf(:) posMercf(:) posVf(:) posEf(:) posMoonf(:) ...
    posMarsf(:) posJf(:) posSf(:) posUf(:) posNf(:) posPf(:)]; % [au]
expectedVel = [velSunf(:) velMercf(:) velVf(:) velEf(:) velMoonf(:) ...
    velMarsf(:) velJf(:) velSf(:) velUf(:) velNf(:) velPf(:)]; % [au/day]

save planetsExpected.mat names expectedPos expectedVel;