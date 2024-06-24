import { useState } from "react";
import TesdiqButton from "../layouts/AuthLayout/components/TesdiqButton";
import CurrentDate from "../layouts/AuthLayout/components/CurrentDate";
import CurrentTime from "../layouts/AuthLayout/components/CurrentTime";

const IQ3Journal = () => {
  const [section, setSection] = useState("plan");
  const [sahe, setSahe] = useState(localStorage.getItem("sahe") || "");
  const [userFullName, setUserFullName] = useState(
    localStorage.getItem("userFullName") || ""
  );
  const [texProsQrafikBend, setTexProsQrafikBend] = useState("9.2");
  const [note, setNote] = useState("");
  const access_token = localStorage.getItem("access_token");

  const sendDataToServer = async () => {
    try {
      const endpoint = section === "plan" ? "/store_iq3journalPlan" : "/store_iq3journalHesabat";
      const response = await fetch(`http://localhost:5000${endpoint}`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${access_token}`,
        },
        body: JSON.stringify({ sahe, userFullName, texProsQrafikBend, note }),
      });

      if (response.ok) {
        console.log("Data sent successfully");
        setNote("");
      } else {
        console.error("Error sending data");
      }
    } catch (error) {
      console.error("Error:", error);
    }
  };

  const handleConfirmClick = async () => {
    await sendDataToServer();
  };

  return (
    <div className="w-full m-7 flex">
      <div className="flex flex-col w-full">
        <div className="h-screen p-6 bg-white rounded-lg shadow-md flex flex-col">
          <div className="flex items-center mb-4 text-lg">
            <button
              className={`mr-4 ${section === "plan" ? "font-bold" : ""}`}
              onClick={() => setSection("plan")}
            >
              Plan
            </button>
            <button
              className={`${section === "hesabat" ? "font-bold" : ""}`}
              onClick={() => setSection("hesabat")}
            >
              Hesabat
            </button>
          </div>
          
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
              <h3 className="text-xl font-semibold">Texnoloji Proses Qrafikin Bəndi</h3>
            </div>
            <div className="w-1/4 border rounded-lg border-main-blue p-2">
              <select
                className="w-full px-4 py-2 border rounded-lg"
                onChange={(e) => setTexProsQrafikBend(e.target.value)}
                value={texProsQrafikBend}
              >
                <option className="text-gray-800">9.2</option>
                <option className="text-gray-800">9.3</option>
                <option className="text-gray-800">9.4</option>
              </select>
            </div>
          </div>
          <div className="flex items-center mb-4">
            <div className="w-3/4">
              <h3 className="text-xl font-semibold">Cari Vaxt</h3>
            </div>
            <div className="w-1/8 border rounded-lg border-main-blue p-2 mr-14">
              <CurrentDate />
            </div>
            <div className="w-1/8 border rounded-lg border-main-blue p-2">
              <CurrentTime />
            </div>
          </div>
          <div className="flex items-center mb-4">
            <div className="w-3/4">
            <h3 className="text-xl font-semibold">
                {section === "plan" ? "Son vaxt" : "Görülən işlərin son vaxtı"}
              </h3>
            </div>
            <div className="w-1/4 border rounded-lg border-main-blue p-2">
              {/* Placeholder for future implementation */}
            </div>
          </div>

          <div className="flex items-center mb-4">
            <div className="w-1/2">
              <h3 className="text-xl font-semibold">
                {section === "plan" ? "Qeyd" : "Görülən İşlər"}
              </h3>
            </div>
            <div className="w-1/2">
              <textarea
                rows={8}
                className="w-full border rounded-lg border-main-blue p-2"
                placeholder={
                  section === "plan" ? "Burada görüləcək işləri yazın" : "Burada görülən işləri yazın"
                }
                onChange={(e) => setNote(e.target.value)}
                value={note}
              />
            </div>
          </div>
          <div className="flex justify-center mt-auto w-full">
            <TesdiqButton onClick={handleConfirmClick}>Təsdiqlə</TesdiqButton>
          </div>
        </div>
      </div>
    </div>
  );
};

export default IQ3Journal;
