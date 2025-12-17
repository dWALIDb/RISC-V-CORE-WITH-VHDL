import tensorflow as tf
import numpy as np

# Training data
x_train = np.array([0, 1, 2, 3, 4], dtype=np.float32)
y_train = np.array([1, 3, 5, 7, 9], dtype=np.float32)

# Create a simple linear model: y = Wx + b
model = tf.keras.Sequential([
    tf.keras.layers.Dense(1, input_shape=(1,))
])

model.compile(optimizer='sgd', loss='mse')
model.fit(x_train, y_train, epochs=100, verbose=0)

# Get weights and bias separately
weights, biases = model.layers[0].get_weights()
print("Weights:", weights)
print("Biases:", biases)


# Function for manual inference
def manual_predict(x, W, b):
    return np.dot(x, W) + b

x_test = np.array([[10.0]], dtype=np.float32)
y_pred = manual_predict(x_test, weights, biases)
print("Manual prediction for 10:", y_pred)


# Convert to C array format
weight_array = ", ".join(f"{w[0]:.6f}f" for w in weights)
bias_array = ", ".join(f"{b:.6f}f" for b in biases)

c_code = f"""
float weights[] = {{{weight_array}}};
float biases[] = {{{bias_array}}};
"""

with open("model_weights.cc", "w") as f:
    f.write(c_code)

print("C arrays saved in model_weights.cc")
