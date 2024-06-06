from typing import Self
import serial
import mysql.connector
from serial.tools import list_ports
import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
import threading
import atexit

class DataCollector:
    def __init__(self):
        self.serial_port = None
        self.db_connection = None
        self.cursor = None
        self.is_storing = False
        self.stop_event = threading.Event()

        self.partial_package = ""  # To store incomplete package parts

        self.initialize_db_connection()

    def initialize_db_connection(self):
        try:
            self.db_connection = mysql.connector.connect(
                host='10.0.10.100',
                user='root',
                password='metrosite',
                database='yd_information_package'
            )
            self.cursor = self.db_connection.cursor()
        except mysql.connector.Error as err:
            if err.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
                messagebox.showerror("Xəta", "Giriş qadağandır. Zəhmət olmasa MySQL istifadəçi adınızı və parolunuzu yoxlayın.")
            elif err.errno == mysql.connector.errorcode.ER_BAD_DB_ERROR:
                messagebox.showerror("Xəta", "Verilənlər bazası mövcud deyil. Zəhmət olmasa əvvəlcə verilənlər bazası yaradın.")
            else:
                messagebox.showerror("Xəta", f"MySQL-ə qoşulma xətası: {err}")

    def start_storing(self):
        ports = list(list_ports.comports())
        if len(ports) == 0:
            messagebox.showerror("Xəta!", "Heç bir serial port tapılmadı. Mikrokontrollerin qoşulduğundan əmin olun.")
            return
        port = ports[0].device

        try:
            self.serial_port = serial.Serial(port=port, baudrate=9600, timeout=1)
        except serial.SerialException as e:
            messagebox.showerror("Xəta!", f"Serial portun açılma xətası: {e}")
            return

        print("Start storing information to the database.")
        self.is_storing = True
        self.stop_event.clear()
        self.start_storing_thread()

    def stop_storing(self):
        self.is_storing = False
        self.stop_event.set()

        if self.serial_port and self.serial_port.is_open:
            self.serial_port.close()

        print("Stop storing information.")

    def start_storing_thread(self):
        storing_thread = threading.Thread(target=self.read_packages)
        storing_thread.daemon = True
        storing_thread.start()

    def read_packages(self):
        while self.is_storing:
            try:
                line = self.serial_port.readline().decode('latin-1').strip()

                if not line:
                    continue

                self.partial_package += line

                package_values = self.partial_package.split('/')

                if len(package_values) < 31:
                    continue
                elif len(package_values) > 31:
                    messagebox.showwarning("Xəbərdarlıq", f"Yanlış paket formatı: {self.partial_package}")
                    self.partial_package = ""
                    continue

                try:
                    yd_value = int(package_values[0])  

                    table_number = f'yd_{yd_value}'

                    sql = f"INSERT INTO {table_number} (YD, YD_Info, Package_Num, RightTurn, LeftTurn, NumOfControl, " \
                        f"NumOfTurn, Kurbel, SOBS3AP, SOBS_Lost_Of_Control, Temperature, BlokKontakt, " \
                        f"Block_Contact_N, U_AB, U_BC, U_AC, CurrentValue1, CurrentValue2, CurrentValue3, CurrentValue4, " \
                        f"CurrentValue5, CurrentValue6, CurrentValue7, CurrentValue8, CurrentValue9, " \
                        f"CurrentValue10, Current_Accident_A, Current_Accident_B, Current_Accident_C, " \
                        f"Conversion_Period, V_of_Device) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, " \
                        f"%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"

                    self.cursor.execute(sql, package_values)
                    self.db_connection.commit()

                    print(f"Package stored successfully in {table_number}.")

                    self.partial_package = ""
                except ValueError as e:
                    messagebox.showwarning("Xəbərdarlıq", f"Paketin işlənməsi xətası: {e}")
            except serial.SerialException as e:
                messagebox.showerror("Xəta", f"Serial portundan oxunma xətası: {e}")
                break

    def close(self):
        self.stop_storing()
        if self.cursor:
            self.cursor.close()
        if self.db_connection:
            self.db_connection.close()



def start_collecting():
    start_button.config(state=tk.DISABLED)
    stop_button.config(state=tk.NORMAL)
    data_collector.start_storing()


def stop_collecting():
    start_button.config(state=tk.NORMAL)
    stop_button.config(state=tk.DISABLED)
    data_collector.stop_storing()


def show_tables():
    tables_window = tk.Toplevel(root)
    tables_window.title("Cədvəllər")
    tables_window.geometry("1110x400")

    x = 10
    y = 10
    for i in range(1, 59):
        table_name = f"yd_{i}"
        button = ttk.Button(
            tables_window,
            text=table_name,
            command=lambda name=table_name: show_table_data(name)
        )
        button.place(x=x, y=y, width=100, height=50)
        x += 110
        if i % 10 == 0:
            x = 10
            y += 60

def show_table_data(table_name):
    table_data_window = tk.Toplevel(root)
    table_data_window.title(table_name)
    table_data_window.geometry("1300x600")

    table_frame = ttk.Frame(table_data_window)
    table_frame.pack(fill="both", expand=True)

    if data_collector.db_connection is None or data_collector.cursor is None:
        table_data_window.destroy()
        messagebox.showerror("Xəta", "Məlumatların toplanmasına başlanmayıb. Zəhmət olmasa əvvəlcə məlumat toplamağa başlayın.")
        return

    try:
        cursor = data_collector.cursor
        db_connection = data_collector.db_connection

        cursor.execute(f"SELECT * FROM {table_name} ORDER BY ID ASC")
        table_data = cursor.fetchall()

        column_names = [column[0] for column in cursor.description]

        table_tree = ttk.Treeview(table_frame)
        table_tree["columns"] = column_names
        table_tree["show"] = "headings"

        for column in column_names:
            table_tree.heading(column, text=column)
            table_tree.column(column, width=100)

        for row in table_data:
            table_tree.insert("", "end", values=row)

        scrollbar_x = ttk.Scrollbar(table_frame, orient="horizontal", command=table_tree.xview)
        table_tree.configure(xscrollcommand=scrollbar_x.set)

        table_tree.pack(side="left", fill="both", expand=True)
        scrollbar_x.pack(fill="x")

        table_frame.pack_propagate(0)
    except mysql.connector.Error as err:
        messagebox.showerror("Xəta", f"Cədvəl məlumatını əldə edərkən xəta baş verdi: {err}")


def on_enter(e):
    e.widget.state(["pressed", "!disabled"])


def on_leave(e):
    e.widget.state(["!pressed"])


def on_close():
    data_collector.close()
    root.destroy()


data_collector = DataCollector()

root = tk.Tk()
root.title("Serial Port Məlumat Qeydiyyatçısı")
root.geometry("300x250")
root.protocol("WM_DELETE_WINDOW", on_close)

style = ttk.Style()
style.configure("TButton", padding=6, relief="flat", background="#ccc",
                foreground="#000", font=("Helvetica", 10))

style.map("TButton",
          foreground=[("pressed", "#ccc"), ("active", "#fff")],
          background=[("pressed", "#fff"), ("active", "#007bff")])

start_button = ttk.Button(root, text="Start", command=start_collecting, style="TButton")
start_button.pack(pady=10)

stop_button = ttk.Button(root, text="Stop", command=stop_collecting, style="TButton", state=tk.DISABLED)
stop_button.pack(pady=10)

show_tables_button = ttk.Button(root, text="Cədvəlləri Göstər", command=show_tables, style="TButton")
show_tables_button.pack(pady=10)

close_button = ttk.Button(root, text="Bağla", command=on_close, style="TButton")
close_button.pack(pady=10)

start_button.bind("<Enter>", on_enter)
start_button.bind("<Leave>", on_leave)
stop_button.bind("<Enter>", on_enter)
stop_button.bind("<Leave>", on_leave)
show_tables_button.bind("<Enter>", on_enter)
show_tables_button.bind("<Leave>", on_leave)
close_button.bind("<Enter>", on_enter)
close_button.bind("<Leave>", on_leave)

atexit.register(on_close)

root.mainloop()
