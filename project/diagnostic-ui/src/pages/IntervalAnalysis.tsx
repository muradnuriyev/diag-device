import { useState, useEffect } from 'react';
import { AiOutlineMinus } from 'react-icons/ai';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, BarChart, Bar  } from 'recharts';
import TesdiqButton from '../layouts/AuthLayout/components/TesdiqButton';

const IntervalAnalysisPage = () => {
  const [tableNumbers, setTableNumbers] = useState([]);
  const [selectedTable, setSelectedTable] = useState('');
  const [fromTimestamp, setFromTimestamp] = useState('');
  const [toTimestamp, setToTimestamp] = useState('');
  const [timestamps, setTimestamps] = useState([]);
  const [VofDeviceData, setVofDeviceData] = useState([]);
  const [temperatureData, setTemperatureData] = useState([]);
  const [vOfDevice, setvOfDevice] = useState([]);
  const [BlockContactNData, setBlockContactNData] = useState([]);
  const [numberOfChangeData, setNumberOfChangeData] = useState([]);
  const [showChart, setShowChart] = useState(false);
  const [tableChanged, setTableChanged] = useState(false);

  const handleTableChange = (event: React.ChangeEvent<HTMLSelectElement>) => {
    setSelectedTable(event.target.value);
    setTableChanged(true);
  };

  const formatDate = (timestamp: string) => {
    const date = new Date(timestamp);
    const options: Intl.DateTimeFormatOptions = {
      year: "numeric",
      month: "2-digit",
      day: "2-digit",
      hour: "2-digit",
      minute: "2-digit",
      second: "2-digit",
      hour12: false,
      timeZone: "UTC",
    };

    const formattedDate = date.toLocaleString("en-GB", options);

    return formattedDate.replace(/,/, '');
  };

  const handleFetchDataClick = () => {
    if (selectedTable && fromTimestamp && toTimestamp) {
      const formattedFromTimestamp = new Date(fromTimestamp).toISOString();
      const formattedToTimestamp = new Date(toTimestamp).toISOString();
      
      const VofDeviceUrl = `http://localhost:5000/v_of_device_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      fetch(VofDeviceUrl)
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          setVofDeviceData(data.VofDeviceData);
          setShowChart(true);
        })
        .catch((error) => console.error('Error fetching V_of_Device data:', error));
      
      const temperatureUrl = `http://localhost:5000/temperature_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
      fetch(temperatureUrl)
        .then((response) => response.json())
        .then((data) => {
          console.log(data);
          setTemperatureData(data.temperatureData);
          setShowChart(true);
        })
        .catch((error) => console.error('Error fetching Temperature data:', error));

        const voltageUrl = `http://localhost:5000/voltage_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
        fetch(voltageUrl)
          .then((response) => response.json())
          .then((data) => {
            console.log(data);
            setvOfDevice(data.vOfDevice);
            setShowChart(true);
          })
          .catch((error) => console.error('Error fetching Voltage data:', error));

        const BlockContactNUrl = `http://localhost:5000/block_contact_n_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
        fetch(BlockContactNUrl)
          .then((response) => response.json())
          .then((data) => {
            console.log('Block Contact N Data:', data);
            setBlockContactNData(data.blockContactNData);
            setShowChart(true);
          })
          .catch((error) => console.error('Error fetching Block Contact N data:', error));
        
        const numberOfChangeUrl = `http://localhost:5000/number_of_change_data/yd_${selectedTable}/${formattedFromTimestamp}/${formattedToTimestamp}`;
        fetch(numberOfChangeUrl)
          .then((response) => response.json())
          .then((data) => {
            console.log('NumberOfChange Data:', data);
            setNumberOfChangeData(data.numberOfChangeData);
            setShowChart(true);
          })
          .catch((error) => console.error('Error fetching NumberOfChange data:', error));
    }
  };
  

  useEffect(() => {
    fetch('http://localhost:5000/table_numbers')
      .then(response => response.json())
      .then(data => setTableNumbers(data.table_numbers))
      .catch(error => console.error('Error fetching table numbers:', error));
  }, []);

useEffect(() => {
  if (selectedTable) {
    setShowChart(false);
    setFromTimestamp('');
    setToTimestamp('');
    setTableChanged(false);

    fetch(`http://localhost:5000/timestamps/${selectedTable}`)
      .then(response => response.json())
      .then(data => {
        console.log(data);
        if (data.timestamps) {
          setTimestamps(data.timestamps);
        } else {
          setTimestamps([]);
        }
      })
      .catch(error => {
        console.error('Error fetching timestamps:', error);
        setTimestamps([]);
      });
  }
}, [selectedTable, tableChanged]);


  return (
    <div className="w-full ml-10 mr-10 mt-3 ">
      <div className="mt-5 overflow-x-auto">
        <div className="bg-white rounded-lg shadow-md p-6 flex items-center justify-between mt-4">
          <div className="flex items-center">
            <label className="ml-7 mr-2 text-xl font-semibold">YD-nın nömrəsi:</label>
            <select
              value={selectedTable}
              onChange={handleTableChange}
              className='px-4 py-2 border border-main-blue rounded-lg'>
              <option value="">YD</option>
              {tableNumbers.map(number => (
                <option key={number} value={number}>
                  {number}
                </option>
              ))}
            </select>

            <label className="ml-7 mr-2 text-xl font-semibold">Tarix:</label>
            <select
              value={fromTimestamp}
              onChange={event => setFromTimestamp(event.target.value)}
              className="px-4 py-2 border border-main-blue rounded-lg"
            >
              <option value=""></option>
              {timestamps.map(timestamp => (
                <option key={timestamp} value={timestamp}>
                  {timestamp}
                </option>
              ))}
            </select>
            
            <label className=" ml-2 mr-2 text-xl font-semibold"><AiOutlineMinus/></label>
            <select
              value={toTimestamp}
              onChange={event => setToTimestamp(event.target.value)}
              className="px-4 py-2 border border-main-blue rounded-lg"
            >
              <option value=""></option>
              {timestamps.map(timestamp => (
                <option key={timestamp} value={timestamp}>
                  {timestamp}
                </option>
              ))}
            </select>
          </div>

          <div className=" flex mr-4">
            <TesdiqButton onClick={handleFetchDataClick}>Təsdiqlə</TesdiqButton>
          </div>
        </div>

        <div className='w-full'>
          <div className="p-6 bg-white rounded-lg shadow-md mt-4 overflow-x-auto">
            {showChart && VofDeviceData && VofDeviceData.length > 0 && (
              <LineChart width={1450} height={400} data={VofDeviceData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 20]} />
                <Tooltip />
                <Legend />
                <Line type="monotone" dataKey="V_of_Device" stroke="#8884d8" name="Qida gərginliyi"/>
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
                <Line type="monotone" dataKey="Temperature" stroke="#82ca9d" name="Temperatur" />
              </LineChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 overflow-x-auto">
            {showChart && vOfDevice && vOfDevice.length > 0 && (
              <LineChart width={1450} height={400} data={vOfDevice}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis domain={[0, 150]} />
                <Tooltip />
                <Legend />
                <Line type="monotone" dataKey="Voltage" stroke="#000000" name="YD-nın gərginliyi" />
              </LineChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4 ">
            {showChart && BlockContactNData && BlockContactNData.length > 0 && (
              <BarChart width={1450} height={400} data={BlockContactNData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="TimeStamp" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar dataKey="Block_Contact_N" fill="#8884d8" name="Blok kontaktın çevrilmə sayı" />
              </BarChart>
            )}
          </div>
        </div>

        <div>
          <div className="w-full p-6 bg-white rounded-lg shadow-md items-center mt-4 overflow-x-auto">
            {showChart && numberOfChangeData && numberOfChangeData.length > 0 && (
              <BarChart width={1450} height={400} data={numberOfChangeData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="Timestamp" />
                <YAxis />
                <Tooltip />
                <Legend />
                <Bar dataKey="NumberOfChange" fill="#82ca9d" name="YD-nın çevrilmə sayı" />
              </BarChart>
            )}
          </div>
        </div>

      </div>
    </div>
  );
};

export default IntervalAnalysisPage;

