import keyboard
import numpy as np
import math
import matplotlib.pyplot as plt
import imagesc as imagesc

def setStopFlag():
    global blStop
    blStop = True

if __name__ == '__main__':
    phi = 0
    blStop = False
    
    # 实现监控键盘，按特殊键退出
    while True:
        keyboard.add_hotkey('space', setStopFlag)
        
        x_t = np.arange(0, 2 * math.pi, math.pi / 1000)
        x = np.sin(5 * x_t + phi).reshape(1, -1)
        plt.pcolor(x, cmap='gray')
        plt.title('PRESS SPACE TO STOP')
        plt.pause(0.001)
        
        phi = phi + math.pi / 100
        
        if blStop:
            print('End: Stopped by User!')
            break
