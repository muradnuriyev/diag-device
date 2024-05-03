import { useState, useEffect } from "react";
import { AiFillWarning } from "react-icons/ai";
import TesdiqButton from "../layouts/AuthLayout/components/TesdiqButton";

interface TableData {
  [key: string]: React.ReactNode;
}

const CurrentAnalysis = () => {

  const columnNames = [
    "Blok-kontakt",
    "Cihazın temperaturu",
    "YD-nin cərəyanının orta qıyməti",
    "YD-nin gərginliyi",
    "YD-nın nəzarəti",
    "YD-nın çevrilmə müddəti"
  ];
  const [tableNames, setTableNames] = useState([]);
  const [selectedTable, setSelectedTable] = useState<string>("");
  const [phaseMessage, setPhaseMessage] = useState<string | null>(null);
  const [tableData, setTableData] = useState<TableData>({});
  const [currentDifferenceMessage, setCurrentDifferenceMessage] = useState<string | null>(null);

  useEffect(() => {
    fetch('http://localhost:5000/table_names')
      .then((response) => response.json())
      .then((data) => {
        setTableNames(data.tables);
      })
      .catch((error) => {
        console.error('Error fetching table names:', error);
      });
  }, []);

  const handleButtonClick = () => {
    if (selectedTable) {
      fetch("http://localhost:5000/table_data", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ table: selectedTable }),
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Network response was not ok");
          }
          return response.json();
        })
        .then((data) => {
          setTableData(data);
          setPhaseMessage(data["Phase"] || null);
          setCurrentDifferenceMessage(data["Current_Difference"] || null);
        })
        .catch((error) => {
          console.error("Error fetching table data:", error);
        });
    }
  };

  return (
    <div className="w-full ml-10 mr-10 mt-3">
      <div className="mt-5">
        <div className=" bg-white rounded-lg shadow-md p-6 flex items-center justify-between mt-4">
          <div className="flex items-center">
            <p className="font-bold text-2xl pl-3 text-gray-800">YD-nın nömrəsi</p>
            <div className="ml-4">
              <select
                className="px-4 py-2 border border-main-blue rounded-lg"
                value={selectedTable}
                onChange={(e) => setSelectedTable(e.target.value)}
              >
                <option value="">YD-nı seçin</option>
                {tableNames.map((tableName) => (
                  <option key={tableName} value={tableName}>
                    {tableName}
                  </option>
                ))}
              </select>
              <div className="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                <svg
                  className="fill-current h-4 w-4"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20"
                >
                  <path
                    fillRule="evenodd"
                    d="M10 12l-5-5 1.5-1.5L10 9.02l3.5-3.5L15 7z"
                  />
                </svg>
              </div>
            </div>
          </div>
          <div className="mr-4">
            <TesdiqButton onClick={handleButtonClick} disabled={!selectedTable}>
              Təsdiqlə
            </TesdiqButton>
          </div>
        </div>
      </div>

      <div className="mt-5">
        <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center justify-between mt-4">
          <div>
            <table>
              <tbody>
                {columnNames.map((name) => (
                  <tr key={name}>
                    <td className="font-bold text-2xl p-4 text-gray-800">{name}</td>
                    <td className="p-4">
                      <div className="bg-main rounded text-black py-3 px-6 font-bold hover:bg-opacity-75 transition-colors ">
                        {tableData[name]}
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <div className="">
        <div className="w-full p-6 bg-white rounded-lg shadow-md flex items-center mt-4">
          <AiFillWarning className="text-red-500 text-8xl" />
          <div className="pl-10 text-xl text-gray-800">
            {phaseMessage} {currentDifferenceMessage}
          </div>
        </div>
      </div>
    </div>

  );
};

export default CurrentAnalysis;
