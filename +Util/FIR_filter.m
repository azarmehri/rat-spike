function smoothdata = FIR_filter(data, srate, locutoff, hicutoff, filtorder)
%FIR_filter Apply FIR filter to data
%   smoothdata = FIR_filter(data, srate, locutoff, hicutoff, filtorder)
%
%   Inputs:
%       data - Input signal (1D array)
%       srate - Sampling rate (Hz)
%       locutoff - Low cutoff frequency (Hz), 0 for no high-pass
%       hicutoff - High cutoff frequency (Hz), 0 for no low-pass
%       filtorder - Filter order (optional, auto-calculated if empty/0)
%
%   Output:
%       smoothdata - Filtered signal

arguments
    data (1,:) double
    srate (1,1) double {mustBeNonnegative}
    locutoff (1,1) double {mustBeNonnegative}
    hicutoff (1,1) double {mustBeNonnegative}
    filtorder {mustBeNonnegative} = []
end

% Input validation and parameter setup
if srate == hicutoff
    hicutoff = 0;
end

nyq = srate * 0.5;  % Nyquist frequency
minfac = 3;         % this many (lo)cutoff-freq cycles in filter
min_filtorder = 15; % minimum filter length
trans = 0.15;       % fractional width of transition zones

% Validate cutoff frequencies
if locutoff > 0 && hicutoff > 0 && locutoff > hicutoff
    error('locutoff > hicutoff ???');
end
if locutoff < 0 || hicutoff < 0
    error('locutoff | hicutoff < 0 ???');
end
if locutoff > nyq
    error('Low cutoff frequency cannot be > srate/2');
end
if hicutoff > nyq
    error('High cutoff frequency cannot be > srate/2');
end

% Auto-calculate filter order if not provided
if isempty(filtorder) || filtorder == 0
    filtorder = calculate_order(srate, locutoff, hicutoff, minfac, min_filtorder);
end

% Check transition band
if (1 + trans) * hicutoff / nyq > 1
    error('High cutoff frequency too close to Nyquist frequency');
end

% Check data length constraint
if filtorder * 3 > length(data)
    error('Data length must be at least 3 times the filter order.');
end

% Design filter weights
filtwts = design_filter(srate, locutoff, hicutoff, filtorder);

% Apply filter
smoothdata = filtfilt(filtwts, 1, data);
end

% Design FIR filter weights
function filtwts = design_filter(srate, locutoff, hicutoff, filtorder)
% Validate at least one cutoff frequency is specified
if locutoff == 0 && hicutoff == 0
    error('You must provide a non-0 low or high cut-off frequency');
end

% Design filter based on type
if locutoff > 0 && hicutoff > 0
    % Bandpass filter
    filtwts = fir1(filtorder, [locutoff, hicutoff] / (srate / 2));
elseif locutoff > 0
    % Highpass filter
    filtwts = fir1(filtorder, locutoff / (srate / 2), 'high');
elseif hicutoff > 0
    % Lowpass filter
    filtwts = fir1(filtorder, hicutoff / (srate / 2));
end
end

% Calculate optimal filter order
function filtorder = calculate_order(srate, locutoff, hicutoff, minfac, min_filtorder)
if locutoff > 0
    filtorder = minfac * fix(srate / locutoff);
elseif hicutoff > 0
    filtorder = minfac * fix(srate / hicutoff);
else
    filtorder = min_filtorder;
end

if filtorder < min_filtorder
    filtorder = min_filtorder;
end
end
