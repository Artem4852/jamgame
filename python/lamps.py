import pyautogui, time, pyperclip

time.sleep(3)

def getPos(filename):
    try: x, y = pyautogui.locateCenterOnScreen(f'python/{filename}.png')
    except: return None
    return x/2, y/2

while True:
    # select the object
    pyautogui.click(getPos('object'))
    pyautogui.press('down')

    # copy x
    pyautogui.moveTo(getPos('locX'))
    pyautogui.moveRel(50, 0)
    pyautogui.click()
    pyautogui.hotkey('command', 'c')

    x = pyperclip.paste()

    # copy y
    pyautogui.press('Tab')
    pyautogui.hotkey('command', 'c')

    y = pyperclip.paste()

    # copy z
    pyautogui.press('Tab')
    pyautogui.hotkey('command', 'c')

    z = pyperclip.paste()

    y, z = z, y

    z = '-1*'+z

    pyautogui.click(getPos('godotSelected'))

    # duplicate
    pyautogui.hotkey('command', 'd')

    time.sleep(1)

    # click on transform
    pyautogui.moveTo(getPos('transform'))
    pyautogui.moveRel(0, 20)
    pyautogui.click()

    time.sleep(1)

    # click on x
    pyautogui.moveTo(getPos('godotPosX'))
    pyautogui.moveRel(20, 20)
    pyautogui.click()

    pyperclip.copy(x)

    # paste x
    pyautogui.hotkey('command', 'v')

    # click on y
    pyautogui.press('Tab')

    pyperclip.copy(y)

    # paste y
    pyautogui.hotkey('command', 'v')

    # click on z
    pyautogui.press('Tab')

    pyperclip.copy(z)

    # paste z
    pyautogui.hotkey('command', 'v')