import numpy as np

def rand(n, min, max):
    n_rand = np.random.choice(np.arange(min, max, 0.001), n)
    if n == 1:
        return n_rand[0]
    return n_rand