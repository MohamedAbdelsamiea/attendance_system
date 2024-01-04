from sklearn.svm import SVC
from sklearn.model_selection import train_test_split, cross_val_predict
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
import numpy as np
import pickle

# Load your data (replace these with your actual data)
face_encodings_matrix = np.load("face_encodings_matrix.npy")
labels_array = np.load("labels_array.npy")

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(
    face_encodings_matrix, labels_array, test_size=0.2, random_state=42
)

# Initialize the SVM model
clf = SVC(kernel='rbf', C=10.0)

# Fit the model on the training data
clf.fit(X_train, y_train)

# Now the model is fitted, and we can use it for predictions

# Use cross-validation for more robust evaluation
y_pred = cross_val_predict(clf, face_encodings_matrix, labels_array, cv=5)

# Print confusion matrix
conf_matrix = confusion_matrix(labels_array, y_pred)
print("Confusion Matrix:\n", conf_matrix)

# Evaluate the model
accuracy = accuracy_score(labels_array, y_pred)
report = classification_report(labels_array, y_pred, zero_division=1)

print(f"Accuracy: {accuracy}")
print("Classification Report:\n", report)

# Save the trained SVM model to a file
model_filename = "svm_model.pkl"
with open(model_filename, 'wb') as file:
    pickle.dump(clf, file)
