from dotenv import load_dotenv
import os
from flask import Flask, request, jsonify
from flask_cors import CORS
from datetime import datetime, timezone, timedelta
from flask_jwt_extended import JWTManager, create_access_token, jwt_required
import mysql.connector.pooling
import types


app = Flask(__name__)
app.config.from_prefixed_env()
load_dotenv()
CORS(app, origins=os.getenv("FRONTEND_URL"))

app.config["JWT_SECRET_KEY"] = os.getenv("JWT_SECRET_KEY")
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(days=30)
jwt=JWTManager()
jwt.init_app(app)

user_db_config = {
    "pool_name": "user_db_pool",
    "pool_size": 10,
    "host": os.getenv("DATABASE_HOST"),
    "user": os.getenv("DATABASE_USER"),
    "password": os.getenv("DATABASE_PASSWORD"),
    "port": os.getenv("DATABASE_PORT"),
    "database": "yd_user_db",
    "connect_timeout": 30,
}

user_note_db_config = {
    "pool_name": "user_note_db_pool",
    "pool_size": 10,
    "host": os.getenv("DATABASE_HOST"),
    "user": os.getenv("DATABASE_USER"),
    "password": os.getenv("DATABASE_PASSWORD"),
    "port": os.getenv("DATABASE_PORT"),
    "database": "yd_note_workers",
    "connect_timeout": 30,
}

info_package_db_config = {
    "pool_name": "info_package_db_pool",
    "pool_size": 10,
    "host": os.getenv("DATABASE_HOST"),
    "user": os.getenv("DATABASE_USER"),
    "password": os.getenv("DATABASE_PASSWORD"),
    "port": os.getenv("DATABASE_PORT"),
    "database": "yd_information_package",
    "connect_timeout": 30,
}

user_db_pool = mysql.connector.pooling.MySQLConnectionPool(**user_db_config)
user_note_db_pool = mysql.connector.pooling.MySQLConnectionPool(**user_note_db_config)
info_package_db_pool = mysql.connector.pooling.MySQLConnectionPool(**info_package_db_config)

def add_connection(pool, connection):
    pool._cnx_queue.put(connection)

user_db_pool.add = types.MethodType(add_connection, user_db_pool)
user_note_db_pool.add = types.MethodType(add_connection, user_note_db_pool)
info_package_db_pool.add = types.MethodType(add_connection, info_package_db_pool)


#=================================================================================== Login (Login.tsx) =============================================================================================

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

            access_token = create_access_token(identity=user_info['username'])

            response = jsonify({
                'message': 'Login successful', 
                'user_info': user_info, 
                'access_token': access_token
            })
            return response
        else:
            response = jsonify({'message': 'Invalid login credentials'})
            return response
    finally:
        db_user.close()
        db_info_package.close()

#============================================================================== Login (Login.tsx) ===================================================================================

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#=========================================================================== Əsas səhifə (HomePage.tsx) =============================================================================

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
                timestamp = record['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

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
                    if sobs3ap == 1:
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
                                'SOBS_Lost_Of_Control': sobsLostOfcontrol,
                                'Timestamp': timestamp,
                                'AlarmDescription': f"Nəzarətə gələn gərginliyin(SOBS3AP) itmə sayı: "+ str(sobsLostOfcontrol),
                            })

                            
                    if numOfControl is not None:
                        if numOfControl > 0:
                            alarms.append({
                            'TableNumber': f"YD-{str(table_num).zfill(2)}",
                            'NumOfControl' : numOfControl,
                            'Timestamp': timestamp,
                            'AlarmDescription': "Nəzarət itmə sayı (0) sıfırdan böyükdür və bərabərdir " +str(numOfControl),
                        })
                            
                    if ydInfo is not None:
                        ydInfo_list = [int(num) for num in str(ydInfo)]
                        continuous = True
                        for i in range(len(ydInfo_list) - 1):
                            if ydInfo_list[i + 1] - ydInfo_list[i] != 1:
                                continuous = False
                                break
                        if not continuous:
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
@jwt_required()
def get_alarms():
    db_info_package = info_package_db_pool.get_connection()
    try:
        alarms = check_alarms()
        return jsonify(alarms)
    finally:
        db_info_package.close()


#=========================================================================== Əsas səhifə (HomePage.tsx) =============================================================================

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#===================================================================== Cari Analiz (CurrentAnalysis.tsx page) =======================================================================
@app.route('/table_names', methods=['GET'])
@jwt_required()
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
@jwt_required()
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
                rightOrLeftTurn = "Sağ (+)" if record.get('RightTurn') == 0 and record.get('LeftTurn') == 1 else "Sol (-)" if record.get('RightTurn') == 1 and record.get('LeftTurn') == 0 else "Nəzarət yoxdur"
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
                timestamp = record.get("Timestamp").strftime("%d.%m.%Y, %H:%M:%S")
                
                
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


#===================================================================== Cari Analiz (CurrentAnalysis.tsx page) =======================================================================

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#================================================================== Interval Analiz (IntervalAnalysis.tsx page) =====================================================================
@app.route('/table_numbers', methods=['GET'])
@jwt_required()
def get_table_numbers():
    db_info_package = info_package_db_pool.get_connection()

    try:
        table_numbers = [str(i) for i in range(1, 59)]
        response = jsonify({'table_numbers': table_numbers})
        return response
    finally:
        db_info_package.close()

@app.route('/timestamps/<int:table_number>', methods=['GET'])
@jwt_required()
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
                    for d in timestamps:
                        d = d.strftime("%d.%m.%Y, %H:%M:%S")

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
@jwt_required()
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
                    for ts in v_of_device_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")
                        

                response = jsonify({'VofDeviceData': v_of_device_data})
                return response
            except Exception as e:
                print(f"Error fetching V_of_Device data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/temperature_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
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
                    for ts in temperature_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'temperatureData': temperature_data})
                return response
            except Exception as e:
                print(f"Error fetching temperature data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/current_values_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_current_values_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, CurrentValue1, CurrentValue2, CurrentValue3, CurrentValue4, CurrentValue5, CurrentValue6, CurrentValue7, CurrentValue8, CurrentValue9, CurrentValue10 FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    current_values_data = cursor.fetchall()

                    for ts in current_values_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'currentValuesData': current_values_data})
                return response
            except Exception as e:
                print(f"Error fetching current values data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/current_accident_values_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_current_accident_values_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, Current_Accident_A, Current_Accident_B, Current_Accident_C FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    current_accident_values_data = cursor.fetchall()

                    for ts in current_accident_values_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'currentAccidentValuesData': current_accident_values_data})
                return response
            except Exception as e:
                print(f"Error fetching current accident values data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/u_all_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_u_all_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, U_AB, U_BC, U_AC FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    u_all_data = cursor.fetchall()

                    for ts in u_all_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'uAllData': u_all_data})
                return response
            except Exception as e:
                print(f"Error fetching current accident values data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()


@app.route('/block_contact_n_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
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

                    for ts in block_contact_n_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'blockContactNData': block_contact_n_data})
                return response
            except Exception as e:
                print(f"Error fetching Block_Contact_N data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/block_contact_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_block_contact_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, BlokKontakt FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    block_contact_data = cursor.fetchall()

                    for ts in block_contact_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'blockContactData': block_contact_data})
                return response
            except Exception as e:
                print(f"Error fetching BlockKontakt data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/conversion_period_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_conversion_period_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, Conversion_Period FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    conversion_period_data = cursor.fetchall()

                    for ts in conversion_period_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'conversionPeriodData': conversion_period_data})
                return response
            except Exception as e:
                print(f"Error fetching Conversion_Period data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/num_of_control_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_num_of_control_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, NumOfControl FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    num_of_control_data = cursor.fetchall()

                    for ts in num_of_control_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'numOfControlData': num_of_control_data})
                return response
            except Exception as e:
                print(f"Error fetching NumOfControl data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/kurbel_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_kurbel_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, Kurbel FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    kurbel_data = cursor.fetchall()

                    for ts in kurbel_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'kurbelData': kurbel_data})
                return response
            except Exception as e:
                print(f"Error fetching Kurbel data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()

@app.route('/sobs_lost_of_control_data/<table>/<from_timestamp>/<to_timestamp>', methods=['GET'])
@jwt_required()
def get_sobs_lost_of_control_data(table, from_timestamp, to_timestamp):
    db_info_package = info_package_db_pool.get_connection()
    try:
        if table and from_timestamp and to_timestamp:
            formatted_from_timestamp = datetime.fromisoformat(from_timestamp[:-1]).replace(tzinfo=timezone.utc)
            formatted_to_timestamp = datetime.fromisoformat(to_timestamp[:-1]).replace(tzinfo=timezone.utc)

            query = f"SELECT Timestamp, SOBS_Lost_Of_Control FROM `{table}` WHERE Timestamp >= %s AND Timestamp <= %s ORDER BY Timestamp ASC"

            try:
                with db_info_package.cursor(dictionary=True) as cursor:
                    cursor.execute(query, (formatted_from_timestamp, formatted_to_timestamp))
                    sobs_lost_of_control_data = cursor.fetchall()

                    for ts in sobs_lost_of_control_data:
                        ts['Timestamp'] = ts['Timestamp'].strftime("%d.%m.%Y, %H:%M:%S")

                response = jsonify({'sobsLostOfControlData': sobs_lost_of_control_data})
                return response
            except Exception as e:
                print(f"Error fetching sobsLostOfControlData data: {e}")
                return jsonify({'error': 'An error occurred'}), 500
    finally:
        db_info_package.close()
#================================================================== Interval Analiz (IntervalAnalysis.tsx page) =====================================================================

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#============================================================================= Qeyd (Note.tsx page) =================================================================================
@app.route('/store_note', methods=['POST'])
@jwt_required()
def store_note():
    db_note = user_note_db_pool.get_connection()

    try:
        data = request.json
        sahe = data.get('sahe')
        user_full_name = data.get('userFullName')
        note = data.get('note')

        query = "INSERT INTO yd_note_workers (Sahe, FullName, Note, timestamp) VALUES (%s, %s, %s, NOW())"
        with db_note.cursor() as cursor:
            cursor.execute(query, (sahe, user_full_name, note))
        db_note.commit()

        response = jsonify({'message': 'Note stored successfully'})
        return response
    finally:
        db_note.close()

@app.route('/get_notes', methods=['GET'])
@jwt_required()
def get_notes():
    db_note = user_note_db_pool.get_connection()
    db_user = user_db_pool.get_connection()

    try:
        query_notes = """
            SELECT Sahe, FullName, Note, timestamp
            FROM yd_note_workers
            ORDER BY timestamp DESC
        """
        with db_note.cursor(dictionary=True) as cursor:
            cursor.execute(query_notes)
            notes = cursor.fetchall()

        full_names = tuple(note['FullName'] for note in notes)
        if full_names:
            query_users = f"""
                SELECT fullName, Vezife
                FROM users
                WHERE fullName IN ({','.join(['%s'] * len(full_names))})
            """
            with db_user.cursor(dictionary=True) as cursor:
                cursor.execute(query_users, full_names)
                users = cursor.fetchall()
                user_dict = {user['fullName']: user['Vezife'] for user in users}
        else:
            user_dict = {}

        for note in notes:
            note['Vezife'] = user_dict.get(note['FullName'], None)

        response = jsonify({'notes': notes})
        return response
    finally:
        db_note.close()
        db_user.close()

#============================================================================= Qeyd (Note.tsx page) =================================================================================

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#======================================================================== IQ3Jurnal (IQ3Journal.tsx page) ===========================================================================

@app.route('/store_iq3journalPlan', methods=['POST'])
@jwt_required()
def store_iq3journalPlan():
    db_note = user_note_db_pool.get_connection()

    try:
        data = request.json
        sahe = data.get('sahe')
        user_full_name = data.get('userFullName')
        tex_pros_qrafik_bend = data.get('texProsQrafikBend')
        note = data.get('note')

        query = "INSERT INTO yd_iq3journal_plan (Sahe, FullName, TexProsQrafikBend, Note, timestamp) VALUES (%s, %s, %s, %s, NOW())"
        with db_note.cursor() as cursor:
            cursor.execute(query, (sahe, user_full_name, tex_pros_qrafik_bend, note))
        db_note.commit()

        response = jsonify({'message': 'Note stored successfully'})
        return response
    finally:
        db_note.close()

@app.route('/store_iq3journalHesabat', methods=['POST'])
@jwt_required()
def store_iq3journalHesabat():
    db_note = user_note_db_pool.get_connection()

    try:
        data = request.json
        sahe = data.get('sahe')
        user_full_name = data.get('userFullName')
        tex_pros_qrafik_bend = data.get('texProsQrafikBend')
        note = data.get('note')

        query = "INSERT INTO yd_iq3journal_hesabat (Sahe, FullName, TexProsQrafikBend, Note, timestamp) VALUES (%s, %s, %s, %s, NOW())"
        with db_note.cursor() as cursor:
            cursor.execute(query, (sahe, user_full_name, tex_pros_qrafik_bend, note))
        db_note.commit()

        response = jsonify({'message': 'Note stored successfully'})
        return response
    finally:
        db_note.close()



#======================================================================== IQ3Jurnal (IQ3Journal.tsx page) ===========================================================================

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if __name__ == '__main__':
    app.run(debug=True, threaded=True, host='0.0.0.0', port=5000)