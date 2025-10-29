![MATLAB](https://img.shields.io/badge/MATLAB-Mobile%20&%20Desktop-blue?logo=mathworks)
![Status](https://img.shields.io/badge/Status-Active-success)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20MATLAB%20Online-lightgrey)
![Data](https://img.shields.io/badge/Data-Vibration%20Spectrum-orange)
![License](https://img.shields.io/badge/License-Open-lightgreen)
![ReliaVib](https://img.shields.io/badge/ReliaVib-Predictive%20Maintenance-blue)
![ReliaVib](https://img.shields.io/badge/ReliaVib-Smart%20Vibration%20Lab-darkorange)

# 🧠 The Sound of MathWorks  
### *ReliaVib Experimental Series – Spectra of Matter*  

**Author:** Gianluigi Riccardi  
**Date:** October 27, 2025  
**Tool:** MATLAB Mobile  
**Device:** iPhone accelerometer (100 Hz sampling rate)  
**Engraver:** HBC Signograph 25 (nominal frequency ≈ 60 Hz / 3600 rpm)  

---

## 🔹 Project Overview  
*The Sound of MathWorks* is an experimental vibration analysis exploring the intersection between **engineering, physics, and art**.  
Using MATLAB Mobile as a portable acquisition system, the experiment captures the vibration signature produced while engraving the word **“MathWorks”** on a glass plate.  

Each letter generates its own micro-vibrational pattern — a mechanical voice shaped by the gesture itself.  
The result is a **real vibration spectrum**: the physical echo of a name that represents engineering and science itself.  

---

## 🔹 Setup (critical)
- In **MATLAB Mobile → Settings → Sensors**, set **Motion sensor sample rate = 100 Hz**.  
- Keep the app **in foreground** during acquisition and **disable battery saver** to avoid downsampling.  

---

## 🔹 Methodology
1. **Data acquisition**  
   - The smartphone’s accelerometer measures vibration during engraving.  
   - **Sampling rate: 100 Hz**  |  Duration: 15 s.  
   - Data recorded using `accellog(m)` in MATLAB Mobile.  

2. **Signal processing**  
   - RMS acceleration and FFT derived from raw acceleration data.  
   - Power spectral density computed with `pwelch()`.  
   - Dominant frequencies identified using `findpeaks()`.  

3. **Visualization**  
   - Time-domain and frequency-domain plots generated in MATLAB.  
   - Exported at 300 DPI for publication and analysis.  

---

## 🔹 Repository Structure
| File | Description |
|------|--------------|
| `The_Sound_of_MathWorks.m` | MATLAB script for data acquisition and FFT analysis |
| `ReliaVib_MathWorks_*.mat` | Raw vibration data (optional) |
| `results/` | Exported figures (time & frequency domain) |
| `images/` | Artistic photos of the engraved plate |

---

## 🔹 How to Run
1. Open **MATLAB Mobile** on your smartphone.  
2. **Set Motion sensor sample rate to 100 Hz** (Settings → Sensors).  
3. Enable the **Accelerometer** sensor.  
4. Run the script from MATLAB Desktop or MATLAB Online.  
5. Hold the phone near the engraver handle and press **ENTER** to start.  
6. Review the plots generated automatically at the end of acquisition.  

*(Tip: the script warns if Fs < 50 Hz.)*

---

## 🔹 Concept
> *Every vibration is a signature —  
>  every signal is matter speaking back.*  

This project belongs to the **ReliaVib – Spectra of Matter** experimental line, combining predictive-maintenance analytics with human creativity and digital physics.  

---

## 🔹 References
- [MathWorks – MATLAB Mobile](https://matlab.mathworks.com/mobile)  
- [MathWorks – Signal Processing Toolbox](https://www.mathworks.com/products/signal.html)  
- [HBC – Signograph 25 Engraver](https://www.hbc-signograph.com)  

---

💡 *Developed within the ReliaVib initiative: exploring vibration as both data and expression.*