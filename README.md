# SCD-SE-Flow
This repository contains a flow visualization tool for complex fluid flows, implemented for the following paper,

Flow Visualization for Complex Fluid Flows via a Structure-enhanced Motion Estimator

Jun Chen, He Wang, Zhifeng Hai, Zemin Cai, Ling Mei, and Tianshu Liu.

The paper is currently under review by the TCSVT journal.

# Dependencies
Our code has been tested with Matlab2021.

# Running the demo
Download and unzip the corresponding dataset. 

Test the proposed method in Matlab by running demo_fluid_optical_flow.m. 

You can also modify different parameters as shown in the following example.

    st.sigma = 3;
    st.sharpness = 0.05;
    st.alpha = 0.01; 
    st.lambda = 0.02;
    st.pyramid_factor = 0.5;    % warping settings
    st.warps = 5;     % the numbers of warps per level
    st.max_its = 2;   % the number of equation iterations per warp
    S=0; 


