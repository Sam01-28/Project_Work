import cv2
import numpy as np
import time
import tkinter as tk
from tkinter import filedialog

def sketch(image):

    height = int(image.shape[0])
    width = int(image.shape[1])
    dim = (width, height)
    
    resize = cv2.resize(image, dim, interpolation=cv2.INTER_AREA)
    kernel = np.array([[-1, -1, -1], [-1, 9, -1], [-1, -1, -1]])
    
    sharp = cv2.filter2D(resize, -1, kernel)
    gray = cv2.cvtColor(sharp, cv2.COLOR_BGR2GRAY)
    inv = 255 - gray
    
    blur = cv2.GaussianBlur(src=inv, ksize=(15, 15), sigmaX=0, sigmaY=0)
    s = cv2.divide(gray, 255 - blur, scale=256)
    return s

cap = cv2.VideoCapture(0)
save_interval = 3  
start_time = time.time()

def open_image():
    
    root = tk.Tk()
    root.withdraw()
    file_path = filedialog.askopenfilename()
    root.destroy()
    return file_path

while True:

    ret, frame = cap.read()
    
    cv2.imshow('Live Sketch', sketch(frame))
    cv2.imshow('Live Image', frame)
    
    elapsed_time = time.time() - start_time

    if elapsed_time >= save_interval:

        sketch_image = sketch(frame)
        cv2.imwrite(f'sketch_{int(time.time())}.jpg', sketch_image)
        start_time = time.time()
    
    key = cv2.waitKey(1)
    if key == ord('q'):
        break
    
    elif key == ord('c'):
        file_path = open_image()
        if file_path:
            image = cv2.imread(file_path)
            cv2.imshow('Loaded Image', image)
            sketch_image = sketch(image)
            cv2.imshow('Sketch from Loaded Image', sketch_image)

cap.release()
cv2.destroyAllWindows()
