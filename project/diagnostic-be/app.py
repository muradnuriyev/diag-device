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
        prev_conversion_period = None  
        for table_num in range(1, 59):
            table_name = f"yd_{table_num}"
            query = f"SELECT * FROM {table_name} ORDER BY ID DESC" 

            cursor = db_info_package.cursor(dictionary=True)
            cursor.execute(query)
            records = cursor.fetchall()

            for record in records:
                timestamp = record['Timestamp']

                v_of_device = record.get('V_of_Device', None)
                right_turn = record.get('RightTurn', None)
                left_turn = record.get('LeftTurn', None)
                temperature = record.get('Temperature', None)
                sobs3ap = record.get('SOBS3AP', None)
                uAB = record.get('U_AB', None)   # AB faza gərginlik həddi 
                uBC = record.get('U_BC', None)   # BC faza gərginlik həddi 
                uAC = record.get('U_AC', None)   # AC faza gərginlik həddi 
                phaseA = record.get('Current_Accident_A', None)
                phaseB = record.get('Current_Accident_B', None)
                phaseC = record.get('Current_Accident_C', None)
                ydInfo = record.get("YD_Info", None)
                currentValue1 = record.get("CurrentValue1", None)
                currentValue2 = record.get("CurrentValue2", None)
                currentValue3 = record.get("CurrentValue3", None)
                currentValue4 = record.get("CurrentValue4", None)
                currentValue5 = record.get("CurrentValue5", None)
                currentValue6 = record.get("CurrentValue6", None)
                currentValue7 = record.get("CurrentValue7", None)
                currentValue8 = record.get("CurrentValue8", None)
                currentValue9 = record.get("CurrentValue9", None)
                currentValue10 = record.get("CurrentValue10", None)
                sobsLostOfcontrol = record.get("SOBS_Lost_Of_Control", None)
                numOfControl = record.get("NumOfControl", None)
                packageNum = record.get("Package_Num", None)
                conversion_period = record.get('Conversion_Period', None)


                if prev_conversion_period is not None and conversion_period is not None:
                    difference = abs(conversion_period - prev_conversion_period)
                    if difference > 1:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'Conversion_Period_Difference': difference,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Çevrilmə müddətinin fərqi 1 saniyədən böyükdür",
                        })
                prev_conversion_period = conversion_period
                
                if v_of_device is not None:
                    if float(v_of_device) >= 13:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'V_of_Device': v_of_device,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Qida gərginliyi 12 voltdan artıqdır.",
                        })
                    if float(v_of_device) >= 11 and float(v_of_device) < 13:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'V_of_Device': v_of_device,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Qida gərginliyi 11 voltdan artıqdır.",
                        })

                if temperature is not None:
                    if temperature >= 50:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'Temperature': temperature,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Temperatur 50°C  artıqdır!",
                        })
                    if temperature >= 45 and temperature < 50:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'Temperature': temperature,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Temperatur 45°C artıqdır!",
                        })

                if right_turn is not None and left_turn is not None:
                    if right_turn == 0 and left_turn == 0:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'RightTurn': right_turn,
                            'LeftTurn': left_turn,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Yol dəyişdirici qəza vəziyyətindədir!",
                        })
                    elif right_turn == 1 and left_turn == 1:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'RightTurn': right_turn,
                            'LeftTurn': left_turn,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Yol dəyişdiriciyə nəzarət yoxdur.",
                        })

                if sobs3ap is not None:
                    if sobs3ap == 0:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'SOBS3AP' : sobs3ap,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Nəzarətə gələn gərginlik sıfırdır!",
                        })

                if uAB and uBC and uAC is not None:
                    if int(uAB) >= 140:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'U_AB' : uAB,
                            'Timestamp': timestamp,
                            'AlarmDescription': "AB faza gərginlik həddi 140 V-dan (Volt) böyükdür!",
                        })
                    if int(uBC) >= 140:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'U_BC' : uBC,
                            'Timestamp': timestamp,
                            'AlarmDescription': "BC faza gərginlik həddi 140 V-dan (Volt) böyükdür!",
                        })
                    if int(uAC) >= 140:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'U_AC' : uAC,
                            'Timestamp': timestamp,
                            'AlarmDescription': "AC faza gərginlik həddi 140 V-dan (Volt) böyükdür!",
                        })
                    
                    if int(uAB) <= 100:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'U_AB' : uAB,
                            'Timestamp': timestamp,
                            'AlarmDescription': "AB faza gərginlik həddi 100 V-dan (Volt) aşağıdır!",
                        })
                    if int(uBC) <= 100:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'U_BC' : uBC,
                            'Timestamp': timestamp,
                            'AlarmDescription': "BC faza gərginlik həddi 100 V-dan (Volt) aşağıdır!",
                        })
                    if int(uAC) <= 100:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'U_AC' : uAC,
                            'Timestamp': timestamp,
                            'AlarmDescription': "AC faza gərginlik həddi 100 V-dan (Volt) aşağıdır!",
                        })
                
                if phaseA and phaseB and phaseC is not None:
                    if int(phaseA) >= 3:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'Current_Accident_A' : phaseA,
                            'Timestamp': timestamp,
                            'AlarmDescription': "A fazasında olan cərəyanın 10 qiymətin hər biri üçün hədd 3A-dən (Amper) böyükdür",
                        })                   
                    if int(phaseB) >= 3:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'Current_Accident_B' : phaseB,
                            'Timestamp': timestamp,
                            'AlarmDescription': "B fazasında olan cərəyanın 10 qiymətin hər biri üçün hədd 3A-dən (Amper) böyükdür",
                        })
                    if int(phaseC) >= 3:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'Current_Accident_C' : phaseC,
                            'Timestamp': timestamp,
                            'AlarmDescription': "C fazasında olan cərəyanın 10 qiymətin hər biri üçün hədd 3A-dən (Amper) böyükdür",
                        })

                if currentValue1 and currentValue2 and currentValue3 and currentValue4 and currentValue5 and currentValue6 and currentValue7 and currentValue8 and currentValue9 and currentValue10 is not None:
                    if float(currentValue1) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue1' : currentValue1,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (1) birinci qiymətinin həddi 3 A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue2) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue2' : currentValue2,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (2) ikinci qiymətinin həddi 3 A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue3) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue3' : currentValue3,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (3) üçüncü qiymətinin həddi 3A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue4) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue4' : currentValue4,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (4) dördüncü qiymətinin həddi 3A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue5) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue5' : currentValue5,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (5) qiymətinin həddi 3A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue6) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue6' : currentValue6,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (6) altıncı qiymətinin həddi 3A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue7) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue7' : currentValue7,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (7) yeddinci qiymətinin həddi  3A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue8) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue8' : currentValue8,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (8) səkkizinci qiymətinin həddi 3A-dən (Amper) böyükdür!",
                        })
                    if float(currentValue9) > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue9' : currentValue9,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (9) doqquzuncu qiymətinin həddi 3A-dən (Amper) böyükdür!",
                        })
                    if currentValue10 > 3.00:
                        alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'CurrentValue10' : currentValue10,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Cərəyanın (10) onuncu qiymətinin həddi 3A-dən (Amper) böyükdür!",
                        })

                    if sobsLostOfcontrol is not None:
                        if sobsLostOfcontrol > 0:
                            alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'SOBS_Lost_Of_Control' : sobsLostOfcontrol,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Nəzarətə gələn gərginliyin(SOBS3AP) itmə sayı (0) sıfırdan böyükdür",
                        })
                            
                    if numOfControl is not None:
                        if numOfControl > 0:
                            alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'NumOfControl' : numOfControl,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Nəzarət itmə sayı (0) sıfırdan böyükdür",
                        })
                            
                    if ydInfo is not None:
                        if int(ydInfo) == 0:
                            alarms.append({
                                'TableNumber': f"YD-{str(table_num).zfill(2)}",
                                'YD_Info' : ydInfo,
                                'Timestamp': timestamp,
                                'AlarmDescription': "Qəbul paketində itki var",
                            })
                
                    if packageNum is not None:
                        if int(packageNum) >= 0 and int(packageNum) < 1:
                            alarms.append({
                                'TableNumber': f"YD-{str(table_num).zfill(2)}",
                                'Package_Num' : packageNum,
                                'Timestamp': timestamp,
                                'AlarmDescription': "Yoldəyişdirici məlumat göndərməyib",
                            })

        alarms_sorted = sorted(alarms, key=lambda x: x['Timestamp'], reverse=True)
        return alarms_sorted
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
            query = f"SELECT * FROM {table_name} ORDER BY Timestamp DESC LIMIT 1"
            cursor.execute(query)
            records = cursor.fetchall()

            if len(records) == 1:
                record = records[0]

                ydInfo = "NOT OK" if record.get('YD_Info') == 0 else "OK"
                rightOrLeftTurn = "Sağ (+)" if record.get('RightTurn') == 1 and record.get('LeftTurn') == 0 else "Sol (-)" if record.get('RightTurn') == 0 and record.get('LeftTurn') == 1 else "Nəzarət yoxdur"
                numOfControl = record.get('NumOfControl')
                kurbel = "Çevrilməyib" if record.get('Kurbel') == 0 else "Çevrilib"
                sobs3ap = record.get('SOBS3AP')
                sobsLostOfcontrol = record.get('SOBS_Lost_Of_Control')
                v_Of_Device = record.get('V_of_Device')
                uAB = record.get('U_AB')
                uBC = record.get('U_BC')
                uAC = record.get('U_AC')
                block_contact_n = record.get('Block_Contact_N')
                temperature = record.get('Temperature')              
                currentAccidentA = record.get('Current_Accident_A')
                currentAccidentB = record.get('Current_Accident_B')
                currentAccidentC = record.get('Current_Accident_C')
                convertionPeriod = record.get('Conversion_Period')
                numOfTurn = record.get('NumOfTurn')
                current_values = "  /  ".join(str(record.get(f"CurrentValue{i}")) for i in range(1, 11))
                block_kontakt = "Açıq" if record.get('BlokKontakt') == 1 else "Bağlı"
                timestamp = record.get("Timestamp")
                
                
                table_data = {
                    "Məlumat qəbulu":ydInfo,
                    "Gərginlik Faza AB": uAB,
                    "Nəzarət": rightOrLeftTurn,
                    "Gərginlik Faza BC": uBC,
                    "Nəzarətin itmə sayı": numOfControl,
                    "Gərginlik Faza AC": uAC,
                    "YD-nın çevrilmə sayı": numOfTurn,
                    "Qəza cərəyanı Faza A": currentAccidentA,
                    "Kurbel ilə": kurbel,
                    "Qəza cərəyanı Faza B": currentAccidentB,
                    "Nəzarətə gələn gərginlik": sobs3ap,
                    "Qəza cərəyanı Faza C": currentAccidentC,
                    "Nəzarətə gələn gərginliyin itmə sayı":sobsLostOfcontrol,
                    "Cihazın qida gərginliyi": v_Of_Device,
                    "Temperatur": temperature,
                    "YD-nın çevrilmə müddəti": convertionPeriod,
                    "Blok-Kontakt": block_kontakt,
                    "YD-nın çevrilmə cərəyanı": current_values,
                    "Blok-Kontakt sayı": block_contact_n,
                    "Vaxt": timestamp,
                }
                
                return jsonify(table_data), 200

            
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