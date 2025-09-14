import numpy as np
numpy_out = np.array([-8]*36)
with open("verilog_out.txt", "r") as f:
    verilog_out = np.array([int(line.strip()) for line in f.readlines() if line.strip().isdigit() or (line.strip()[0]=='-' and line.strip()[1:].isdigit())])

if np.array_equal(verilog_out, numpy_out):
    print("Success! Verilog matches NumPy output.")
else:
    print("Mismatch detected!")
    for i, (v,n) in enumerate(zip(verilog_out, numpy_out)):
        if v != n:
            print(f"Index{i}: Verilog={v}, NumPy={n}")