% Load processed data
ictal_data = load('ictal_data.mat');
seizure_free_data = load('seizure_free_data.mat');

ictal_data = ictal_data.ictal_combined; % Access the ictal data matrix
seizure_free_data = seizure_free_data.seizure_free_data; % Access the seizure-free data matrix

% Define the available channels
num_channels = size(ictal_data, 2); % Total number of channels (29)
channel_labels = strcat("Channel ", string(1:num_channels)); % Create labels for channels

% User selection of channels
selected_channels = listdlg('PromptString', 'Select channels to average:', ...
                             'SelectionMode', 'multiple', ...
                             'ListString', channel_labels);

if isempty(selected_channels)
    error('No channels were selected. Please run the script again and select at least one channel.');
end

% Average across selected channels
ictal_averaged = mean(ictal_data(:, selected_channels), 2); % Average along the channel dimension
seizure_free_averaged = mean(seizure_free_data(:, selected_channels), 2);

% Save the averaged data
save('ictal_averaged.mat', 'ictal_averaged');
save('seizure_free_averaged.mat', 'seizure_free_averaged');

disp('Averaged ictal and seizure-free data have been saved.');
