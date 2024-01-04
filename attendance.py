import cv2
import face_recognition
import pickle

with open("svm_model.pkl", 'rb') as file:
    loaded_model = pickle.load(file)

# Load the input image
input_image_path = "input3.jpg"
input_image = cv2.imread(input_image_path)

# Function to extract face features using face_recognition
def extract_face_features(frame):
    face_locations = face_recognition.face_locations(frame)
    face_encodings = face_recognition.face_encodings(frame, face_locations)

    features_list = []
    for face_encoding in face_encodings:
        features_list.append(face_encoding)

    return features_list

# Function to predict attendance from the input image
def predict_attendance(image, model):
    # Convert the image to RGB format (required by face_recognition)
    rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    # Extract face features from the input image
    face_features_list = extract_face_features(rgb_image)

    if face_features_list:
        for i, face_features in enumerate(face_features_list):
            # Make predictions using the SVM model
            predicted_label = model.predict([face_features])[0]

            # Print or log the attendance information
            print(f"Face {i + 1} - Predicted ID: {predicted_label}")

# Call the predict_attendance function with the input image and loaded model
predict_attendance(input_image, loaded_model)
