% Load the preprocessed averaged data
ictal_averaged_data = load('ictal_averaged.mat').ictal_averaged;
seizure_free_averaged_data = load('seizure_free_averaged.mat').seizure_free_averaged;

% Sampling rate
Fs = 256; % Hz

%% Part 1: Investigate Overlapping Ratios
overlap_ratios = [0, 0.25, 0.5, 0.75]; % Test these ratios
n_seconds = 2; % Fixed time resolution (can be modified)
window_size = n_seconds * Fs; % Window size in samples
n_freqs = 128; % FFT size

% Loop over overlap ratios
for ratio = overlap_ratios
    overlap = round(ratio * window_size); % Compute overlap in samples
    window = hamming(window_size); % Hamming window

    % Compute spectrograms
    ictal_spectrogram = compute_spectrogram(ictal_averaged_data, window, overlap, n_freqs, window_size, Fs);
    seizure_free_spectrogram = compute_spectrogram(seizure_free_averaged_data, window, overlap, n_freqs, window_size, Fs);

    % Time and frequency axes
    time_axis = (0:(size(ictal_spectrogram, 2) - 1)) * (window_size - overlap) / Fs;
    freq_axis = (0:(n_freqs / 2)) * Fs / n_freqs;

    % Plot results
    figure('Name', sprintf('Overlap Ratio: %.2f', ratio));
    subplot(2, 1, 1);
    imagesc(time_axis, freq_axis, ictal_spectrogram);
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(sprintf('Ictal Spectrogram (Overlap Ratio %.2f)', ratio));
    colorbar;

    subplot(2, 1, 2);
    imagesc(time_axis, freq_axis, seizure_free_spectrogram);
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(sprintf('Seizure-Free Spectrogram (Overlap Ratio %.2f)', ratio));
    colorbar;
end

%% Part 2: Investigate Window Sizes
window_sizes = [1, 2, 4]; % Test window sizes in seconds

% Loop over window sizes
for win_sec = window_sizes
    window_size = win_sec * Fs; % Convert to samples
    overlap = round(0.5 * window_size); % Fixed 50% overlap
    window = hamming(window_size); % Hamming window

    % Compute spectrograms
    ictal_spectrogram = compute_spectrogram(ictal_averaged_data, window, overlap, n_freqs, window_size, Fs);
    seizure_free_spectrogram = compute_spectrogram(seizure_free_averaged_data, window, overlap, n_freqs, window_size, Fs);

    % Time and frequency axes
    time_axis = (0:(size(ictal_spectrogram, 2) - 1)) * (window_size - overlap) / Fs;
    freq_axis = (0:(n_freqs / 2)) * Fs / n_freqs;

    % Plot results
    figure('Name', sprintf('Window Size: %d seconds', win_sec));
    subplot(2, 1, 1);
    imagesc(time_axis, freq_axis, ictal_spectrogram);
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(sprintf('Ictal Spectrogram (Window Size: %d sec)', win_sec));
    colorbar;

    subplot(2, 1, 2);
    imagesc(time_axis, freq_axis, seizure_free_spectrogram);
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(sprintf('Seizure-Free Spectrogram (Window Size: %d sec)', win_sec));
    colorbar;
end
