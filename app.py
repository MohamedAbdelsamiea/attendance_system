from flask import Flask, request, jsonify
import cv2
import face_recognition
import numpy as np
import pickle

app = Flask(__name__)

# Load the SVM model
with open("svm_model.pkl", 'rb') as file:
    loaded_model = pickle.load(file)

def extract_face_features(frame):
    face_locations = face_recognition.face_locations(frame)
    face_encodings = face_recognition.face_encodings(frame, face_locations)

    features_list = []
    for face_encoding in face_encodings:
        features_list.append(face_encoding)

    return features_list

@app.route('/predict', methods=['POST'])
def predict():
    # Receive image from Flutter app
    image_file = request.files['image']
    nparr = np.fromstring(image_file.read(), np.uint8)
    input_image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    # Convert the image to RGB format (required by face_recognition)
    rgb_image = cv2.cvtColor(input_image, cv2.COLOR_BGR2RGB)

    # Extract face features from the input image
    face_features_list = extract_face_features(rgb_image)

    predictions = []

    if face_features_list:
        for i, face_features in enumerate(face_features_list):
            # Make predictions using the SVM model
            predicted_label = str(loaded_model.predict([face_features])[0])
            name = predicted_label.split("_")[0]
            id = predicted_label.split("_")[1]
            prediction_dict = {"name": name, "id": id}
            predictions.append(prediction_dict)

    return jsonify(predictions)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
