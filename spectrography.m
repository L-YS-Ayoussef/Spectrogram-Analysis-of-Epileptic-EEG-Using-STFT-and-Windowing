% Load the preprocessed averaged data
ictal_averaged_data = load('ictal_averaged.mat').ictal_averaged;
seizure_free_averaged_data = load('seizure_free_averaged.mat').seizure_free_averaged;

% Define parameters
Fs = 256; % Sampling rate in Hz
n_seconds = input('Enter the time resolution in seconds (e.g., 2): ');
n_freqs = input('Enter the frequency resolution in samples (e.g., 128): ');

% Calculate the number of samples per time window
window_size = n_seconds * Fs;

% Define overlap (optional, set to 50% overlap)
overlap = round(0.5 * window_size);

% Create Hamming window
window = hamming(window_size);



% Compute spectrograms for ictal and seizure-free data
ictal_spectrogram = compute_spectrogram(ictal_averaged_data, window, overlap, n_freqs, window_size, Fs);
seizure_free_spectrogram = compute_spectrogram(seizure_free_averaged_data, window, overlap, n_freqs, window_size, Fs);

% Time and frequency axes
time_axis = (0:(size(ictal_spectrogram, 2) - 1)) * (window_size - overlap) / Fs;
freq_axis = (0:(n_freqs / 2)) * Fs / n_freqs;

% Plot spectrograms
figure;
subplot(2, 1, 1);
imagesc(time_axis, freq_axis, ictal_spectrogram);
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram of Ictal Data');
colorbar;

subplot(2, 1, 2);
imagesc(time_axis, freq_axis, seizure_free_spectrogram);
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram of Seizure-Free Data');
colorbar;


