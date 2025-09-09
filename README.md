# cymatrix

An illustrative matrix library implemented in Cython, providing 2D and 3D matrix classes with C-level performance and seamless NumPy integration.

## Features

- **High Performance**: Implemented in Cython with C-level memory management for speed

- **Memory Efficient**: Contiguous memory layout with row-major ordering for optimal cache performance

- **NumPy Compatible**: Full buffer protocol support for seamless integration with NumPy arrays

- **2D and 3D Matrices**: Support for both 2D and 3D matrix operations

- **Rich Operator Support**: Complete set of mathematical operators and comparisons

- **Element-wise Operations**: Flexible `apply()` and `apply_inplace()` methods for custom operations

## Installation

### Prerequisites

- [Python](https://python.org) 3.6+
- [uv](https://github.com/astral-sh/uv)
- [Cython](https://cython.org)
- [NumPy](https://numpy.org) (optional)
- A C compiler (GCC, Clang, or MSVC)

### Build from Source

```bash
# Clone the repository
git clone https://github.com/shakfu/cymatrix
cd cymatrix

# Build the extension
make build

# Build wheel
make wheel

# Clean build artifacts
make clean

# Clean build artifacts + venv
make reset
```

Run the test suite:

```bash
make test
```

## Quick Start

### 2D Matrices

```python
from cymatrix import Matrix2D, Matrix3D
import numpy as np

# Create a 3x3 matrix
m = Matrix2D(3, 3)

# Set values using indexing
m[0, 0] = 1.0
m[1, 1] = 2.0
m[2, 2] = 3.0

# Or using the set method
m.set(0, 1, 1.5)

# Access values
print(m[1, 1])  # 2.0
print(m.get(0, 1))  # 1.5

# Convert to NumPy array
arr = np.array(m)
print(arr)
# [[1.0  1.5  0.0 ]
#  [0.0  2.0  0.0 ]
#  [0.0  0.0  3.0 ]]
```

### 3D Matrices

```python
# Create a 2x3x4 3D matrix
m3d = Matrix3D(2, 3, 4)

# Set values using 3D indexing
m3d[0, 0, 0] = 1.0
m3d[1, 2, 3] = 2.5

# Access values
print(m3d[1, 2, 3])  # 2.5

# Convert to NumPy array
arr3d = np.array(m3d)
print(arr3d.shape)  # (2, 3, 4)
```

## Matrix Operations

### Arithmetic Operations

```python
# Create matrices
a = Matrix2D(2, 2)
b = Matrix2D(2, 2)

# Fill with values
a[0, 0] = 1.0; a[0, 1] = 2.0
a[1, 0] = 3.0; a[1, 1] = 4.0

b[0, 0] = 2.0; b[0, 1] = 3.0
b[1, 0] = 4.0; b[1, 1] = 5.0

# Addition
c = a + b
print(c)
# [[3.00, 5.00],
#  [7.00, 9.00]]

# Subtraction
d = a - b
print(d)
# [[-1.00, -1.00],
#  [-1.00, -1.00]]

# Scalar multiplication
e = a * 2.0
print(e)
# [[2.00, 4.00],
#  [6.00, 8.00]]

# Right multiplication
f = 3.0 * a
print(f)
# [[3.00, 6.00],
#  [9.00, 12.00]]

# Division
g = a / 2.0
print(g)
# [[0.50, 1.00],
#  [1.50, 2.00]]

# Matrix multiplication
h = a @ b
print(h)
# [[10.00, 13.00],
#  [22.00, 29.00]]
```

### Comparison Operations

```python
# Create matrices for comparison
a = Matrix2D(2, 2)
b = Matrix2D(2, 2)

a[0, 0] = 1.0; a[0, 1] = 2.0
a[1, 0] = 3.0; a[1, 1] = 4.0

b[0, 0] = 2.0; b[0, 1] = 3.0
b[1, 0] = 4.0; b[1, 1] = 5.0

# Equality
print(a == b)  # False
print(a == a)  # True

# Comparison (element-wise)
print(a < b)   # True (all elements of a < b)
print(a <= b)  # True
print(a > b)   # False
print(a >= b)  # False
```

### Element-wise Operations

```python
# Create matrix
m = Matrix2D(2, 2)
m[0, 0] = 1.0; m[0, 1] = 2.0
m[1, 0] = 3.0; m[1, 1] = 4.0

# Apply function element-wise
squared = m.apply(lambda val, other, i, j: val ** 2)
print(squared)
# [[1.00, 4.00],
#  [9.00, 16.00]]

# Apply with another matrix
other = Matrix2D(2, 2)
other[0, 0] = 2.0; other[0, 1] = 3.0
other[1, 0] = 4.0; other[1, 1] = 5.0

multiplied = m.apply(lambda val, other_val, i, j: val * other_val, other)
print(multiplied)
# [[2.00, 6.00],
#  [12.00, 20.00]]

# In-place operations
m.apply_inplace(lambda val, other, i, j: val * 2.0)
print(m)
# [[2.00, 4.00],
#  [6.00, 8.00]]
```

## Advanced Features

### Memory Views

```python
# Create matrix
m = Matrix2D(3, 3)
m[0, 0] = 1.0; m[1, 1] = 2.0; m[2, 2] = 3.0

# Create memory view
mv = memoryview(m)
print(mv.shape)  # (3, 3)
print(mv[1, 1])  # 2.0

# Memory view is writable
mv[0, 1] = 1.5
print(m[0, 1])  # 1.5
```

### Matrix Properties

```python
m = Matrix2D(4, 5)
print(m.rows)  # 4
print(m.cols)  # 5
print(len(m))  # 20 (total elements)

m3d = Matrix3D(2, 3, 4)
print(m3d.rows)    # 2
print(m3d.cols)    # 3
print(m3d.planes)  # 4
print(len(m3d))    # 24 (total elements)
```

### String Representation

```python
m = Matrix2D(2, 2)
m[0, 0] = 1.0; m[0, 1] = 2.0
m[1, 0] = 3.0; m[1, 1] = 4.0

print(str(m))
# [
#  [1.00, 2.00],
#  [3.00, 4.00]
# ]

print(repr(m))
# Matrix2D(2x2, [[1.0, 2.0], [3.0, 4.0]])
```

## Performance Characteristics

- **Memory Layout**: Row-major contiguous memory for optimal cache performance
- **C-level Operations**: All core operations implemented in C for speed
- **Zero-copy NumPy Integration**: Direct memory sharing with NumPy arrays
- **Efficient Indexing**: O(1) element access with optimized offset calculations??

## API Reference

### Matrix2D Class

#### Constructor

- `Matrix2D(rows, cols)` - Create a new 2D matrix

#### Properties

- `rows` - Number of rows
- `cols` - Number of columns

#### Methods

- `get(i, j)` - Get element at position (i, j)
- `set(i, j, value)` - Set element at position (i, j)
- `apply(func, other=None)` - Apply function element-wise
- `apply_inplace(func, other=None)` - Apply function element-wise in place

#### Operators

- `+`, `-` - Matrix addition/subtraction
- `*` - Scalar multiplication
- `@` - Matrix multiplication
- `/` - Scalar division
- `==`, `!=`, `<`, `<=`, `>`, `>=` - Comparison operators
- `abs()` - Element-wise absolute value

### Matrix3D Class

#### Constructor

- `Matrix3D(rows, cols, planes)` - Create a new 3D matrix

#### Properties

- `rows` - Number of rows
- `cols` - Number of columns
- `planes` - Number of planes

#### Methods

- `get(i, j, k)` - Get element at position (i, j, k)
- `set(i, j, k, value)` - Set element at position (i, j, k)
- `apply(func, other=None)` - Apply function element-wise
- `apply_inplace(func, other=None)` - Apply function element-wise in place

#### Operators

- Same as Matrix2D, but for 3D operations

## Requirements

- Python 3.6+
- Cython
- NumPy
- C compiler (GCC, Clang, or MSVC)

## License

See LICENSE file for details.
