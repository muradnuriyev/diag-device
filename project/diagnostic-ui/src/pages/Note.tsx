import React, { useState, useEffect } from "react";
import { GrFormAdd } from "react-icons/gr";
import TesdiqButton from "../layouts/AuthLayout/components/TesdiqButton";
import CurrentDate from "../layouts/AuthLayout/components/CurrentDate";
import CurrentTime from "../layouts/AuthLayout/components/CurrentTime";

interface Note {
  Sahe: string;
  FullName: string;
  Note: string;
  timestamp: string;
  Vezife: string;
}

const NoteComponent = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedNote, setSelectedNote] = useState<Note | null>(null);
  const [sahe, setSahe] = useState(localStorage.getItem("sahe") || "");
  const [userFullName, setUserFullName] = useState(
    localStorage.getItem("userFullName") || ""
  );
  const [note, setNote] = useState("");
  const [notes, setNotes] = useState<Note[]>([]);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const notesPerPage = 7;
  const totalPages = Math.ceil(notes.length / notesPerPage);
  const access_token = localStorage.getItem("access_token");

  const openModal = () => setIsModalOpen(true);
  const closeModal = () => setIsModalOpen(false);
  const closeFullNoteModal = () => setSelectedNote(null);

  const handleModalClick = (e: React.MouseEvent<HTMLDivElement>) => {
    if ((e.target as HTMLElement).classList.contains("modal-container"))
      closeModal();
  };

  const sendDataToServer = async () => {
    try {
      const response = await fetch("http://localhost:5000/store_note", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${access_token}`,
        },
        body: JSON.stringify({ sahe, userFullName, note }),
      });

      if (response.ok) {
        console.log("Data sent successfully");
        fetchNotes();
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

  const fetchNotes = async () => {
    try {
      const response = await fetch("http://localhost:5000/get_notes", {
        headers: { Authorization: `Bearer ${access_token}` },
      });
      if (response.ok) {
        const data = await response.json();
        setNotes(data.notes);
      } else {
        console.error("Error fetching notes");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  };

  useEffect(() => {
    fetchNotes();
  }, []);

  const handlePageChange = (page: number) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
    }
  };

  return (
    <div className="w-full ml-7 mr-7 mt-20 flex justify-center">
      <button
        onClick={openModal}
        className="absolute top-20 right-12 bg-main-blue rounded-lg px-4 py-2 text-white hover:bg-main transition duration-300"
      >
        <GrFormAdd className="inline-block mr-2" />
        Əlavə et
      </button>
      <div className="flex flex-col w-full">
        <div className="flex p-6 bg-white rounded-lg shadow-md space-x-8 mb-7">
          <div className="w-1/4 border-r pr-4">
            <h3 className="text-2xl font-semibold mb-2">Ad Soyad</h3>
          </div>
          <div className="w-1/4 border-r pr-4">
            <h3 className="text-2xl font-semibold mb-2">Vəzifəsi</h3>
          </div>
          <div className="w-1/4 border-r pr-4">
            <h3 className="text-2xl font-semibold mb-2">Tarix</h3>
          </div>
          <div className="w-1/4">
            <h3 className="text-2xl font-semibold mb-2">Problemin təsviri</h3>
          </div>
        </div>
        {notes
          .slice((currentPage - 1) * notesPerPage, currentPage * notesPerPage)
          .map((note, index) => (
            <div
              key={index}
              className="flex p-6 bg-white rounded-lg shadow-md space-x-8 mb-1"
              onClick={() => setSelectedNote(note)}
            >
              <div className="w-1/4 border-r pr-4">
                <p className="text-lg">{note.FullName}</p>
              </div>
              <div className="w-1/4 border-r pr-4">
                <p className="text-lg">{note.Vezife}</p>
              </div>
              <div className="w-1/4 border-r pr-4">
                <p className="text-lg">
                  {new Date(note.timestamp).toLocaleDateString()}
                </p>
              </div>
              <div className="w-1/4 truncate">
                <p className="text-lg">
                  {note.Note.length > 30
                    ? `${note.Note.substring(0, 30)}...`
                    : note.Note}
                </p>
              </div>
            </div>
          ))}
        <div className="flex justify-center mt-4">
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
            {Array.from({ length: totalPages }, (_, index) => index + 1).map(
              (page) => (
                <option key={page} value={page}>
                  {page}
                </option>
              )
            )}
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
      {isModalOpen && (
        <div
          className="fixed top-0 left-0 w-screen h-screen bg-black bg-opacity-75 flex items-center justify-center modal-container"
          onClick={handleModalClick}
        >
          <div className="bg-white p-8 rounded-lg shadow-md w-[40%] h-[80%] flex flex-col justify-between">
            <div className="flex items-center mb-4">
              <div className="w-3/4">
                <h3 className="text-xl font-semibold">Sahə</h3>
              </div>
              <div className="w-1/4 border rounded-lg border-main-blue p-2">
                <select
                  className="w-full px-4 py-2 border rounded-lg"
                  onChange={(e) => setSahe(e.target.value)}
                  value={sahe}
                >
                  <option className="text-gray-800">{sahe}</option>
                </select>
              </div>
            </div>
            <div className="flex items-center mb-4">
              <div className="w-3/4">
                <h3 className="text-xl font-semibold">Ad Soyad</h3>
              </div>
              <div className="w-1/4 border rounded-lg border-main-blue p-2">
                <select
                  className="w-full px-4 py-2 border rounded-lg"
                  onChange={(e) => setUserFullName(e.target.value)}
                  value={userFullName}
                >
                  <option className="text-gray-800">{userFullName}</option>
                </select>
              </div>
            </div>
            <div className="flex items-center mb-4">
              <div className="w-3/4">
                <h3 className="text-xl font-semibold">Tarix</h3>
              </div>
              <div className="w-1/4 border rounded-lg border-main-blue p-2">
                <CurrentDate />
              </div>
            </div>
            <div className="flex items-center mb-4">
              <div className="w-3/4">
                <h3 className="text-xl font-semibold">Saat</h3>
              </div>
              <div className="w-1/4 border rounded-lg border-main-blue p-2">
                <CurrentTime />
              </div>
            </div>
            <div className="flex items-center mb-4">
              <div className="w-1/4">
                <h3 className="text-xl font-semibold">Qeyd</h3>
              </div>
              <div className="w-3/4">
                <textarea
                  rows={12}
                  className="w-full border rounded-lg border-main-blue p-2"
                  placeholder="Burada problemin təsvirini yazın"
                  onChange={(e) => setNote(e.target.value)}
                  value={note}
                />
              </div>
            </div>
            <div className="flex justify-center mt-auto">
              <TesdiqButton onClick={handleConfirmClick}>Təsdiqlə</TesdiqButton>
            </div>
          </div>
        </div>
      )}
      {selectedNote && (
        <div className="fixed top-0 left-0 w-screen h-screen bg-black bg-opacity-75 flex items-center justify-center">
          <div className="bg-white p-8 rounded-lg shadow-md w-[40%] h-[80%] flex flex-col justify-between">
            <h2 className="text-2xl font-semibold mb-4">Qeydın detalları</h2>
            <div className="flex mb-4">
              <div className="w-1/3">
                <h3 className="text-xl font-semibold">Ad Soyad</h3>
                <p className="text-lg">{selectedNote.FullName}</p>
              </div>
              <div className="w-1/3">
                <h3 className="text-xl font-semibold">Vəzifəsi</h3>
                <p className="text-lg">{selectedNote.Vezife}</p>
              </div>
              <div className="w-1/3">
                <h3 className="text-xl font-semibold">Tarix</h3>
                <p className="text-lg">
                  {new Date(selectedNote.timestamp).toLocaleDateString()}
                </p>
              </div>
            </div>
            <div className="flex mb-4">
              <div className="w-full">
                <h3 className="text-xl font-semibold">Qeyd</h3>
                <p className="text-lg">{selectedNote.Note}</p>
              </div>
            </div>
            <button
              onClick={closeFullNoteModal}
              className="self-center bg-main-blue text-white px-4 py-2 rounded-lg hover:bg-main transition duration-300"
            >
              Bağla
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default NoteComponent;
