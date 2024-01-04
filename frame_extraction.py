import cv2
import os

video_directory = r"C:\Users\moham\Downloads\Dataset\Dataset"
output_directory = "frames"
frame_interval = 10  # Extract every 10 frames, adjust as needed

for video_file in os.listdir(video_directory):
    video_path = os.path.join(video_directory, video_file)
    output_path = os.path.join(output_directory, video_file.split('.')[0])

    os.makedirs(output_path, exist_ok=True)

    cap = cv2.VideoCapture(video_path)
    frame_count = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))

    for i in range(0, frame_count, frame_interval):
        ret, frame = cap.read()
        if not ret:
            break

        frame_path = os.path.join(output_path, f"frame_{i}.jpg")
        cv2.imwrite(frame_path, frame)

    cap.release()
