import numpy as np
from scipy.signal import convolve2d

# 8x8 test image
image = np.arange(64).reshape(8, 8)

# Sobel kernel (horizontal edges)
sobel_x = np.array([
    [-1, 0, 1],
    [-2, 0, 2],
    [-1, 0, 1]
])

# Convolution
out = convolve2d(image, sobel_x, mode='valid')

print("Input Image:\n", image)
print("\nSobel Kernel:\n", sobel_x)
print("\nConvolution Output:\n", out)

# Flatten row-wise (to compare with Verilog streaming output)
print("\nFlattened Outputs (row-wise):", out.flatten())
