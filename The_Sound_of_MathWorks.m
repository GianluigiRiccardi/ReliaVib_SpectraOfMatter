%% ReliaVib – The Sound of MathWorks (v2)
% Author: Gianluigi Riccardi
% Project: ReliaVib – Spectra of Matter
% Description: Experimental vibration analysis while engraving "MathWorks"
%              using MATLAB Mobile and HBC Signograph 25.
% Date: 2025-10-27

clear; clc; close all;

%% PARAMETERS
activity   = 'Engraving "MathWorks"';
duration_s = 15;
f_view_max = 500;

%% CONNECT TO MOBILE DEVICE
if ~exist('m','var')
    m = mobiledev;
end
m.AccelerationSensorEnabled = 1;
assert(m.AccelerationSensorEnabled == 1, ...
    'Enable the accelerometer in MATLAB Mobile before running.');

disp('Hold the smartphone firmly while engraving "MathWorks".');
input('Press ENTER to start acquisition...','s');

m.Logging = 1; pause(duration_s); m.Logging = 0;
[data, t] = accellog(m);
assert(~isempty(data), 'No data captured. Check connection.');

ax = data(:,1); ay = data(:,2); az = data(:,3);
vib = detrend(sqrt(ax.^2 + ay.^2 + az.^2), 'linear');

Fs = round((numel(t)-1)/(t(end)-t(1)));
t  = (0:numel(vib)-1)'/Fs;

%% SAMPLING RATE CHECK
if Fs < 50
    warning('Low Fs (%.1f Hz). Keep MATLAB Mobile active in foreground.', Fs);
elseif Fs < 100
    disp(['Sampling rate: ' num2str(Fs) ' Hz – adequate.']);
else
    disp(['Sampling rate: ' num2str(Fs) ' Hz – optimal.']);
end

%% FILTERING
f_high = min(0.45*Fs, 800);
try
    vib_f = bandpass(vib, [5 f_high], Fs, ...
        'Steepness', 0.95, 'StopbandAttenuation', 80);
catch
    vib_f = vib;
end

%% METRICS
a_rms = rms(vib_f);
A8 = a_rms * sqrt(duration_s / (8*3600));

low_thr=0.2; med_thr=0.8; high_thr=2.0;
if a_rms < low_thr, s='LOW'; c='r';
elseif a_rms < med_thr, s='MEDIUM'; c=[0.929 0.694 0.125];
else, s='HIGH'; c='g'; end

%% WELCH + FFT
[Pw,f]=pwelch(vib_f,hann(1024,"periodic"),512,[],Fs,"onesided");
Pw_dB = 10*log10(Pw+eps);
mask = f<=f_view_max;

[pks,locs]=findpeaks(Pw_dB(mask),f(mask),'MinPeakProminence',6);
if isempty(pks), f_peak=NaN;
else, f_peak=locs(pks==max(pks)); end

%% VISUALIZATION
figure('Color','w');
subplot(3,1,1);
plot(t,vib_f,'b'); xlabel('Time (s)'); ylabel('Accel. (m/s²)');
title([activity ' – Time Signal']); grid on;

subplot(3,1,2);
plot(f(mask),Pw_dB(mask),'r'); hold on;
if ~isempty(pks)
    stem(locs,pks,'k'); 
    text(locs,pks+1,compose('%.0f Hz',locs),'FontSize',6,...
        'HorizontalAlignment','center');
end
xlabel('Frequency (Hz)'); ylabel('Power (dB)'); grid on;
xlim([0 f_view_max]);
title('Power Spectrum');

subplot(3,1,3);
bar(1,a_rms,'FaceColor',c); 
text(1,a_rms+0.05,sprintf('Signal %s (%.3f m/s²)',s,a_rms),...
    'HorizontalAlignment','center','FontWeight','bold');
xlim([0.5 1.5]); ylim([0 max(2.5,a_rms+0.5)]); grid on;
title('Signal Quality Indicator');

sgtitle('ReliaVib – The Sound of MathWorks');

%% SAVE RESULTS
fileID=['ReliaVib_MathWorks_' datestr(now,'yyyymmdd_HHMMSS')];
save([fileID '.mat'],'activity','Fs','vib_f','Pw','f','a_rms','A8','f_peak');
fprintf('\nSaved: %s.mat | a_RMS=%.3f m/s² | Peak=%.1f Hz | Signal=%s\n',...
    fileID,a_rms,f_peak,s);
