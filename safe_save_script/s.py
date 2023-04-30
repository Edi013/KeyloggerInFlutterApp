import shutil
import pyautogui
import os
import time

def takeSS():
    global screenshoots_path, ss_contor

    ss_name = "ss" + str(ss_contor) + ".png"
    ss_contor += 1

    temp_ss = pyautogui.screenshot()
    temp_ss.save(screenshoots_path + ss_name)


ss_time_rate = 1
ss_contor = 1
time_alive = 150

directory_path = os.getcwd() + "\\ss"

if os.path.exists(directory_path):
    shutil.rmtree(directory_path)
os.mkdir(directory_path)

screenshoots_path = directory_path + "\\"

while ss_contor < time_alive :
    takeSS()
    time.sleep(ss_time_rate)

