import numpy as np
import matplotlib.pyplot as plt
from sklearn.neural_network import MLPRegressor
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import mean_absolute_error, mean_squared_error
# -----------------------------
# 1. Generate training data
# -----------------------------
X = np.linspace(-2 * np.pi, 2 * np.pi, 10000).reshape(-1, 1)
y = np.cos(X).ravel()

# -----------------------------
# 2. Scale input (important for NN stability)
# -----------------------------
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# -----------------------------
# 3. Create and train neural network
# -----------------------------
model = MLPRegressor(
    hidden_layer_sizes=(4,8,8,4),
    activation='tanh',
    solver='adam',
    max_iter=5000,
    random_state=42
)

model.fit(X_scaled, y)

# -----------------------------
# 4. Make predictions
# -----------------------------
X_test = np.linspace(-2 * np.pi, 2 * np.pi, 300).reshape(-1, 1)
X_test_scaled = scaler.transform(X_test)

y_pred = model.predict(X_test_scaled)
y_true = np.cos(X_test).ravel()


error=[]
for i in range(0, len(X_test)):
    error.append( np.abs(np.subtract(y_true[i], y_pred[i])))

mae = mean_absolute_error(y_true, y_pred)
mse = mean_squared_error(y_true, y_pred)
print(f"{mae=}")
print(f"{mse=}")
# -----------------------------
# 5. Plot results
# -----------------------------
fig, axs = plt.subplots(2, 1, figsize=(10, 8), sharex=True)

# ---- Top plot: cosine comparison
axs[0].plot(X_test, y_true, label="True cos(x)", linewidth=2)
axs[0].plot(X_test, y_pred, label="NN prediction", linestyle="--")
axs[0].set_xlabel("x")
axs[0].set_ylabel("cos(x)")
axs[0].set_title("Cosine Function vs Neural Network Prediction")
axs[0].legend()
axs[0].grid(True)

# ---- Bottom plot: error
axs[1].plot(X_test, error)
axs[1].set_title("absolue prediction Error")
axs[1].set_xlabel("x")
axs[1].set_ylabel("abs(y_true - y_pred)")
axs[1].grid(True)

plt.tight_layout()
plt.show()

# -----------------------------
# Export ANN weights to C header
# -----------------------------

def export_ann_to_header(model, scaler, filename="ann_weights.h"):

    with open(filename, "w") as f:

        f.write("#ifndef ANN_WEIGHTS_H\n")
        f.write("#define ANN_WEIGHTS_H\n\n")

        f.write("#include <math.h>\n\n")

        # ---------------------------------
        # Layer sizes
        # ---------------------------------

        layer_sizes = [model.coefs_[0].shape[0]]

        for w in model.coefs_:
            layer_sizes.append(w.shape[1])

        for i, size in enumerate(layer_sizes):
            f.write(f"#define LAYER_{i}_SIZE {size}\n")

        f.write("\n")

        # ---------------------------------
        # Standardization parameters
        # ---------------------------------

        f.write("// StandardScaler parameters\n")

        f.write(
            f"const float INPUT_MEAN = "
            f"{float(scaler.mean_[0]):.8f}f;\n"
        )

        f.write(
            f"const float INPUT_SCALE = "
            f"{float(scaler.scale_[0]):.8f}f;\n\n"
        )

        # ---------------------------------
        # Export flattened weights
        # ---------------------------------

        for layer_idx, weights in enumerate(model.coefs_):

            flat = weights.flatten()

            size = len(flat)

            f.write(
                f"const float W{layer_idx}[{size}] = {{\n"
            )

            for i, val in enumerate(flat):

                if i % 6 == 0:
                    f.write("    ")

                f.write(f"{val:.8f}f")

                if i != size - 1:
                    f.write(", ")

                if (i + 1) % 6 == 0:
                    f.write("\n")

            f.write("\n};\n\n")

        # ---------------------------------
        # Export biases
        # ---------------------------------

        for layer_idx, bias in enumerate(model.intercepts_):

            size = len(bias)

            f.write(
                f"const float B{layer_idx}[{size}] = {{\n"
            )

            for i, val in enumerate(bias):

                if i % 6 == 0:
                    f.write("    ")

                f.write(f"{val:.8f}f")

                if i != size - 1:
                    f.write(", ")

                if (i + 1) % 6 == 0:
                    f.write("\n")

            f.write("\n};\n\n")

        f.write("#endif\n")

    print(f"Exported weights to {filename}")


# Run export
export_ann_to_header(model, scaler)

import numpy as np

# ---------------------------------
# Quantized export
# ---------------------------------

def export_quantized_ann(model, scaler, filename="ann_weights_quantized.h"):

    with open(filename, "w") as f:

        f.write("#ifndef ANN_WEIGHTS_Q_H\n")
        f.write("#define ANN_WEIGHTS_Q_H\n\n")

        f.write("#include <stdint.h>\n\n")

        # ---------------------------------
        # Layer sizes
        # ---------------------------------

        layer_sizes = [model.coefs_[0].shape[0]]

        for w in model.coefs_:
            layer_sizes.append(w.shape[1])

        for i, size in enumerate(layer_sizes):
            f.write(f"#define LAYER_{i}_SIZE {size}\n")

        f.write("\n")

        # ---------------------------------
        # Input normalization
        # ---------------------------------

        f.write("// StandardScaler\n")

        f.write(
            f"const float INPUT_MEAN = "
            f"{float(scaler.mean_[0]):.8f}f;\n"
        )

        f.write(
            f"const float INPUT_SCALE = "
            f"{float(scaler.scale_[0]):.8f}f;\n\n"
        )

        # ---------------------------------
        # Quantize weights
        # ---------------------------------

        for layer_idx, weights in enumerate(model.coefs_):

            flat = weights.flatten()

            max_abs = np.max(np.abs(flat))

            scale = 127.0 / max_abs

            q = np.round(flat * scale).astype(np.int8)

            # Save scale
            f.write(
                f"const float W{layer_idx}_SCALE = "
                f"{scale:.8f}f;\n"
            )

            # Save quantized weights
            f.write(
                f"const int8_t W{layer_idx}[{len(q)}] = {{\n"
            )

            for i, val in enumerate(q):

                if i % 12 == 0:
                    f.write("    ")

                f.write(f"{int(val)}")

                if i != len(q) - 1:
                    f.write(", ")

                if (i + 1) % 12 == 0:
                    f.write("\n")

            f.write("\n};\n\n")

        # ---------------------------------
        # Quantize biases
        # ---------------------------------

        for layer_idx, bias in enumerate(model.intercepts_):

            max_abs = np.max(np.abs(bias))

            scale = 127.0 / max_abs

            q = np.round(bias * scale).astype(np.int8)

            f.write(
                f"const float B{layer_idx}_SCALE = "
                f"{scale:.8f}f;\n"
            )

            f.write(
                f"const int8_t B{layer_idx}[{len(q)}] = {{\n"
            )

            for i, val in enumerate(q):

                if i % 12 == 0:
                    f.write("    ")

                f.write(f"{int(val)}")

                if i != len(q) - 1:
                    f.write(", ")

                if (i + 1) % 12 == 0:
                    f.write("\n")

            f.write("\n};\n\n")

        f.write("#endif\n")

    print(f"Quantized header exported to: {filename}")


# Export quantized model
export_quantized_ann(model, scaler)