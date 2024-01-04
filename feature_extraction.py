import os
import face_recognition
import cv2
import numpy as np

# Paths to the directory with video frames
frames_directory = "frames"

# Lists to store face encodings, names, and IDs
face_encodings_list = []
labels_list = []

# Loop through each directory in the frames directory
for student_directory in os.listdir(frames_directory):
    student_path = os.path.join(frames_directory, student_directory)

    # Lists to store face encodings, names, and IDs for the current student
    student_face_encodings = []
    labels = []

    # Extract name and ID from the video file name
    name_id = os.path.splitext(student_directory)[0]

    # Loop through frames in the student's directory
    for frame_file in os.listdir(student_path):
        frame_path = os.path.join(student_path, frame_file)

        # Read the frame
        frame = cv2.imread(frame_path)

        # Extract face locations
        face_locations = face_recognition.face_locations(frame)

        if len(face_locations) > 0:
            # Assuming only one face is present in each frame
            face_location = face_locations[0]

            # Extract face encodings
            face_encodings = face_recognition.face_encodings(frame, [face_location])[0]

            # Append face encodings, names, and IDs to the student's lists
            student_face_encodings.append(face_encodings)
            labels.append(name_id)

    # Append the student's lists to the main lists
    face_encodings_list.extend(student_face_encodings)
    labels_list.extend(labels)

# Convert lists to NumPy arrays
face_encodings_matrix = np.array(face_encodings_list)
labels_array = np.array(labels_list)

# Save the arrays to NumPy files if needed
np.save("face_encodings_matrix.npy", face_encodings_matrix)
np.save("labels_array.npy", labels_array)
