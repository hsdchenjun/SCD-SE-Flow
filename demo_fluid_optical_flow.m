clc;
close all;
clear;

% load settings
%****************************************
 st = parameter_settings();
 st.pyramid_factor = 0.5;
 st.warps = 5; % the numbers of warps per level
 st.max_its = 2; % the number of equation iterations per warp
 h = figure('Name', 'Optical flow');
 %****************************************
 
%Please select an image type 
%*****************************************
%Illumination image sequence
%****************************************
%fluid_type ='RubberWhale';
%fluid_type ='Hydrangea';
%fluid_type ='Poiseuille'; %gradient flow
fluid_type ='Lamb-Oseen'; %Lamb-Oseen flow
%fluid_type ='Uniform';    %Translation motion
%fluid_type ='Sink';       %Divergence motion
%fluid_type ='Vortex';     %Rotation motion
%fluid_type ='DNS turbulence';
%********************************************

%****************************************
%fluid_type ='DNS-turbulence';
%fluid_type ='SQG';
%fluid_type ='JHTDB-iso';
%fluid_type ='JHTDB-channel';
%fluid_type ='JHTDB-hd';
%fluid_type ='JHTDB-mhd';

%fluid_type ='Typhoon';
%fluid_type ='White Ovals';
%******************************************

if strcmp(fluid_type,'RubberWhale')
I1 = imread('data/RubberWhale/RubberWhale_illumination_img1.png');
I2 = imread('data/RubberWhale/RubberWhale_illumination_img2.png');
groundtruthpath='data/RubberWhale/RubberWhale_groundtruth.flo';
groundtruth='true';
show_flow =1; 
st.sigma = 8;
st.sharpness = 0.03;
st.alpha = 0.01;
st.lambda = 0.03;
S = 0; 
end
 
if strcmp(fluid_type,'Hydrangea')
I1 = imread('data/Hydrangea/Hydrangea_illumination_img1.png');
I2 = imread('data/Hydrangea/Hydrangea_illumination_img2.png');
groundtruthpath='data/Hydrangea/Hydrangea_groundtruth.flo';
groundtruth='true';
show_flow =1; 
st.sigma = 3;
st.sharpness = 0.03;
st.alpha = 0.01;
st.lambda = 0.02;
S = 0; 
end

if strcmp(fluid_type,'Poiseuille')
fprintf(fluid_type);    
I1 = imread('data/Poiseuille/Poiseuille_illumination_img1.png');
I2 = imread('data/Poiseuille/Poiseuille_illumination_img2.png');
groundtruthpath = 'data/Poiseuille/Poiseuille_groundtruth.flo';
groundtruth='true';

show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 0; 
downsample = 25;
flow_scale = 2.5;
streamlines_factor = 4;
end

if strcmp(fluid_type,'Lamb-Oseen')
fprintf(fluid_type);    
I1 = imread('data/Lamb-Oseen/Lamb-Oseen_illumination_img1.png');
I2 = imread('data/Lamb-Oseen/Lamb-Oseen_illumination_img2.png');
groundtruthpath = 'data/Lamb-Oseen/Lamb-Oseen_groundtruth.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 0;
downsample = 22;
flow_scale = 2.5;
streamlines_factor = 4;
end

if strcmp(fluid_type,'Uniform')
fprintf(fluid_type);    
I1 = imread('data/Uniform/Uniform_illumination_img1.png');
I2 = imread('data/Uniform/Uniform_illumination_img2.png');
groundtruthpath = 'data/Uniform/Uniform_groundtruth.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 10;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 0; 
downsample = 20;
flow_scale = 0.8;
streamlines_factor = 4;
end

if strcmp(fluid_type,'Sink')
fprintf(fluid_type);    
I1 = imread('data/Sink/Sink_illumination_img1.png');
I2 = imread('data/Sink/Sink_illumination_img2.png');
groundtruthpath = 'data/Sink/Sink_groundtruth.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 0; 
downsample = 22;
flow_scale = 5;
streamlines_factor = 4;
end



if strcmp(fluid_type,'Vortex')
fprintf(fluid_type);    
I1 = imread('data/Vortex/Vortex_illumination_img1.png');
I2 = imread('data/Vortex/Vortex_illumination_img2.png');
groundtruthpath = 'data/Vortex/Vortex_groundtruth.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 0; 
downsample = 20; %the number of flow vectors plot flow vectors
flow_scale = 5.2;
streamlines_factor = 4;
end



if strcmp(fluid_type,'DNS turbulence')
fprintf(fluid_type);
I1 = imread('data/DNS_tubulence/run010050500_illumination.png');
I2 = imread('data/DNS_tubulence/run010050510_illumination.png');
groundtruthpath = 'data/DNS_tubulence/run010050500.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 0; 
downsample = 40;
flow_scale = 1.5;
streamlines_factor = 11;
end


if strcmp(fluid_type,'DNS-turbulence')
fprintf(fluid_type);
I1 = imread('data/DNS_turbulence_img1.tif');
I2 = imread('data/DNS_turbulence_img2.tif');
groundtruthpath = 'data/DNS_turbulence_gt.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 1; 
downsample = 40;
flow_scale = 1.5;
streamlines_factor = 11;
end

if strcmp(fluid_type,'SQG')
fprintf(fluid_type);
I1 = imread('data/SQG_00010_img1.tif');
I2 = imread('data/SQG_00010_img2.tif');
groundtruthpath = 'data/SQG_00010_flow.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 1; 
downsample = 40;
flow_scale = 1.5;
streamlines_factor = 11;
end

if strcmp(fluid_type,'JHTDB-iso')
fprintf(fluid_type);
I1 = imread('data/JHTDB_isotropic1024_hd_00010_img1.tif');
I2 = imread('data/JHTDB_isotropic1024_hd_00010_img2.tif');
groundtruthpath = 'data/JHTDB_isotropic1024_hd_00010_flow.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 1; 
downsample = 40;
flow_scale = 1.5;
streamlines_factor = 11;
end

if strcmp(fluid_type,'JHTDB-channel')
fprintf(fluid_type);
I1 = imread('data/JHTDB_channel_00010_img1.tif');
I2 = imread('data/JHTDB_channel_00010_img2.tif');
groundtruthpath = 'data/JHTDB_channel_00010_flow.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 1; 
downsample = 40;
flow_scale = 1.5;
streamlines_factor = 11;
end

if strcmp(fluid_type,'JHTDB-hd')
fprintf(fluid_type);
I1 = imread('data/JHTDB_channel_hd_00010_img1.tif');
I2 = imread('data/JHTDB_channel_hd_00010_img2.tif');
groundtruthpath = 'data/JHTDB_channel_hd_00010_flow.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 1; 
downsample = 40;
flow_scale = 1.5;
streamlines_factor = 11;
end

if strcmp(fluid_type,'JHTDB-mhd')
fprintf(fluid_type);
I1 = imread('data/JHTDB_mhd1024_hd_00010_img1.tif');
I2 = imread('data/JHTDB_mhd1024_hd_00010_img2.tif');
groundtruthpath = 'data/JHTDB_mhd1024_hd_00010_flow.flo';
groundtruth='true';
show_flow =0; 
st.sigma = 3;
st.sharpness = 0.05;
st.alpha = 0.01;
st.lambda = 0.02;
S = 1; 
downsample = 40;
flow_scale = 1.5;
streamlines_factor = 11;
end




if strcmp(fluid_type,'Typhoon')
I1 = imread('data/Typhoon_img1.png');
I2 = imread('data/Typhoon_img2.png');
groundtruth='false';
show_flow =0; 
st.sigma = 10;
st.sharpness = 0.1;
st.alpha = 0.5;
st.lambda = 0.02;
S = 0; 
downsample = 20;
flow_scale = 1.4;
streamlines_factor = 4;
end

if strcmp(fluid_type,'White Ovals')
I1 = imread('data/White_Ovals_img1.png');
I2 = imread('data/White_Ovals_img2.png');
groundtruth='false';
show_flow =0; 
st.sigma = 5;
st.sharpness = 0.05;
st.alpha = 0.5;
st.lambda = 0.02;
S = 0; 
downsample = 40;
flow_scale = 1.7;
streamlines_factor = 9;
end

 tic;
 flow = coarse_to_fine(I1, I2, st,S,show_flow, h);
 toc;
 u = flow(:, :, 1);
 v = flow(:, :, 2);

if strcmp(groundtruth,'true')
 realFlow = readFlowFile(groundtruthpath);
 tu = realFlow(:, :, 1);
 tv = realFlow(:, :, 2);

 UNKNOWN_FLOW_THRESH = 1e9;
 [mang, mepe] = flowError(tu, tv, u, v, 0, 0.0, UNKNOWN_FLOW_THRESH);
 disp(['Mean end-point error: ', num2str(mepe)]);
 disp(['Mean angular error: ', num2str(mang)]); 
end
 
 if (show_flow ==1)
     if strcmp(groundtruth,'true')
     gtflowImg = uint8(robust_flowToColor(realFlow));
     figure('Name', 'Ground-truth flow'); imshow(gtflowImg);
     end
     flowImg = uint8(robust_flowToColor(flow));
     figure('Name', 'Predicted flow field'); imshow(flowImg);
 else
     disp('Flow visualization ......');
     disp('This may take a few minutes to complete.');
     if strcmp(groundtruth,'true')
     plot_flow(fluid_type,'Ground-truth Flow',tu,tv,I1,downsample,flow_scale);
     %plot_streamlines(fluid_type,'Ground-truth Streamlines',tu,tv,I1,streamlines_factor);
     %plot_velocity(fluid_type,'Ground-truth Velocity',tu,tv,downsample,flow_scale,streamlines_factor);
     %plot_vorticity(fluid_type,'Ground-truth Vorticity',tu,tv,downsample,flow_scale,streamlines_factor);
     end    
     plot_image(fluid_type,I1,I2);
     plot_flow(fluid_type,'SCD-SE Flow',u,v,I1,downsample,flow_scale);
     %plot_streamlines(fluid_type,'SCD-SE Streamlines',u,v,I1,streamlines_factor);
     %plot_velocity(fluid_type,'SCD-SE Velocity',u,v,downsample,flow_scale,streamlines_factor);
     %plot_vorticity(fluid_type,'SCD-SE Vorticity',u,v,downsample,flow_scale,streamlines_factor); 
 end
 