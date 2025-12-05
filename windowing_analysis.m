% Load the preprocessed averaged data
ictal_averaged_data = load('ictal_averaged.mat').ictal_averaged;
seizure_free_averaged_data = load('seizure_free_averaged.mat').seizure_free_averaged;

% Define parameters
Fs = 256; % Sampling rate in Hz
n_seconds = 2; % Window size in seconds
window_size = n_seconds * Fs; % Convert to samples
overlap = round(0.5 * window_size); % 50% overlap
n_freqs = 128; % FFT size

% Define window types
windows = {
    'Rectangular', ones(window_size, 1);
    'Triangular', triang(window_size);
    'Hamming', hamming(window_size);
    'Blackman', blackman(window_size)
};

% Loop over each window type
for w = 1:size(windows, 1)
    window_name = windows{w, 1}; % Window name
    window = windows{w, 2}; % Window function
    
    % Compute spectrograms
    ictal_spectrogram = compute_spectrogram(ictal_averaged_data, window, overlap, n_freqs, window_size, Fs);
    seizure_free_spectrogram = compute_spectrogram(seizure_free_averaged_data, window, overlap, n_freqs, window_size, Fs);

    % Time and frequency axes
    time_axis = (0:(size(ictal_spectrogram, 2) - 1)) * (window_size - overlap) / Fs;
    freq_axis = (0:(n_freqs / 2)) * Fs / n_freqs;

    % Plot spectrograms
    figure('Name', sprintf('%s Window', window_name));
    subplot(2, 1, 1);
    imagesc(time_axis, freq_axis, ictal_spectrogram);
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(sprintf('Ictal Spectrogram (%s Window)', window_name));
    colorbar;

    subplot(2, 1, 2);
    imagesc(time_axis, freq_axis, seizure_free_spectrogram);
    axis xy;
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    title(sprintf('Seizure-Free Spectrogram (%s Window)', window_name));
    colorbar;
end
