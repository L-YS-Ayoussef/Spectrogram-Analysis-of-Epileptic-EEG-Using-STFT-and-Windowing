% Function to compute spectrogram
function spectrogram = compute_spectrogram(signal, window, overlap, n_freqs, window_size, Fs)
    step = window_size - overlap; % Step size for the sliding window
    n_windows = floor((length(signal) - overlap) / step); % Number of windows
    spectrogram = zeros(n_freqs / 2 + 1, n_windows);

    for i = 1:n_windows
        % Define segment start and end
        start_idx = (i - 1) * step + 1;
        end_idx = start_idx + window_size - 1;

        % Apply window and compute FFT
        segment = signal(start_idx:end_idx) .* window;
        fft_result = abs(fft(segment, n_freqs)); % Compute FFT with zero-padding
        spectrogram(:, i) = fft_result(1:n_freqs / 2 + 1); % Take positive frequencies
    end

    % Convert to dB scale
    spectrogram = 20 * log10(spectrogram + eps);
end