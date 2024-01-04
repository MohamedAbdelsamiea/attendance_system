from sklearn.ensemble import RandomForestClassifier
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

# Create and train the RandomForestClassifier
clf = RandomForestClassifier(n_estimators=100, random_state=42)
clf.fit(X_train, y_train)

# Make predictions on the test set
y_pred = clf.predict(X_test)

# Print confusion matrix
conf_matrix = confusion_matrix(y_test, y_pred)
print("Confusion Matrix:\n", conf_matrix)

# Evaluate the model
accuracy = accuracy_score(y_test, y_pred)
report = classification_report(y_test, y_pred, zero_division=1)

print(f"Accuracy: {accuracy}")
print("Classification Report:\n", report)

# Save the trained SVM model to a file
model_filename = "rf_model.pkl"
with open(model_filename, 'wb') as file:
    pickle.dump(clf, file)