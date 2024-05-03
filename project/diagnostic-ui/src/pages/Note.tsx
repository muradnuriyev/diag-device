import React, { useState } from "react";
import { GrFormAdd } from "react-icons/gr";
import TesdiqButton from "../layouts/AuthLayout/components/TesdiqButton";
import CurrentDate from "../layouts/AuthLayout/components/CurrentDate";
import CurrentTime from "../layouts/AuthLayout/components/CurrentTime";

const Note = () => {
  const userFullNameLS = localStorage.getItem("userFullName");
  const saheLS = localStorage.getItem("sahe");
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [sahe, setSahe] = useState("");
  const [userFullName, setUserFullName] = useState("");
  const [note, setNote] = useState("");

  const openModal = () => {
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
  };

  const handleModalClick = (e: React.MouseEvent<HTMLDivElement>) => {
    const clickedElement = e.target as HTMLElement;
    if (clickedElement.classList.contains("modal-container")) {
      closeModal();
    }
  };

  const sendDataToServer = async () => {
    try {
      const response = await fetch("http://localhost:5000/store_note", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          sahe,
          userFullName,
          note,
        }),
      });
  
      if (response.ok) {
        console.log("Data sent successfully");
      } else {
        console.error("Error sending data");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  };
  
  const handleConfirmClick = async () => {
    await sendDataToServer();
    closeModal();
  };

  return (
    <div className="w-full ml-7 mr-7 mt-20 flex justify-center">
      <button
        onClick={openModal}
        className="absolute top-20 right-12 md:top-20 md:right-12 lg:top-20 lg:right-12 bg-main-blue rounded-lg px-4 py-2 text-white hover:bg-main transition duration-300"
      >
        <GrFormAdd className="inline-block mr-2" />
        Əlavə et
      </button>
      <div className="flex flex-col w-full">
        <div
          className="flex p-6 h-screen bg-white rounded-lg shadow-md space-x-8 mb-7 relative modal-container "
          onClick={handleModalClick}
        >
          <div className="w-1/4 border-r pr-4">
            <h3 className="text-xl font-semibold mb-2">Ad Soyad</h3>
          </div>
          <div className="w-1/4 border-r pr-4">
            <h3 className="text-xl font-semibold mb-2">Vəzifəsi</h3>
          </div>
          <div className="w-1/4 border-r pr-4 ">
            <h3 className="text-xl font-semibold mb-2">Tarix</h3>
          </div>
          <div className="w-1/4">
            <h3 className="text-xl font-semibold mb-2">Problemin təsviri</h3>
          </div>
        </div>
      </div>
      {isModalOpen && (
      <div
        className="fixed top-0 left-0 w-screen h-screen bg-black bg-opacity-75 flex items-center justify-center modal-container"
        onClick={handleModalClick}
      >
        <div className="bg-white p-8 rounded-lg shadow-md w-[40%] h-[80%] flex flex-col justify-between">
          <div className="flex items-center mb-4 mt-10 ml-10 mr-10">
            <div className="w-3/4">
              <h3 className="text-xl font-semibold">Sahə</h3>
            </div>
            <div className="w-1/4 border rounded-lg border-main-blue p-2">
              <select
                className="w-full px-4 py-2 border rounded-lg"
                onChange={(e) => setSahe(e.target.value)}
                value={sahe}
              >
                {saheLS && (
                  <option className="text-gray-800">{saheLS}</option>
                )}
              </select>
            </div>
          </div>
          <div className="flex items-center mb-4 mt-10 ml-10 mr-10">
            <div className="w-3/4">
              <h3 className="text-xl font-semibold">Ad Soyad</h3>
            </div>
            <div className="w-1/4 border rounded-lg border-main-blue p-2">
              <select
                className="w-full px-4 py-2 border rounded-lg"
                onChange={(e) => setUserFullName(e.target.value)}
                value={userFullName}
              >
                {userFullNameLS && (
                  <option className="text-gray-800">{userFullNameLS}</option>
                )}
              </select>
            </div>
          </div>
          <div className="flex items-center mb-4 mt-10 ml-10 mr-10">
            <div className="w-3/4">
              <h3 className="text-xl font-semibold">Tarix</h3>
            </div>
            <div className="w-1/4 border rounded-lg border-main-blue p-2">
              <CurrentDate />
            </div>
          </div>
          <div className="flex items-center mb-4 mt-10 ml-10 mr-10">
            <div className="w-3/4">
              <h3 className="text-xl font-semibold">Saat</h3>
            </div>
            <div className="w-1/4 border rounded-lg border-main-blue p-2">
              <CurrentTime />
            </div>
          </div>
          <div className="flex items-center mb-4 mt-10 ml-10 mr-10">
            <div className="w-1/4">
              <h3 className="text-xl font-semibold">Qeyd</h3>
            </div>
            <div className="w-3/4">
              <textarea
                rows={4}
                className="w-full border rounded-lg border-main-blue p-2"
                placeholder="Burada problemin təsvirini yazın"
                onChange={(e) => setNote(e.target.value)}
                value={note}/>
            </div>
          </div>
          <div className="flex justify-center mt-auto">
            <TesdiqButton onClick={handleConfirmClick}>Təsdiqlə</TesdiqButton>
          </div>
        </div>
      </div>
        
      )}
    </div>
  );
};

export default Note;

 