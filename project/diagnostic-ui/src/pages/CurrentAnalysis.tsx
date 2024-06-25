import React, { useState, useEffect } from "react";
import TesdiqButton from "../layouts/AuthLayout/components/TesdiqButton";
import { useNavigate } from "react-router-dom";

interface TableData {
  [key: string]: React.ReactNode;
}

const CurrentAnalysis = () => {
  const columnNames = [
    "Məlumat qəbulu",
    "Gərginlik Faza AB",
    "Nəzarət",
    "Gərginlik Faza BC",
    "Nəzarətin itmə sayı",
    "Gərginlik Faza AC",
    "YD-nın çevrilmə sayı",
    "Qəza cərəyanı Faza A",
    "Kurbel ilə",
    "Qəza cərəyanı Faza B",
    "Nəzarətə gələn gərginlik",
    "Qəza cərəyanı Faza C",
    "Nəzarətə gələn gərginliyin itmə sayı",
    "Cihazın qida gərginliyi",
    "Temperatur",
    "YD-nın çevrilmə müddəti",
    "Blok-Kontakt",
    "YD-nın çevrilmə cərəyanı",
    "Blok-Kontakt sayı",
    "Vaxt",
  ];

  const navigate = useNavigate();
  const [tableNumbers, setTableNumbers] = useState<string[]>([]);
  const [selectedTableNumber, setSelectedTableNumber] = useState<string>(
    localStorage.getItem("selectedTableNumber") || ""
  );
  const [tableData, setTableData] = useState<TableData>(
    JSON.parse(localStorage.getItem("tableData") || "{}")
  );
  const access_token = localStorage.getItem("access_token");

  useEffect(() => {
    fetch("http://localhost:5000/table_numbers", {
      headers: { Authorization: `Bearer ${access_token}` },
    })
      .then((response) => response.json())
      .then((data) => {
        setTableNumbers(data.table_numbers);
      })
      .catch((error) => {
        if (error?.response?.data?.msg === "Token has expired") {
          navigate("/auth/logout");
        } else {
          console.error("Error fetching table numbers:", error);
        }
      });
  }, []);

  const formatDate = (timestamp: string) => {
    // const date = new Date(timestamp);
    // const options: Intl.DateTimeFormatOptions = {
    //   year: "numeric",
    //   month: "2-digit",
    //   day: "2-digit",
    //   hour: "2-digit",
    //   minute: "2-digit",
    //   second: "2-digit",
    //   hour12: false,
    //   timeZone: "UTC",
    // };

    //const formattedDate = date.toLocaleString("en-GB", options);

    return timestamp.replace(/,/, "");
  };

  const handleButtonClick = () => {
    if (selectedTableNumber) {
      const selectedTableName = `yd_${selectedTableNumber}`;
      fetch("http://localhost:5000/table_data", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${access_token}`,
        },
        body: JSON.stringify({ table: selectedTableName }),
      })
        .then((response) => {
          if (!response.ok) {
            throw new Error("Network response was not ok");
          }
          return response.json();
        })
        .then((data) => {
          setTableData(data);
          localStorage.setItem("tableData", JSON.stringify(data));
          localStorage.setItem("selectedTableNumber", selectedTableNumber);
          fetch("http://localhost:5000/alarms", {
            headers: { Authorization: `Bearer ${access_token}` },
          })
            .then((response) => response.json())
            .catch((error) => {
              if (error?.response?.data?.msg === "Token has expired") {
                navigate("/auth/logout");
              } else {
                console.error("Error fetching alarms:", error);
              }
            });
        })
        .catch((error) => {
          if (error?.response?.data?.msg === "Token has expired") {
            navigate("/auth/logout");
          } else {
            console.error("Error fetching table data:", error);
          }
        });
    }
  };

  const handleResetClick = () => {
    setSelectedTableNumber("");
    setTableData({});
    localStorage.removeItem("tableData");
    localStorage.removeItem("selectedTableNumber");
  };

  return (
    <div className="w-full ml-10 mr-10">
      <div className="bg-white rounded-lg shadow-md p-6 flex items-center justify-between mt-4">
        <div className="flex items-center">
          <label className="mr-8 text-xl font-semibold">YD-nın nömrəsi:</label>
          <select
            value={selectedTableNumber}
            onChange={(e) => setSelectedTableNumber(e.target.value)}
            className="px-4 py-2 border border-main-blue rounded-lg"
          >
            <option value="">YD-nı seçin</option>
            {tableNumbers.map((num: string) => (
              <option key={num} value={num}>
                {num}
              </option>
            ))}
          </select>
        </div>
        <div className="flex">
          <div className="mr-4">
            <TesdiqButton onClick={handleResetClick}>Sıfırla</TesdiqButton>
          </div>
          <div className="mr-4">
            <TesdiqButton
              onClick={handleButtonClick}
              disabled={!selectedTableNumber}
            >
              Təsdiqlə
            </TesdiqButton>
          </div>
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-md p-6 grid grid-cols-2 gap-4 mt-4">
        {columnNames.map((name) => (
          <div key={name} className="flex justify-between">
            <div className="w-1/2 pr-2">
              <p className="font-semibold text-xl text-gray-800">{name}</p>
            </div>
            <div className="w-1/2 pl-2">
              <div className="bg-main rounded p-2">
                <table className="w-full">
                  <tbody>
                    <tr className="flex justify-between">
                      <td className="font-semibold pl-2 pr-2">Qiymət: </td>
                      <td className="pr-2">
                        {name === "Vaxt"
                          ? formatDate(tableData[name] as string)
                          : tableData[name]}
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CurrentAnalysis;
