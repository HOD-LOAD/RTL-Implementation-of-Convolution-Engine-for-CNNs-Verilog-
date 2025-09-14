# RTL Implementation of Convolution Engine for CNNs (Verilog)

This project implements a **Convolution Engine** for Convolutional Neural Networks (CNNs) using Verilog HDL.  
It demonstrates the design, simulation, and testing of a 3×3 convolution module (with Sobel filter kernel) and integrates a line buffer for image data handling.

---

## 🚀 STAR Documentation

### ⭐ Situation
The project was undertaken to explore **hardware acceleration of CNNs** by building a Verilog-based RTL implementation of a convolution engine.  
The goal was to process image data with a sliding 3×3 window and perform convolution using kernels such as the **Sobel edge detection filter**.

### ⭐ Task
- Design a convolution core (`conv_core.v`) that performs signed multiply-accumulate operations on 3×3 windows and kernels.  
- Implement a line buffer (`line_buffer.v`) to generate sliding windows from streaming pixel data.  
- Integrate modules (`conv_top.v`) and verify outputs against expected results.  
- Create a testbench (`tb_conv_top.v`) to feed pixel data, apply Sobel kernel, and log convolution outputs.  
- Compare results with Python/Numpy implementations (`verify_conv.py`, `verify_sobel.py`, `compare_verilog_numpy.py`).

### ⭐ Action
- Wrote RTL modules in Verilog for convolution core, line buffer, and top integration.  
- Created testbenches to simulate convolution with an 8×8 input image (values 0–63).  
- Implemented Sobel kernel loading in Verilog testbench.  
- Debugged issues with **signed multiplication**, **kernel flattening**, and **window buffering**.  
- Verified outputs by writing results into `verilog_out.txt` and cross-checking with Python reference models.  

### ⭐ Result
- Successfully implemented a **working convolution engine** in Verilog.  
- Produced consistent convolution outputs (e.g., constant `16` for Sobel filter test).  
- Integrated **Python verification scripts** to confirm correctness.  
- Gained hands-on experience with **hardware design for CNN accelerators**, debugging simulation issues, and GitHub project management.  

---

## ⚡ Key Learnings & Difficulties Faced
- Handling **signed arithmetic** in Verilog was tricky (negative kernel values like `-1`, `-2` initially gave wrong results).  
- Flattening the kernel into a 72-bit input bus required debugging.  
- Line buffer integration and window generation caused **X values and padding issues**.  
- Output verification showed constant values (`-16` / `16`) — understanding that this was due to kernel symmetry took time.  
- GitHub setup had issues with `.git` conflicts and submodule errors, later fixed by reinitializing and pushing properly.  

---

## 📂 Project Structure

