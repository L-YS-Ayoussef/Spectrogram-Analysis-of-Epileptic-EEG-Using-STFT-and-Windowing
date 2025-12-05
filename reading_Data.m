% Load the .mat files
ictal_data_raw = load('chb12_29_data.mat'); % Data with seizures
interictal_data_raw = load('chb12_32_data.mat'); % Data without seizures

% Access the 'data' variable from the loaded structures
ictal_data = ictal_data_raw.data;
seizure_free_data = interictal_data_raw.data; % Directly use seizure-free data

% Define sampling rate
sampling_rate = 256; % Hz (as specified in the assignment)

% Seizure times from chb12-summary.txt (in seconds)
seizure_times = [
    107, 146;
    554, 592;
    1163, 1199;
    1401, 1447;
    1884, 1921;
    3557, 3584
];

% Extract ictal (seizure) states
ictal_segments = {};
for i = 1:size(seizure_times, 1)
    start_idx = seizure_times(i, 1) * sampling_rate + 1; % Convert time to sample index
    end_idx = seizure_times(i, 2) * sampling_rate;
    ictal_segments{i} = ictal_data(start_idx:end_idx, :); % Extract seizure segment
end

% Combine all ictal segments into one matrix
ictal_combined = cell2mat(ictal_segments'); % Concatenate along the time dimension

% Save processed data
save('ictal_data.mat', 'ictal_combined'); % Save seizures-only data
save('seizure_free_data.mat', 'seizure_free_data'); % Directly save seizure-free data from chb12_32

disp('Seizure-only and seizure-free records have been saved.');
