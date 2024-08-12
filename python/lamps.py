import pyautogui, time, pyperclip

time.sleep(3)

def getPos(filename):
    try: x, y = pyautogui.locateCenterOnScreen(f'python/{filename}.png')
    except: return None
    return x/2, y/2

single = """

[node name="lampSmall{index}" parent="lamps" instance=ExtResource("2_88uo4")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, {x}, {y}, {z})
rotation_order = 0"""
output = """"""

n = 89
while True:
    # select the object
    pyautogui.click(getPos('object'))
    pyautogui.press('down')

    # copy x
    pyautogui.moveTo(getPos('locX'))
    pyautogui.moveRel(50, 0)
    pyautogui.click()
    pyautogui.hotkey('command', 'c')

    x = float(pyperclip.paste().replace(" m", ""))

    # copy y
    pyautogui.press('Tab')
    pyautogui.hotkey('command', 'c')

    y = float(pyperclip.paste().replace(" m", ""))

    # copy z
    pyautogui.press('Tab')
    pyautogui.hotkey('command', 'c')

    z = float(pyperclip.paste().replace(" m", ""))

    y, z = z, -y

    output += single.format(index=n, x=x, y=y, z=z)
    n += 1

    if n >= 99: break

print(output)
pyperclip.copy(output)