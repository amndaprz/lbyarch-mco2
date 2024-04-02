# lbyarch-mco2

//PUT RESULT ANALYSIS HERE


// C++ PROGRAM RUNTIME:

LENGTH OF ARRAY |  RUNTIME (SECONDS)
2 ^ 20          | 0.0189
2 ^ 24          |0.02485
2 ^ 30          |21.9918


// x86-64 PROGRAM RUNTIME:

LENGTH OF ARRAY |  RUNTIME (SECONDS)
2 ^ 20          |   0.051 s (Successful)
2 ^ 24          |   0.307 s (Successful)
2 ^ 27          |   2.09  s (Successful)
2 ^ 28          |   Program crashed at 10.076 s
2 ^ 29          |   Program crashed at 8.053 s
2 ^ 30          |   Program crashed at 8.745 s

ASM SANITY CHECK:
![Sanity Check}](ASM_SANITYCHECK.png)
The picture above shows a sanity check for when the array length is = 10. As seen in the GDB console, the vector Array Y contains the floating point values: 28, 35, 42, and  49. These are correct if we follow the given process specifications which is:
Y[i] = X [i - 3] + X [i - 2] + X [i - 1] + X [ i ] + X [ i + 1 ] + X [i + 2] + X [ i +3 ]


C results screenshot

c_version.png
