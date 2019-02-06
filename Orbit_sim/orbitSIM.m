%% Planetary Orbit Simulator (Script for debugging)
%% Constants
% Saving these in case we need easier numbers to try solving at first...
% distances = [0 57.9 108.2 149.6 227.9 778.6 1433.5 2872.5 4495.1 5906.4]; % [km]
% velocities = [0 47.4 35.0 29.8 24.1 13.1 9.7 6.8 5.4 4.7]; % [km/s]

% We will keep masses regardless...
                   % Sun  Merc  V    E    Moon  Mars  J    S   U    N   P
 masses = 10^24.*[1988500 0.330 4.87 5.97 0.073 0.642 1898 568 86.8 102 0.0146]; % [kg]
 N = length(masses); % Number of bodies
 
 %% Position & Velocity Data
 [posSun, velSun] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Sun');
[posMerc, velMerc] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Mercury');
[posV, velV] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Venus');
[posE, velE] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Earth'); 
[posMoon, velMoon] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Moon');
[posMars, velMars] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Mars');
[posJ, velJ] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Jupiter');
[posS, velS] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Saturn');
[posU, velU] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Uranus');
[posN, velN] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Neptune');
[posP, velP] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Pluto');

positions = [posSun(:) posMerc(:) posV(:) posE(:) posMoon(:) posMars(:) posJ(:) ...
    posS(:) posU(:) posN(:) posP(:)]; % [km]
velocities = [velSun(:) velMerc(:) velV(:) posE(:) velMoon(:) velMars(:) velJ(:) ...
    velS(:) velU(:) velN(:) velP(:)]; % [km/s]



G = 6.674e-11; % Gravitational constant
T = 100 % Number of timesteps
masses = [masses;masses;masses] % adjust masses for 
correctedPosition = get(gcf,'Position') + [21 -125 0 0];

fps = 20; sec = 10;
%more appropriate would be seconds per frame (SPF)?
spf = 10*86400

vidObj = VideoWriter('newfile2.avi');
vidObj.Quality = 100;
vidObj.FrameRate = fps;

open(vidObj);
T=200

% Influence of the other 10 bodies on the Earth
for tstep = 1:T
    accel = zeros(3,N);    
    for i = 1:N
        for j = 1:N
            if i ~= j    
                accel(:,i) = accel(:,i)+(G*masses(:,j).*(positions(:,j)-positions(:,i))) ./ ...
                            (abs(positions(:,j)-positions(:,i))).^3;
            end
                                               
        end
    end
    
    positions = positions + velocities;
    velocities = velocities + (accel*spf)./masses;
    figure('visible','on')
    scatter3(positions(1,:),positions(2,:),positions(3,:))
    
    writeVideo(vidObj,getframe(gcf));
    close(gcf)
    %% To do: save positions to matrix for generating animation (3xNxT)
end
    close(vidObj);
% not sure how to keep updating this with time? good luck Blaine