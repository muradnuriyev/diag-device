from flask import Flask, request, jsonify
from mysql.connector import pooling
from flask_cors import CORS
from datetime import datetime, timezone, timedelta

app = Flask(__name__)
CORS(app, origins="http://localhost:5173")

user_db_config = {
    "pool_name": "user_db_pool",
    "pool_size": 5,
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "yd_user_db",
    "connect_timeout": 30,
}
user_db_pool = pooling.MySQLConnectionPool(**user_db_config)

user_note_db_config = {
    "pool_name": "user_note_db_pool",
    "pool_size": 5,
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "yd_note_workers",
    "connect_timeout": 30,
}
user_note_db_pool = pooling.MySQLConnectionPool(**user_note_db_config)

info_package_db_config = {
    "pool_name": "info_package_db_pool",
    "pool_size": 5,
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "yd_information_package",
    "connect_timeout": 30,
}
info_package_db_pool = pooling.MySQLConnectionPool(**info_package_db_config)

@app.route('/login', methods=['POST'])
def login():
    db_user = user_db_pool.get_connection()
    db_info_package = info_package_db_pool.get_connection()
    
    try:
        data = request.json
        username = data.get('username')
        password = data.get('password')

        cursor = db_user.cursor(dictionary=True)
        query = "SELECT * FROM users WHERE username = %s AND password = %s"
        cursor.execute(query, (username, password))
        user = cursor.fetchall()

        if user:
            user_info = user[0]
            sahe_query = "SELECT Sahe FROM users WHERE ID = %s"
            cursor.execute(sahe_query, (user_info['ID'],))
            sahe_result = cursor.fetchone()
            user_info['sahe'] = sahe_result['Sahe'] if sahe_result else None

            response = jsonify({'message': 'Login successful', 'user_info': user_info})
            return response
        else:
            response = jsonify({'message': 'Invalid login credentials'})
            return response
    finally:
        db_user.close()
        db_info_package.close()

def check_alarms():
    db_info_package = info_package_db_pool.get_connection()
    try:
        alarms = []
        for table_num in range(1, 59):
            table_name = f"yd_{table_num}"
            query = f"SELECT * FROM {table_name} ORDER BY ID DESC" 

            cursor = db_info_package.cursor(dictionary=True)
            cursor.execute(query)
            records = cursor.fetchall()

            for record in records:
                timestamp = record['Timestamp']
                alarm_description = None

                v_of_device = record.get('V_of_Device', None)
                right_turn = record.get('RightTurn', None)
                left_turn = record.get('LeftTurn', None)
                temprature = record.get('Temperature', None)
                sobs3ap = record.get('SOBS3AP', None)
                uAB = record.get('U_AB', None)   #AB faza gərginlik həddi 
                uBC = record.get('U_BC', None)   #BC faza gərginlik həddi 
                uAC = record.get('U_AC', None)   #AC faza gərginlik həddi 
                phaseA = record.get('Current_Accident_A', None)
                phaseB = record.get('Current_Accident_B', None)
                phaseC = record.get('Current_Accident_C', None)

                if v_of_device is not None:
                    if v_of_device < 8:
                        alarm_description = "Qida gərginliyi normadan aşağıdır."
                    elif v_of_device > 12:
                        alarm_description = "Qida gərginliyi normadan artıqdır."

                    if right_turn == 0 and left_turn == 0:
                        alarm_description = "Yol dəyişdirici qəza vəziyyətindədir!"
                    elif right_turn == 1 and left_turn == 1:
                        alarm_description = "Yol dəyişdiriciyə nəzarət yoxdur."

                if temprature is not None and temprature >= 50:
                    alarm_description = "Temperatur normadan artıqdır!"

                if sobs3ap is not None and sobs3ap == 0:
                    alarm_description = "Nəzarətə gələn gərginlik sıfırdır!"

                if uAB and uBC and uAC is not None:
                    if int(uAB) >= 140:
                        alarm_description = "AB faza gərginlik həddi 140 V-dan (Volt) böyükdür!"
                    elif int(uBC) >= 140:
                        alarm_description = "BC faza gərginlik həddi 140 V-dan (Volt) böyükdür!"
                    elif int(uAC) >= 140:
                        alarm_description = "AC faza gərginlik həddi 140 V-dan (Volt) böyükdür!"
                    
                    if int(uAB) <= 100:
                        alarm_description = "AB faza gərginlik həddi 100 V-dan (Volt) aşağıdır!"
                    elif int(uBC) <= 100:
                        alarm_description = "BC faza gərginlik həddi 100 V-dan (Volt) aşağıdır!"
                    elif int(uAC) <= 100:
                        alarm_description = "AC faza gərginlik həddi 100 V-dan (Volt) aşağıdır!"
                
                if phaseA and phaseB and phaseC is not None:
                    if int(phaseA) >= 3:
                        alarm_description = "A fazasında olan cərəyanın 10 qiymətin hər biri üçün hədd 3A-dən (Amper) böyükdür"
                    elif int(phaseB) >= 3:
                        alarm_description = "B fazasında olan cərəyanın 10 qiymətin hər biri üçün hədd 3A-dən (Amper) böyükdür"
                    elif int(phaseC) >= 3:
                        alarm_description = "C fazasında olan cərəyanın 10 qiymətin hər biri üçün hədd 3A-dən (Amper) böyükdür"
                    
                
                if alarm_description:
                    alarms.append({
                        'TableNumber': f"YD-{str(table_num).zfill(2)}",
                        'V_of_Device': v_of_device,
                        'RightTurn': right_turn,
                        'LeftTurn': left_turn,
                        'Temperature': temprature,
                        'SOBS3AP' : sobs3ap,
                        'U_AB' : uAB,
                        'U_BC' : uBC,
                        'U_AC' : uAC,
                        'Current_Accident_A' : phaseA,
                        'Current_Accident_B' : phaseB,
                        'Current_Accident_C' : phaseC,
                        'Timestamp': timestamp,
                        'AlarmDescription': alarm_description,
                    })
        alarms_sorted = sorted(alarms, key=lambda x: x['Timestamp'], reverse=True)
        return alarms_sorted
    finally:
        db_info_package.close()

@app.route('/table_names', methods=['GET'])
def get_table_names():
    db_info_package = info_package_db_pool.get_connection()
    
    try:
        cursor = db_info_package.cursor()
        query = "SHOW TABLES"
        cursor.execute(query)
        tables = [table[0] for table in cursor.fetchall()]

        response = jsonify({'tables': tables})
        return response
    finally:
        db_info_package.close()

@app.route('/table_data', methods=['POST'])
def get_table_data():
    db_info_package = info_package_db_pool.get_connection()

    try:
        data = request.json
        table_name = data.get('table')

        if table_name:
            cursor = db_info_package.cursor(dictionary=True)
            query = f"SELECT * FROM {table_name} ORDER BY ID DESC LIMIT 2"
            cursor.execute(query)
            records = cursor.fetchall()

            if len(records) == 2:
                record1, record2 = records
                yd_nazareti = "Sağ(+)" if record1['RightTurn'] == 1 and record1['LeftTurn'] == 0 else "Sol(-)" if record1['RightTurn'] == 0 and record1['LeftTurn'] == 1 else "Nəzarət yoxdur"
                yd_gerginliyi = record1['Voltage']
                current_values = [record1[f"CurrentValue{i}"] for i in range(1, 9)] + [record1['CurrentValue19']]
                yd_cerayani_orta_qiymeti = round(sum(current_values) / len(current_values), 2)
                cihazin_temperaturu = record1['Temperature']
                blok_kontakt = "Açıq" if record1['Block_Contact'] == 1 else "Bağlı"
                
                if record1['RightTurn'] == 1 and record1['LeftTurn'] == 0:
                    yd_cervilme_muddeti = f"{(record1['Timestamp'] - record2['Timestamp']).seconds} saniyə"
                elif record1['RightTurn'] == 0 and record1['LeftTurn'] == 1:
                    yd_cervilme_muddeti = f"{(record2['Timestamp'] - record1['Timestamp']).seconds} saniyə"
                else:
                    yd_cervilme_muddeti = "-"

                table_data = {
                    "Blok-kontakt": blok_kontakt,
                    "Cihazın temperaturu": cihazin_temperaturu,
                    "YD-nin cərəyanının orta qıyməti": yd_cerayani_orta_qiymeti,
                    "YD-nin gərginliyi": yd_gerginliyi,
                    "YD-nın nəzarəti": yd_nazareti,
                    "YD-nın çevrilmə müddəti": yd_cervilme_muddeti,
                }
                
                phase_message = "Yoldəyişdiricinin fazalarında gərginliklər fərqi 10 Voltdan yuxarıdır." if record1.get('Phase') == 1 else "Yoldəyişdiricinin fazalarında gərginliklər fərqi 10 Voltdan aşağıdır." if record1.get('Phase') == 0 else None
                if phase_message:
                    table_data["Phase"] = phase_message
                
                current_difference = abs(record1['Current_Difference'])

                current_difference_message = "Yoldəyişdiricinin fazalarında cərəyanlar fərqi 0 amperdir."
                if current_difference >= 0.5:
                    current_difference_message = "Yoldəyişdiricinin fazalarında cərəyanlar fərqi 0.5 amperdir."

                table_data["Current_Difference"] = current_difference_message

                response = jsonify(table_data)
                return response
            
        return jsonify({}), 200
    
    finally:
        db_info_package.close()

@app.route('/table_numbers', methods=['GET'])
def get_table_numbers():
    db_info_package = info_package_db_pool.get_connection()

    try:
        table_numbers = [str(i) for i in range(1, 59)]
        response = jsonify({'table_numbers': table_numbers})
        return response
    finally:
        db_info_package.close()

@app.route('/timestamps/<int:table_number>', methods=['GET'])
def get_timestamps(table_number):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if 1 <= table_number <= 58:
            table_name = f"yd_{table_number}"
            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    query = f"SELECT Timestamp FROM `{table_name}` ORDER BY Timestamp ASC"
                    cursor.execute(query)
                    timestamps = [record['Timestamp'] for record in cursor.fetchall()]

                response = jsonify({'timestamps': timestamps})
                return response
            except Exception as e:
                print(f"Error fetching timestamps: {e}")
                return jsonify({'error': 'An error occurred'}), 500
        else:
            return jsonify({'error': 'Invalid table number'}), 400
    
    finally:
        db_info_package.close()


@app.route('/v_of_device_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
def get_v_of_device_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, V_of_Device FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    v_of_device_data = cursor.fetchall()

                response = jsonify({'VofDeviceData': v_of_device_data})
                return response
            except Exception as e:
                print(f"Error fetching V_of_Device data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/temperature_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
def get_temperature_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, Temperature FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    temperature_data = cursor.fetchall()

                response = jsonify({'temperatureData': temperature_data})
                return response
            except Exception as e:
                print(f"Error fetching temperature data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/voltage_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
def get_voltage_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, Voltage FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    voltage_data = cursor.fetchall()

                response = jsonify({'voltageData': voltage_data})
                return response
            except Exception as e:
                print(f"Error fetching voltage data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/block_contact_n_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
def get_block_contact_n_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, Block_Contact_N FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    block_contact_n_data = cursor.fetchall()

                response = jsonify({'blockContactNData': block_contact_n_data})
                return response
            except Exception as e:
                print(f"Error fetching Block_Contact_N data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/number_of_change_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
def get_number_of_change_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, NumberOfChange FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    number_of_change_data = cursor.fetchall()

                response = jsonify({'numberOfChangeData': number_of_change_data})
                return response
            except Exception as e:
                print(f"Error fetching NumberOfChange data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()


@app.route('/alarms', methods=['GET'])
def get_alarms():
    db_info_package = info_package_db_pool.get_connection()
    try:
        alarms = check_alarms()
        return jsonify(alarms)
    finally:
        db_info_package.close()

@app.route('/store_note', methods=['POST'])
def store_note():
    db_info_package = user_note_db_pool.get_connection()

    try:
        data = request.json
        sahe = data.get('sahe')
        user_full_name = data.get('userFullName')
        note = data.get('note')

        query = "INSERT INTO yd_note_workers (Sahe, FullName, Note) VALUES (%s, %s, %s)"
        with db_info_package.cursor() as cursor:
            cursor.execute(query, (sahe, user_full_name, note))
        db_info_package.commit()

        response = jsonify({'message': 'Note stored successfully'})
        return response
    finally:
        db_info_package.close()
       

@app.route('/get_notes', methods=['GET'])
def get_notes():
    db_info_package = info_package_db_pool.get_connection()

    try:
        with db_info_package.cursor(dictionary=True) as cursor:
            cursor.execute("SELECT * FROM yd_note_workers")
            notes = cursor.fetchall()

        response = jsonify({'notes': notes})
        return response
    finally:
        db_info_package.close()

if __name__ == '__main__':
    app.run(debug=True, threaded=True, host='0.0.0.0', port=5000)