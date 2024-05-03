import { useState, useEffect } from "react";
import axios from "axios";
import { AiFillWarning } from "react-icons/ai";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import notificationSound from "/src/sounds/notification.mp3";

interface Alarm {
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
  phaseA: number,
  phaseB: number,
  phaseC: number,
}

const HomePage = () => {
  const [alarms, setAlarms] = useState<Alarm[]>([]);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const alarmsPerPage = 6;
  const totalPages = Math.ceil(alarms.length / alarmsPerPage);

  useEffect(() => {
    const interval = setInterval(() => {
      axios.get("http://localhost:5000/alarms")
        .then((response) => {
          console.log("Response data:", response.data);
          if (response.data.length > alarms.length) { 
            const newAlarm = response.data[0];
            setAlarms(response.data);
            notifyAlarm(newAlarm);
            playNotificationSound();
          }
        })
        .catch((error) => {
          console.error("Error fetching alarms:", error);
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
    setCurrentPage(page);
  };

  return (
    <div className="w-full ml-10 mr-10">
      <ToastContainer />
      <div className="pt-4">
        <div className="flex flex-nowrap font-bold mx-auto max-w-screen-xl w-screen">
          <p className="flex-1 ml-48">Tarix</p>
          <p className="flex-1">YD-nın nömrəsi</p>
          <p className="flex-1">Təsvir olunan problemlər</p>
        </div>
      </div>
      <div className="flex flex-col ">
        {alarms.slice((currentPage - 1) * alarmsPerPage, currentPage * alarmsPerPage).map((alarm) => (
          <div
            key={alarm.Timestamp}
            className=" w-full p-4 bg-white rounded-lg shadow-md flex items-center mt-4"
          >
            <AiFillWarning className="text-red-500 text-6xl" />
            <div className="ml-24">
              <div className="flex space-x-40 font-bold mx-auto max-w-screen-xl w-screen px-4">
                <p className="flex-1 ml-24 text-m font-bold text-gray-800">{formatDate(alarm.Timestamp)}</p>
                <p className="flex-1 text-m font-bold text-gray-800">{alarm.TableNumber}</p>
                <p className="flex-1 ml-24 text-l font-bold text-gray-800">{alarm.AlarmDescription}</p>
              </div>
            </div>
          </div>
        ))}
      </div>
      <div className="flex justify-center mt-5">
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
          className="bg-main-blue text-white font-bold py-2 px-4 mr-2 rounded cursor-pointer"
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
    </div>
  );
};

export default HomePage;