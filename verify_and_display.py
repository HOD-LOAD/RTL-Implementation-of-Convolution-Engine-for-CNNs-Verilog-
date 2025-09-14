import numpy as np

# Reference NumPy Sobel X output for the 8x8 test image 0..63
numpy_out = np.full((6*6,), -8, dtype=int)

verilog_out = []
try:
    with open("verilog_out.txt","r") as f:
        for line in f:
            line = line.strip()
            if line and line.lower() != 'x':
                verilog_out.append(int(line))
except FileNotFoundError:
    print("Error: verilog_out.txt not found. Run your Verilog simulation first.")
    exit(1)
except ValueError as e:
    print("Error: Found non-integer value in verilog_out.txt:", e)
    exit(1)

verilog_out = np.array(verilog_out)

if np.array_equal(verilog_out, numpy_out):
    print("✅ Success! Verilog matches NumPy output.")
else:
    print("❌ Mismatch detected!")
    for i, (v, n) in enumerate(zip(verilog_out, numpy_out)):
        if v != n:
            print(f"Index {i}: Verilog={v}, NumPy={n}")

if len(verilog_out) >= 36:
    grid = verilog_out[:36].reshape(6,6)
    print("\n6x6 Convolution Output Grid (Verilog):")
    print(grid)
else:
    print("Not enough valid outputs to form 6x6 grid.")
