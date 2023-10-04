from flask import Flask, render_template, request
import serial

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/', methods=['POST'])
def buttonClickClose():
    ser=serial.Serial()
    ser.port='/dev/ttyUSB0'
    ser.baudrate=115200
    try:
        ser.open()
    except:
        print("Error opening serial port")
        exit()
    if ser.isOpen():
        try:
            ser.write(b'[0301060100024D')
            ser.close()
        except:
            print("cannot write to serial device")
            ser.close()

    return render_template('index.html')
    
@app.route('/', methods=['POST'])
def buttonClickOpen():
    ser=serial.Serial()
    ser.port='/dev/ttyUSB0'
    ser.baudrate=115200
    try:
        ser.open()
    except:
        print("Error opening serial port")
        exit()
    if ser.isOpen():
        try:
            ser.write(b'[0301060100014C')
            ser.close()
        except:
            print("cannot write to serial device")
            ser.close()

    return render_template('index.html')
