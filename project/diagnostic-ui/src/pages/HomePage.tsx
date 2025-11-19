import { useState, useEffect } from "react";
import axios from "axios";
import { AiFillWarning } from "react-icons/ai";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import notificationSound from "/src/sounds/notification.mp3";

interface Alarm {
  Conversion_Period_Difference: number;
  TableNumber: string;
  V_of_Device: number;
  RightTurn: number;
  LeftTurn: number;
  Timestamp: string;
  AlarmDescription: string;
  Temperature: number;
  SOBS3AP: number;
  AB: number;
  BC: number;
  AC: number;
  phaseA: number;
  phaseB: number;
  phaseC: number;
  ydInfo: number;
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
  SOBS_Lost_Of_Control: number;
  NumOfControl: number;
  PackageNum: number;
}

const HomePage = () => {
  const [alarms, setAlarms] = useState<Alarm[]>([]);
  const [loading, setLoading] = useState<boolean>(true);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const alarmsPerPage = 7;
  const totalPages = Math.ceil(alarms.length / alarmsPerPage);

  useEffect(() => {
    const interval = setInterval(() => {
      axios.get("http://localhost:5000/alarms")
        .then((response) => {
          console.log("Response data:", response.data);
          if (response.data.length > alarms.length) {
            const newAlarm = response.data[0];
            setAlarms(response.data);
            setLoading(false);
            notifyAlarm(newAlarm);
            document.documentElement.style.setProperty("--warning-color", "#FF0000");
            playNotificationSound();
          }
        })
        .catch((error) => {
          console.error("Error fetching alarms:", error);
          setLoading(false);
        });
    }, 1500);

    return () => clearInterval(interval);
  }, [alarms]);

  const notifyAlarm = (alarm: Alarm) => {
    toast.error(`Yeni signal!: ${alarm.TableNumber}`, {
      position: "top-right",
      autoClose: 5000,
      hideProgressBar: false,
      closeOnClick: true,
      pauseOnHover: true,
      draggable: true,
      progress: undefined,
    });
  };

  const playNotificationSound = () => {
    const audio = new Audio(notificationSound);
    audio.play();
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

  const handlePageChange = (page: number) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
    }
  };

  return (
    <div className="w-full ml-10 mr-10">
      <ToastContainer />
      {loading ? (
        <div className="flex items-center justify-center h-screen">
          <div className="loader ease-linear rounded-full border-8 border-t-8 border-gray-500 h-32 w-32"></div>
        </div>
      ) : (
        <>
          <div className="pt-4 ml-48 justify-center">
            <div className="flex flex-raw font-bold mx-auto max-w-screen-xl w-screen">
              <p className="flex-1">Tarix</p>
              <p className="flex-1">YD-nın nömrəsi</p>
              <p className="flex-1">Təsvir olunan problemlər</p>
            </div>
          </div>
          <div className="flex flex-col ">
            {alarms.slice((currentPage - 1) * alarmsPerPage, currentPage * alarmsPerPage).map((alarm, index) => (
              <div
                key={`${alarm.Timestamp}-${index}`}
                className="w-full p-3 bg-white rounded-lg shadow-md flex items-center mt-2 justify-center"
              >
                <AiFillWarning
                  className="text-red-500 text-6xl"
                  style={{
                    color:
                      alarm.Temperature >= 45 && alarm.Temperature < 50
                        ? "#FFA500"
                        : alarm.V_of_Device >= 11 && alarm.V_of_Device <= 13
                        ? "#FFA500"
                        : alarm.CurrentValue1 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue2 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue3 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue4 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue5 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue6 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue7 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue8 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue9 > 3
                        ? "#FFA500"
                        : alarm.CurrentValue10 > 3
                        ? "#FFA500"
                        : alarm.SOBS_Lost_Of_Control > 0
                        ? "#FFA500"
                        : alarm.NumOfControl > 0
                        ? "#FFA500"
                        : alarm.Conversion_Period_Difference > 1
                        ? "#FFA500"
                        : alarm.PackageNum > 0 && alarm.PackageNum <=0
                        ? "#FFA500"
                        : "#FF0000"
                  }}
                />

                <div className="ml-12">
                  <div className="flex font-bold mx-auto max-w-screen-xl w-screen ">
                    <p className="flex-1 text-m font-bold text-gray-800">{formatDate(alarm.Timestamp)}</p>
                    <p className="flex-1 ml-24 text-m font-bold text-gray-800">{alarm.TableNumber}</p>
                    <p className="flex-1 text-l font-bold text-gray-800">{alarm.AlarmDescription}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>
          <div className="fixed bottom-8 left-44 right-0 flex justify-center">
            <button
              onClick={() => handlePageChange(currentPage - 1)}
              disabled={currentPage === 1}
              className="bg-main-blue hover:bg-blue-700 text-white font-bold py-2 px-4 mr-2 rounded"
            >
              Geri
            </button>
            <select
              value={currentPage}
              onChange={(e) => handlePageChange(Number(e.target.value))}
              className="bg-main-blue text-white font-bold py-2 px-2 mr-2 rounded cursor-pointer"
            >
              {Array.from({ length: totalPages }, (_, index) => index + 1).map((page) => (
                <option key={page} value={page}>
                  {page}
                </option>
              ))}
            </select>
            <button
              onClick={() => handlePageChange(currentPage + 1)}
              disabled={currentPage === totalPages}
              className="bg-main-blue hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
            >
              Növbəti
            </button>
          </div>
        </>
      )}
    </div>
  );
};

export default HomePage;
