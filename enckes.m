function [positions, velocities] = enckes(videoFileName, T, fps, ...
    makePlot, centerObj, orbitingObj, perObj)
% Produces a video file of simulated orbits of N bodies based on Encke's
% method.
% Inputs are:
% * The name of the video file (videoFileName)
% * The number of timesteps (T)
% * The number of frames per second (fps)
% * A boolean to toggle producing video (makePlot)
% * An integer specifying which object is the center of orbit (centerObj)
% * An integer specifying which object is the orbiting object (orbitingObj)
% * An integer specifying which object is the perturbing object (perObj)
% Outputs are:
% * The final positions
% * The final velocities

%% Physical Parameters

load planets.mat masses positions velocities;

%% Simulation Parameters

if makePlot
    vidObj = VideoWriter(videoFileName);
    vidObj.Quality = 100;
    vidObj.FrameRate = fps;
    
    open(vidObj);
    figure('visible','on');
    hold on;
end

%% Run Simulation

% Constants
mu = masses(centerObj) + masses(orbitingObj);
deltat = 1; % time step of 1 day to seconds

% Initial Conditions
posCenter = positions(:,centerObj);
posOrb = positions(:,orbitingObj);
posPer = positions(:,perObj);
velOrb = velocities(:,orbitingObj);
r = posOrb;
p = posOrb - posCenter;
dotp = 0;

for tstep = 1:T
    % Calculate Acceleration
    aper = masses(perObj)*(posPer-posOrb)/norm(posPer-posOrb)^3;
    accel = aper + mu*(p/norm(p)^3 - r/norm(r)^3);
    
    % Generate Plots
    if makePlot
        % Plot new positions
        hold on;
        scatter3(posCenter(1), posCenter(2), posCenter(3), 'g','filled');
        scatter3(posOrb(1), posOrb(2), posOrb(3), ...
            'k', 'filled');
        scatter3(posPer(1), posPer(2), posPer(3), 'r', 'filled');
        
        % Axis limits
        ylim([-2,2]);
        xlim([-2,2]);
        zlim([-2,2]);
        writeVideo(vidObj,getframe(gcf));
        close(gcf);
    end
    
    % Update positions and velocities (rectification)
    posOrb = posOrb + velOrb*deltat;
    velOrb = velOrb + accel*deltat;
    
    r = r + velOrb*deltat;
    ddotp = -mu*(p/norm(p)^3);
    p = p + dotp;
    dotp = dotp + ddotp;
    
end

if makePlot
    close(vidObj);
end

end

