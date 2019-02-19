function [positions, velocities] = enckes(videoFileName, T, fps, makePlot)
% Produces a video file of simulated orbits of N bodies based on Encke's
% method. Inputs are the name of the video file (videoFileName), the number
% of timesteps (T), the number of frames per second (fps) and makePlot
% (boolean to toggle producing video). Outputs are the final positions and
% velocities.

%% Physical Parameters

load planets.mat masses positions velocities N;

%% Simulation Parameters

if makePlot
    vidObj = VideoWriter(videoFileName);
    vidObj.Quality = 100;
    vidObj.FrameRate = fps;
    
    open(vidObj);
    accel = zeros(size(velocities));
    figure('visible','on');
    hold on;
end

%% Run Simulation

for tstep = 1:T
    %% Calculate Acceleration
    accel = zeros(3,N); 
    
    % add new stuff here to calcualte acceleration in x/y/z
    
    %% Generate Plots
    
    if makePlot
        % Plot new positions
        scatter3(positions(1,:),positions(2,:),positions(3,:));
        hold on;
        scatter3(positions(1,1),positions(2,1),positions(3,1), ... Sun
            'r','filled');
        scatter3(positions(1,4),positions(2,4),positions(3,4), ... Earth
            'g', 'filled');
        scatter3(positions(1,4),positions(2,4),positions(3,4), ... Moon
            1, [0.5 0.5 0.5], '.', 'filled');
        
        positions(:,:) = positions + velocities;
        velocities(:,:) = velocities + accel;
        
        % Axis limits
        ylim([-25,25]);
        xlim([-25,25]);
        zlim([-25,25]);
        writeVideo(vidObj,getframe(gcf));
        close(gcf);
    end

end

    if makePlot
        close(vidObj);
    end


end

