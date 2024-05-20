import { useState, useEffect } from "react";
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
import { useNavigate } from "react-router-dom";
import DatePicker, { registerLocale } from "react-datepicker";
import { az } from "date-fns/locale/az";

import "react-datepicker/dist/react-datepicker.css";

const IntervalAnalysisPage = () => {
  registerLocale("az", az);
  const navigate = useNavigate();
  const [tableNumbers, setTableNumbers] = useState([]);
  const [selectedTable, setSelectedTable] = useState("");
  const [fromTimestamp, setFromTimestamp] = useState(new Date());
  const [toTimestamp, setToTimestamp] = useState(new Date());
  const [timestamps, setTimestamps] = useState([]);
  const [VofDeviceData, setVofDeviceData] = useState([]);
  const [temperatureData, setTemperatureData] = useState([]);
  const [BlockContactNData, setBlockContactNData] = useState([]); //Blok Kontaktın sayı
  const [BlockContactData, setBlockContactData] = useState([]); //Blok Kontakt
  const [conversionPeriodData, setConversionPeriodData] = useState([]);
  const [sobsLostOfControlData, setSobsLostOfControlData] = useState([]);
  const [numOfControlData, setNumOfControlData] = useState([]);
  const [combinedCurrentValuesData, setCombinedCurrentValues] = useState([]);
  const [combinedCurrentAccidentValuesData, setCombinedCurrentAccidentValues] =
    useState([]);
  const [uAllData, setUAllData] = useState([]);
  const [kurbelData, setKurbelData] = useState([]);
  const [showChart, setShowChart] = useState(false);
  const [tableChanged, setTableChanged] = useState(false);
  const access_token = localStorage.getItem("access_token");

  const handleTableChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
    setSelectedTable(event.target.value);
    setTableChanged(true);
  };

  const handleFetchDataClick = () => {
    if (selectedTable && fromTimestamp && toTimestamp) {
      const formattedFromTimestamp = new Date(fromTimestamp).toISOString();
      const formattedToTimestamp = new Date(toTimestamp).toISOString();

      const currentValuesUrl = `http://localhost:5000/current_values_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const currentAccidentValuesUrl = `http://localhost:5000/current_accident_values_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const uAllUrl = `http://localhost:5000/u_all_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const kurbelUrl = `http://localhost:5000/kurbel_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const VofDeviceUrl = `http://localhost:5000/v_of_device_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const temperatureUrl = `http://localhost:5000/temperature_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const BlockContactNUrl = `http://localhost:5000/block_contact_n_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const BlockContactUrl = `http://localhost:5000/block_contact_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const conversionPeriodUrl = `http://localhost:5000/conversion_period_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const numOfControlUrl = `http://localhost:5000/num_of_control_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      const sobsLostOfControlUrl = `http://localhost:5000/sobs_lost_of_control_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;

      //  Current Values 1-10----------------------------------------------------------------------------------------------------------------------------------
      fetch(currentValuesUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          const { currentValuesData } = data;
          const combinedCurrentValuesData = currentValuesData.map(
            (item: {
              Timestamp: any;
              CurrentValue1: any;
              CurrentValue2: any;
              CurrentValue3: any;
              CurrentValue4: any;
              CurrentValue5: any;
              CurrentValue6: any;
              CurrentValue7: any;
              CurrentValue8: any;
              CurrentValue9: any;
              CurrentValue10: any;
            }) => {
              return {
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
              };
            }
          );
          setCombinedCurrentValues(combinedCurrentValuesData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching Current Values data:", error);
          }
        });
      //  Current Values 1-10----------------------------------------------------------------------------------------------------------------------------------

      // U_AB, U_BC, U_AC ----------------------------------------------------------------------------------------------------------------------------------
      fetch(uAllUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          const { uAllData } = data;
          const combinedUAllData = uAllData.map(
            (item: { Timestamp: any; U_AB: any; U_BC: any; U_AC: any }) => {
              return {
                Timestamp: item.Timestamp,
                U_AB: item.U_AB,
                U_BC: item.U_BC,
                U_AC: item.U_AC,
              };
            }
          );
          setUAllData(combinedUAllData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching U Values data:", error);
          }
        });
      // U_AB, U_BC, U_AC ----------------------------------------------------------------------------------------------------------------------------------

      //Current Accident Values ----------------------------------------------------------------------------------------------------------------------------------
      fetch(currentAccidentValuesUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          const { currentAccidentValuesData } = data;
          const combinedCurrentAccidentValuesData =
            currentAccidentValuesData.map(
              (item: {
                Timestamp: any;
                Current_Accident_A: any;
                Current_Accident_B: any;
                Current_Accident_C: any;
              }) => {
                return {
                  Timestamp: item.Timestamp,
                  Current_Accident_A: item.Current_Accident_A,
                  Current_Accident_B: item.Current_Accident_B,
                  Current_Accident_C: item.Current_Accident_C,
                };
              }
            );
          setCombinedCurrentAccidentValues(combinedCurrentAccidentValuesData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error(
              "Error fetching Current Accident Values data:",
              error
            );
          }
        });
      //Current Accident Values ----------------------------------------------------------------------------------------------------------------------------------

      //V of Device ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(VofDeviceUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          setVofDeviceData(data.VofDeviceData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching V_of_Device data:", error);
          }
        });
      //V of Device ----------------------------------------------------------------------------------------------------------------------------------------------

      //Temperature ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(temperatureUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          setTemperatureData(data.temperatureData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching Temperature data:", error);
          }
        });
      //Temperature ----------------------------------------------------------------------------------------------------------------------------------------------

      //BlockContactN ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(BlockContactNUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log("Block Contact N Data:", data);
          setBlockContactNData(data.blockContactNData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching Block Contact N data:", error);
          }
        });
      //BlockContactN ----------------------------------------------------------------------------------------------------------------------------------------------

      //BlockContact ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(BlockContactUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log("Block Contact Data:", data);
          setBlockContactData(data.blockContactData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching Block Contact data:", error);
          }
        });
      //BlockContact ----------------------------------------------------------------------------------------------------------------------------------------------

      //ConversionPeriod ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(conversionPeriodUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log("ConversionPeriod Data:", data);
          setConversionPeriodData(data.conversionPeriodData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching ConversionPeriod data:", error);
          }
        });
      //ConversionPeriod ----------------------------------------------------------------------------------------------------------------------------------------------

      //NumOfControl ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(numOfControlUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log("NumOfControl Data:", data);
          setNumOfControlData(data.numOfControlData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching ConversionPeriod data:", error);
          }
        });
      //NumOfControl ----------------------------------------------------------------------------------------------------------------------------------------------

      //SobsLostOfControl ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(sobsLostOfControlUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log("SobsLostOfControl Data:", data);
          setSobsLostOfControlData(data.sobsLostOfControlData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching ConversionPeriod data:", error);
          }
        });
      //SobsLostOfControl ----------------------------------------------------------------------------------------------------------------------------------------------

      //Kurbel ----------------------------------------------------------------------------------------------------------------------------------------------
      fetch(kurbelUrl, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log("Kurbel Data:", data);
          setKurbelData(data.kurbelData);
          setShowChart(true);
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching Kurbel data:", error);
          }
        });
      //Kurbel ----------------------------------------------------------------------------------------------------------------------------------------------
    }
  };

  useEffect(() => {
    fetch("http://localhost:5000/table_numbers", {
      headers: { Authorization: `Bearer ${access_token}` },
    })
      .then((response) => response.json())
      .then((data) => setTableNumbers(data.table_numbers))
      .catch((error) => console.error("Error fetching table numbers:", error));
  }, []);

  useEffect(() => {
    if (selectedTable) {
      setShowChart(false);
      setFromTimestamp(new Date());
      setToTimestamp(new Date());
      setTableChanged(false);

      fetch(`http://localhost:5000/timestamps/${selectedTable}`, {
        headers: { Authorization: `Bearer ${access_token}` },
      })
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          if (data.timestamps) {
            setTimestamps(data.timestamps);
          } else {
            setTimestamps([]);
          }
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching timestamps:", error);
            setTimestamps([]);
          }
        });
    }
  }, [selectedTable, tableChanged]);

  return (
    <div className="w-full ml-10 mr-10 mt-3 ">
      <div className="mt-5 overflow-x-auto">
        <div className="bg-white rounded-lg shadow-md p-6 flex items-center justify-between mt-4">
          <div className="flex items-center">
            <label className="ml-7 mr-2 text-xl font-semibold">
              YD-nın nömrəsi:
            </label>
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
            <DatePicker
              onChange={(date) => setFromTimestamp(date ? date : new Date())}
              selected={fromTimestamp}
              showTimeSelect
              timeIntervals={1}
              timeFormat="p"
              dateFormat="dd.MM.yyyy HH:mm"
              locale="az"
            />

            {/* <select
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
            </select> */}

            <label className=" ml-2 mr-2 text-xl font-semibold">
              <AiOutlineMinus />
            </label>

            <DatePicker
              onChange={(date) => setToTimestamp(date ? date : new Date())}
              selected={toTimestamp}
              showTimeSelect
              timeIntervals={1}
              timeFormat="p"
              dateFormat="dd.MM.yyyy HH:mm"
              locale="az"
            />

            {/* <select
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
            </select> */}
          </div>

          <div className=" flex mr-4">
            <TesdiqButton onClick={handleFetchDataClick}>Təsdiqlə</TesdiqButton>
          </div>
        </div>

        <div className="w-full">
          <div className="p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
            {showChart && VofDeviceData && VofDeviceData.length > 0 && (
              <LineChart width={1450} height={400} data={VofDeviceData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 20]} />
                <Tooltip />
                <Legend />
                <Line
                  type="monotone"
                  dataKey="V_of_Device"
                  stroke="#8884d8"
                  name="DC Qida Gərginliyi"
                />
              </LineChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 overflow-x-auto">
            {showChart && temperatureData && temperatureData.length > 0 && (
              <LineChart width={1450} height={400} data={temperatureData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 100]} />
                <Tooltip />
                <Legend />
                <Line
                  type="monotone"
                  dataKey="Temperature"
                  stroke="#82ca9d"
                  name="DC Daxili Temperaturu"
                />
              </LineChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 overflow-x-auto">
            {showChart &&
              combinedCurrentValuesData &&
              combinedCurrentValuesData.length > 0 && (
                <LineChart
                  width={1450}
                  height={400}
                  data={combinedCurrentValuesData}
                >
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="Timestamp" />
                  <YAxis domain={[2, 3]} />
                  <Tooltip />
                  <Legend />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue1"
                    stroke="#0a2205"
                    name="Faza Cərəyanı 1"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue2"
                    stroke="#1f4220"
                    name="Faza Cərəyanı 2"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue3"
                    stroke="#2b5a1d"
                    name="Faza Cərəyanı 3"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue4"
                    stroke="#437a37"
                    name="Faza Cərəyanı 4"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue5"
                    stroke="#56bf52"
                    name="Faza Cərəyanı 5"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue6"
                    stroke="#470000"
                    name="Faza Cərəyanı 6"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue7"
                    stroke="#5752D1"
                    name="Faza Cərəyanı 7"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue8"
                    stroke="#C9190B"
                    name="Faza Cərəyanı 8"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue9"
                    stroke="#ffa500"
                    name="Faza Cərəyanı 9"
                  />
                  <Line
                    type="monotone"
                    dataKey="CurrentValue10"
                    stroke="#008080"
                    name="Faza Cərəyanı 10"
                  />
                </LineChart>
              )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 overflow-x-auto">
            {showChart &&
              combinedCurrentAccidentValuesData &&
              combinedCurrentAccidentValuesData.length > 0 && (
                <LineChart
                  width={1450}
                  height={400}
                  data={combinedCurrentAccidentValuesData}
                >
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="Timestamp" />
                  <YAxis domain={[1, 5]} />
                  <Tooltip />
                  <Legend />
                  <Line
                    type="monotone"
                    dataKey="Current_Accident_A"
                    stroke="#e74c3c"
                    name="Qəza Faza Cərəyanı A"
                  />
                  <Line
                    type="monotone"
                    dataKey="Current_Accident_B"
                    stroke="#78281f"
                    name="Qəza Faza Cərəyanı B"
                  />
                  <Line
                    type="monotone"
                    dataKey="Current_Accident_C"
                    stroke="#b71c1c "
                    name="Qəza Faza Cərəyanı C"
                  />
                </LineChart>
              )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 overflow-x-auto">
            {showChart && uAllData && uAllData.length > 0 && (
              <LineChart width={1450} height={400} data={uAllData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[1, 200]} />
                <Tooltip />
                <Legend />
                <Line
                  type="monotone"
                  dataKey="U_AB"
                  stroke="#f1c40f"
                  name="AB Faza Gərginliyi"
                />
                <Line
                  type="monotone"
                  dataKey="U_BC"
                  stroke="#1d8348"
                  name="BC Faza Gərginliyi"
                />
                <Line
                  type="monotone"
                  dataKey="U_AC"
                  stroke="#b71c1c"
                  name="AC Faza Gərginliyi"
                />
              </LineChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 ">
            {showChart && numOfControlData && numOfControlData.length > 0 && (
              <BarChart width={1450} height={400} data={numOfControlData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 10]} />
                <Tooltip />
                <Legend />
                <Bar
                  dataKey="NumOfControl"
                  fill="#b03a2e"
                  name="Nəzarətin itmə sayı"
                />
              </BarChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 ">
            {showChart &&
              sobsLostOfControlData &&
              sobsLostOfControlData.length > 0 && (
                <BarChart
                  width={1450}
                  height={400}
                  data={sobsLostOfControlData}
                >
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="Timestamp" />
                  <YAxis domain={[0, 10]} />
                  <Tooltip />
                  <Legend />
                  <Bar
                    dataKey="SOBS_Lost_Of_Control"
                    fill="#e74c3c "
                    name="Nəzarətə gələn gərginliyin itmə sayı"
                  />
                </BarChart>
              )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 ">
            {showChart && BlockContactNData && BlockContactNData.length > 0 && (
              <BarChart width={1450} height={400} data={BlockContactNData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 10]} />
                <Tooltip />
                <Legend />
                <Bar
                  dataKey="Block_Contact_N"
                  fill="#8884d8"
                  name="Blok kontaktın çevrilmə sayı"
                />
              </BarChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 ">
            {showChart && BlockContactData && BlockContactData.length > 0 && (
              <BarChart width={1450} height={400} data={BlockContactData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 2]} />
                <Tooltip
                  formatter={(value) => (value === 1 ? "Açıq" : "Bağlı")}
                />
                <Legend />
                <Bar
                  dataKey="BlokKontakt"
                  fill="#21618c"
                  name="Blok kontaktın Vəziyyəti"
                />
              </BarChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 ">
            {showChart &&
              conversionPeriodData &&
              conversionPeriodData.length > 0 && (
                <BarChart width={1450} height={400} data={conversionPeriodData}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="Timestamp" />
                  <YAxis domain={[0, 10]} />
                  <Tooltip />
                  <Legend />
                  <Bar
                    dataKey="Conversion_Period"
                    fill="#af601a"
                    name="YD-nın çevrilmə müddəti"
                  />
                </BarChart>
              )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 ">
            {showChart && kurbelData && kurbelData.length > 0 && (
              <BarChart width={1450} height={400} data={kurbelData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 5]} />
                <Tooltip />
                <Legend />
                <Bar
                  dataKey="Kurbel"
                  fill="#1d8348 "
                  name="Kurbel ilə çevrilmə sayı"
                />
              </BarChart>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default IntervalAnalysisPage;
