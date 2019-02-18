%% Planetary Orbit Simulator (Script for debugging)
%% Constants
% Saving these in case we need easier numbers to try solving at first...
% distances = [0 57.9 108.2 149.6 227.9 778.6 1433.5 2872.5 4495.1 5906.4]; % [km]
% velocities = [0 47.4 35.0 29.8 24.1 13.1 9.7 6.8 5.4 4.7]; % [km/s]

% We will keep masses regardless...
                  % Sun   Merc   V      E      Moon    Mars    
masses = 10^24.*[1988550 0.33011 4.8675 5.9723 0.07346 0.64171 ...
    1,898.19 568.34 86.813 102.413 0.01303]; % [kg]
%   J        S      U      N       P
N = length(masses); % Number of bodies
 
 %% Position & Velocity Data
[posSun, velSun] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Sun','421','km');
[posMerc, velMerc] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Mercury','421','km');
[posV, velV] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Venus','421','km');
[posE, velE] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Earth','421','km'); 
[posMoon, velMoon] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Moon','421','km');
[posMars, velMars] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Mars','421','km');
[posJ, velJ] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Jupiter','421','km');
[posS, velS] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Saturn','421','km');
[posU, velU] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Uranus','421','km');
[posN, velN] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Neptune','421','km');
[posP, velP] = planetEphemeris(juliandate(2000,1,1),'SolarSystem','Pluto','421','km');

positions = [posSun(:) posMerc(:) posV(:) posE(:) posMoon(:) posMars(:) posJ(:) ...
    posS(:) posU(:) posN(:) posP(:)] % [m]
velocities = [velSun(:) velMerc(:) velV(:) posE(:) velMoon(:) velMars(:) velJ(:) ...
    velS(:) velU(:) velN(:) velP(:)] % [m/s]



G = 6.67408e-11; % Gravitational constant
T = 50 % Number of timesteps
%masses = [masses;masses;masses] % adjust masses for 
correctedPosition = get(gcf,'Position') + [21 -125 0 0];

fps = 20; sec = 10;
%more appropriate would be seconds per frame (SPF)?
spf = 1*86400

vidObj = VideoWriter('newfile2.avi');
vidObj.Quality = 100;
vidObj.FrameRate = fps;

open(vidObj);
accel = zeros(size(velocities));
figure('visible','on')
hold on

% Influence of the other 10 bodies on the Earth
for tstep = 1:T
    accel = zeros(3,N);    
    for i = 1:N
        for j = 1:N
            if i ~= j    
                d = sqrt((positions(1,j)-positions(1,i))^2 + (positions(2,j)-positions(2,i))^2 + (positions(3,j)-positions(3,i))^2);
%                 accel(:,j) = (accel(:,i)+(G.*masses(j).*(positions(:,j)-positions(:,i))) ./ ...
%                        (abs(positions(:,j)-positions(:,i))).^3);
                accel(1,i) = (accel(1,i)+(G*masses(j)*(positions(1,j)-positions(1,i))) / ...
                            (d.^3));
                accel(2,i) = (accel(2,i)+(G*masses(j)*(positions(2,j)-positions(2,i))) / ...
                            (d.^3));
                accel(3,i) = (accel(3,i)+(G*masses(j)*(positions(3,j)-positions(3,i))) / ...
                            (d.^3));
    % Try computing acceleration in X Y and Z directions separately?
                 
            end

            %%                      
        end
        nxtpos = positions(:,i) - velocities(:,i)
        mArrow3(positions(:,i), nxtpos)

        %% Transformation of 
    end
    lastpositions = positions
    scatter3(positions(1,:),positions(2,:),positions(3,:))
    hold on
    scatter3(positions(1,1),positions(2,1),positions(3,1),'*')
    accel = accel * (1/1)
    positions(:,:) = positions + velocities;
    velocities(:,:) = velocities + (accel*spf);
    
        % Axis Limits
    ylim([-1E10,1E10]);
    xlim([-1E10,1E10]);
    zlim([-1E10,1E10]);
    writeVideo(vidObj,getframe(gcf));
    close(gcf)
    %% To do: save positions to matrix for generating animation (3xNxT)
end
    close(vidObj);
