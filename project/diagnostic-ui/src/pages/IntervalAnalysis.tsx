import { useEffect, useState } from "react";
import { AiOutlineMinus } from "react-icons/ai";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  BarChart,
  Bar,
} from "recharts";
import TesdiqButton from "../layouts/AuthLayout/components/TesdiqButton";
import { API_BASE_URL } from "../config";

interface CurrentValuesItem {
  Timestamp: string;
  CurrentValue1: number;
  CurrentValue2: number;
  CurrentValue3: number;
  CurrentValue4: number;
  CurrentValue5: number;
  CurrentValue6: number;
  CurrentValue7: number;
  CurrentValue8: number;
  CurrentValue9: number;
  CurrentValue10: number;
}

interface UAllItem {
  Timestamp: string;
  U_AB: number;
  U_BC: number;
  U_AC: number;
}

interface CurrentAccidentValuesItem {
  Timestamp: string;
  Current_Accident_A: number;
  Current_Accident_B: number;
  Current_Accident_C: number;
}

const IntervalAnalysisPage = () => {
  const [tableNumbers, setTableNumbers] = useState<string[]>([]);
  const [selectedTable, setSelectedTable] = useState("");
  const [fromTimestamp, setFromTimestamp] = useState("");
  const [toTimestamp, setToTimestamp] = useState("");
  const [timestamps, setTimestamps] = useState<string[]>([]);

  const [vOfDeviceData, setVOfDeviceData] = useState<any[]>([]);
  const [temperatureData, setTemperatureData] = useState<any[]>([]);
  const [combinedCurrentValuesData, setCombinedCurrentValues] = useState<CurrentValuesItem[]>([]);
  const [combinedCurrentAccidentValuesData, setCombinedCurrentAccidentValues] =
    useState<CurrentAccidentValuesItem[]>([]);
  const [uAllData, setUAllData] = useState<UAllItem[]>([]);
  const [blockContactNData, setBlockContactNData] = useState<any[]>([]);
  const [blockContactData, setBlockContactData] = useState<any[]>([]);
  const [conversionPeriodData, setConversionPeriodData] = useState<any[]>([]);
  const [numOfControlData, setNumOfControlData] = useState<any[]>([]);
  const [sobsLostOfControlData, setSobsLostOfControlData] = useState<any[]>([]);
  const [kurbelData, setKurbelData] = useState<any[]>([]);

  const [showChart, setShowChart] = useState(false);
  const [tableChanged, setTableChanged] = useState(false);

  const handleTableChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
    setSelectedTable(event.target.value);
    setTableChanged(true);
  };

  const handleFetchDataClick = () => {
    if (!selectedTable || !fromTimestamp || !toTimestamp) {
      return;
    }

    const formattedFromTimestamp = new Date(fromTimestamp).toISOString();
    const formattedToTimestamp = new Date(toTimestamp).toISOString();

    const currentValuesUrl = `${API_BASE_URL}/current_values_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const currentAccidentValuesUrl = `${API_BASE_URL}/current_accident_values_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const uAllUrl = `${API_BASE_URL}/u_all_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const kurbelUrl = `${API_BASE_URL}/kurbel_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const vOfDeviceUrl = `${API_BASE_URL}/v_of_device_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const temperatureUrl = `${API_BASE_URL}/temperature_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const blockContactNUrl = `${API_BASE_URL}/block_contact_n_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const blockContactUrl = `${API_BASE_URL}/block_contact_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const conversionPeriodUrl = `${API_BASE_URL}/conversion_period_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const numOfControlUrl = `${API_BASE_URL}/num_of_control_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
    const sobsLostOfControlUrl = `${API_BASE_URL}/sobs_lost_of_control_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;

    // Current values 1-10
    fetch(currentValuesUrl)
      .then((response) => response.json())
      .then((data) => {
        const { currentValuesData } = data as { currentValuesData: CurrentValuesItem[] };
        const combined = currentValuesData.map((item) => ({
          Timestamp: item.Timestamp,
          CurrentValue1: item.CurrentValue1,
          CurrentValue2: item.CurrentValue2,
          CurrentValue3: item.CurrentValue3,
          CurrentValue4: item.CurrentValue4,
          CurrentValue5: item.CurrentValue5,
          CurrentValue6: item.CurrentValue6,
          CurrentValue7: item.CurrentValue7,
          CurrentValue8: item.CurrentValue8,
          CurrentValue9: item.CurrentValue9,
          CurrentValue10: item.CurrentValue10,
        }));
        setCombinedCurrentValues(combined);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching Current Values data:", error));

    // U_AB, U_BC, U_AC
    fetch(uAllUrl)
      .then((response) => response.json())
      .then((data) => {
        const { uAllData: raw } = data as { uAllData: UAllItem[] };
        const combined = raw.map((item) => ({
          Timestamp: item.Timestamp,
          U_AB: item.U_AB,
          U_BC: item.U_BC,
          U_AC: item.U_AC,
        }));
        setUAllData(combined);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching U values data:", error));

    // Current accident values
    fetch(currentAccidentValuesUrl)
      .then((response) => response.json())
      .then((data) => {
        const { currentAccidentValuesData } = data as {
          currentAccidentValuesData: CurrentAccidentValuesItem[];
        };
        const combined = currentAccidentValuesData.map((item) => ({
          Timestamp: item.Timestamp,
          Current_Accident_A: item.Current_Accident_A,
          Current_Accident_B: item.Current_Accident_B,
          Current_Accident_C: item.Current_Accident_C,
        }));
        setCombinedCurrentAccidentValues(combined);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching Current Accident Values data:", error));

    // V of device
    fetch(vOfDeviceUrl)
      .then((response) => response.json())
      .then((data) => {
        setVOfDeviceData(data.VofDeviceData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching V_of_Device data:", error));

    // Temperature
    fetch(temperatureUrl)
      .then((response) => response.json())
      .then((data) => {
        setTemperatureData(data.temperatureData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching Temperature data:", error));

    // Block contact N
    fetch(blockContactNUrl)
      .then((response) => response.json())
      .then((data) => {
        setBlockContactNData(data.blockContactNData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching Block_Contact_N data:", error));

    // Block contact
    fetch(blockContactUrl)
      .then((response) => response.json())
      .then((data) => {
        setBlockContactData(data.blockContactData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching BlockContact data:", error));

    // Conversion period
    fetch(conversionPeriodUrl)
      .then((response) => response.json())
      .then((data) => {
        setConversionPeriodData(data.conversionPeriodData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching Conversion_Period data:", error));

    // Num of control
    fetch(numOfControlUrl)
      .then((response) => response.json())
      .then((data) => {
        setNumOfControlData(data.numOfControlData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching NumOfControl data:", error));

    // SOBS Lost Of Control
    fetch(sobsLostOfControlUrl)
      .then((response) => response.json())
      .then((data) => {
        setSobsLostOfControlData(data.sobsLostOfControlData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching SOBS_Lost_Of_Control data:", error));

    // Kurbel
    fetch(kurbelUrl)
      .then((response) => response.json())
      .then((data) => {
        setKurbelData(data.kurbelData ?? []);
        setShowChart(true);
      })
      .catch((error) => console.error("Error fetching Kurbel data:", error));
  };

  useEffect(() => {
    fetch(`${API_BASE_URL}/table_numbers`)
      .then((response) => response.json())
      .then((data) => setTableNumbers(data.table_numbers ?? []))
      .catch((error) => console.error("Error fetching table numbers:", error));
  }, []);

  useEffect(() => {
    if (!selectedTable || !tableChanged) {
      return;
    }

    fetch(`${API_BASE_URL}/timestamps/${selectedTable}`)
      .then((response) => response.json())
      .then((data) => {
        if (data.timestamps) {
          setTimestamps(data.timestamps);
        } else {
          setTimestamps([]);
        }
      })
      .catch((error) => {
        console.error("Error fetching timestamps:", error);
        setTimestamps([]);
      });
  }, [selectedTable, tableChanged]);

  return (
    <div className="w-full ml-10 mr-10 mt-3">
      <div className="mt-5 overflow-x-auto">
        <div className="bg-white rounded-lg shadow-md p-6 flex items-center justify-between mt-4">
          <div className="flex items-center">
            <label className="ml-7 mr-2 text-xl font-semibold">YD-nin nömrəsi:</label>
            <select
              value={selectedTable}
              onChange={handleTableChange}
              className="px-4 py-2 border border-main-blue rounded-lg"
            >
              <option value="">YD</option>
              {tableNumbers.map((number) => (
                <option key={number} value={number}>
                  {number}
                </option>
              ))}
            </select>

            <label className="ml-7 mr-2 text-xl font-semibold">Tarix:</label>
            <select
              value={fromTimestamp}
              onChange={(event) => setFromTimestamp(event.target.value)}
              className="px-4 py-2 border border-main-blue rounded-lg"
            >
              <option value=""></option>
              {timestamps.map((timestamp) => (
                <option key={timestamp} value={timestamp}>
                  {timestamp}
                </option>
              ))}
            </select>

            <label className="ml-2 mr-2 text-xl font-semibold">
              <AiOutlineMinus />
            </label>
            <select
              value={toTimestamp}
              onChange={(event) => setToTimestamp(event.target.value)}
              className="px-4 py-2 border border-main-blue rounded-lg"
            >
              <option value=""></option>
              {timestamps.map((timestamp) => (
                <option key={timestamp} value={timestamp}>
                  {timestamp}
                </option>
              ))}
            </select>
          </div>

          <div className="flex mr-4">
            <TesdiqButton onClick={handleFetchDataClick}>Təsdiqlə</TesdiqButton>
          </div>
        </div>

        {/* V_of_Device */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && vOfDeviceData && vOfDeviceData.length > 0 && (
            <LineChart width={1450} height={400} data={vOfDeviceData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 20]} />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="V_of_Device" stroke="#8884d8" name="DC supply voltage" />
            </LineChart>
          )}
        </div>

        {/* Temperature */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && temperatureData && temperatureData.length > 0 && (
            <LineChart width={1450} height={400} data={temperatureData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 100]} />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="Temperature" stroke="#82ca9d" name="DC internal temperature" />
            </LineChart>
          )}
        </div>

        {/* Currents 1-10 */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && combinedCurrentValuesData && combinedCurrentValuesData.length > 0 && (
            <LineChart width={1450} height={400} data={combinedCurrentValuesData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[2, 3]} />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="CurrentValue1" stroke="#0a2205" name="Phase current 1" />
              <Line type="monotone" dataKey="CurrentValue2" stroke="#1f4220" name="Phase current 2" />
              <Line type="monotone" dataKey="CurrentValue3" stroke="#2b5a1d" name="Phase current 3" />
              <Line type="monotone" dataKey="CurrentValue4" stroke="#437a37" name="Phase current 4" />
              <Line type="monotone" dataKey="CurrentValue5" stroke="#56bf52" name="Phase current 5" />
              <Line type="monotone" dataKey="CurrentValue6" stroke="#470000" name="Phase current 6" />
              <Line type="monotone" dataKey="CurrentValue7" stroke="#5752D1" name="Phase current 7" />
              <Line type="monotone" dataKey="CurrentValue8" stroke="#C9190B" name="Phase current 8" />
              <Line type="monotone" dataKey="CurrentValue9" stroke="#ffa500" name="Phase current 9" />
              <Line type="monotone" dataKey="CurrentValue10" stroke="#008080" name="Phase current 10" />
            </LineChart>
          )}
        </div>

        {/* Fault currents */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && combinedCurrentAccidentValuesData && combinedCurrentAccidentValuesData.length > 0 && (
            <LineChart width={1450} height={400} data={combinedCurrentAccidentValuesData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[1, 5]} />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="Current_Accident_A" stroke="#e74c3c" name="Fault current A" />
              <Line type="monotone" dataKey="Current_Accident_B" stroke="#78281f" name="Fault current B" />
              <Line type="monotone" dataKey="Current_Accident_C" stroke="#1b4f72" name="Fault current C" />
            </LineChart>
          )}
        </div>

        {/* U_AB, U_BC, U_AC */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && uAllData && uAllData.length > 0 && (
            <LineChart width={1450} height={400} data={uAllData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="U_AB" stroke="#2980b9" name="U_AB" />
              <Line type="monotone" dataKey="U_BC" stroke="#27ae60" name="U_BC" />
              <Line type="monotone" dataKey="U_AC" stroke="#8e44ad" name="U_AC" />
            </LineChart>
          )}
        </div>

        {/* Block contact N */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && blockContactNData && blockContactNData.length > 0 && (
            <BarChart width={1450} height={400} data={blockContactNData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 10]} />
              <Tooltip />
              <Legend />
              <Bar dataKey="Block_Contact_N" fill="#8884d8" name="Block contact count" />
            </BarChart>
          )}
        </div>

        {/* Block contact state */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && blockContactData && blockContactData.length > 0 && (
            <BarChart width={1450} height={400} data={blockContactData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 2]} />
              <Tooltip />
              <Legend />
              <Bar dataKey="BlokKontakt" fill="#21618c" name="Block contact state" />
            </BarChart>
          )}
        </div>

        {/* Conversion period */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && conversionPeriodData && conversionPeriodData.length > 0 && (
            <BarChart width={1450} height={400} data={conversionPeriodData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 10]} />
              <Tooltip />
              <Legend />
              <Bar dataKey="Conversion_Period" fill="#af601a" name="Conversion period" />
            </BarChart>
          )}
        </div>

        {/* Num of control */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && numOfControlData && numOfControlData.length > 0 && (
            <BarChart width={1450} height={400} data={numOfControlData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 10]} />
              <Tooltip />
              <Legend />
              <Bar dataKey="NumOfControl" fill="#b03a2e" name="Control loss count" />
            </BarChart>
          )}
        </div>

        {/* SOBS lost of control */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && sobsLostOfControlData && sobsLostOfControlData.length > 0 && (
            <BarChart width={1450} height={400} data={sobsLostOfControlData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 10]} />
              <Tooltip />
              <Legend />
              <Bar dataKey="SOBS_Lost_Of_Control" fill="#e74c3c" name="SOBS lost-of-control count" />
            </BarChart>
          )}
        </div>

        {/* Kurbel */}
        <div className="w-full p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
          {showChart && kurbelData && kurbelData.length > 0 && (
            <BarChart width={1450} height={400} data={kurbelData}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="Timestamp" />
              <YAxis domain={[0, 5]} />
              <Tooltip />
              <Legend />
              <Bar dataKey="Kurbel" fill="#1d8348" name="Kurbel count" />
            </BarChart>
          )}
        </div>
      </div>
    </div>
  );
};

export default IntervalAnalysisPage;

