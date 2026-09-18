# FPGA-Based Digital Frequency Meter

A digital frequency meter implemented on an FPGA using **VHDL**. The project was designed and tested on an **Altera Cyclone IV** FPGA using **Quartus II 15.0**.

The frequency meter measures periodic digital input signals over a range of approximately **10 Hz to 25 MHz**. To cover this wide range, the design automatically selects between three measurement ranges:

- **10 Hz – 1 kHz**
- **1 kHz – 1 MHz**
- **1 MHz – 25 MHz**

The system is divided into three main modules: **range selection (`choose`)**, **frequency measurement (`counter`)**, and **display control (`show`)**. The measured frequency is displayed on a four-digit seven-segment display, with LEDs indicating the selected measurement range.

## How to Use

1. Clone or download this repository.
2. Open **`f_m.qpf`** in **Quartus II**.
3. Compile the VHDL project.
4. Assign the FPGA pins as required for your development board.
5. Program the FPGA and connect the digital signal to the frequency-measurement input.
6. Read the measured frequency from the seven-segment display and the active range from the LED indicators.

## Development Environment

- **HDL:** VHDL
- **FPGA:** Altera Cyclone IV
- **Software:** Quartus II 15.0

## Project Files and Rebuilding

The extracted `.qpf`/`.qsf` files and MegaWizard IP record **Quartus II 13.1** as their original version. Quartus II 15.0 is the intended environment above; a fresh compilation with that version has not been verified as part of this repository cleanup.

- Open the root `f_m.qpf` for the complete design. Its top level is `f_m.bdf`, targeting **EP4CE6E22C8 (Cyclone IV E)**, with the original pin assignments in `f_m.qsf`.
- `choose/`, `counter/`, and `show/` contain the VHDL modules, schematic symbols, and their original standalone Quartus projects. The standalone `choose` and `show` projects target MAX II devices; use the root project for the complete Cyclone IV design.
- `clock_hh.*` and `div.*` contain the ALTPLL and LPM_DIVIDE IP wrappers and support files referenced by their `.qip` files. Keep these files together; their VHDL includes the MegaWizard settings.
- `choose/Waveform.vwf` is the original simulation stimulus. The standalone `choose` simulation output path is relative to its project directory.
- `f_m.cdf` and `choose/choose.cdf` preserve the programmer chain settings originally stored in build folders. Open each from its corresponding project directory after compilation; they reference `.pof` files in `output_files/`. The root chain selects EPCS4 Active Serial programming, while the `choose` chain selects MAX II JTAG programming.

With Quartus and the relevant device support installed, compile from the repository root using the GUI or `quartus_sh --flow compile f_m`. Review the existing pin assignments for your board before programming. No `.sdc` timing constraints were present in the extracted project.

Compilation databases, reports, generated simulation outputs, programming binaries, and editor backups are ignored by Git and regenerated as needed. The extracted sources replace the ZIP in the current tree; the original ZIP remains available in Git history.
