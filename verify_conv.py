import numpy as np
from scipy.signal import convolve2d

# 4x4 test image (same as in tb_conv_top)
image = np.arange(16).reshape(4, 4)

# 3x3 kernel (all ones)
kernel = np.ones((3, 3), dtype=int)

# Perform convolution (valid mode = no padding)
out = convolve2d(image, kernel, mode='valid')

print("Input Image:\n", image)
print("\nKernel:\n", kernel)
print("\nConvolution Output:\n", out)

# Flatten results row-wise to match Verilog stream
print("\nFlattened Outputs (row-wise):", out.flatten())
