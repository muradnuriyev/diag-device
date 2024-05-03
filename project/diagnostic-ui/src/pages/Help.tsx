import { AiOutlineAppstoreAdd } from "react-icons/ai";
import { HiOutlineUserGroup } from "react-icons/hi";
import { FaVideo, FaLongArrowAltRight, } from "react-icons/fa";
import { BiInfoSquare } from "react-icons/bi";


const Help = () => {
  const squareDivStyle = {
    height: "400px", 
    width: "400px",
  };

  return (
    <div className="w-full ml-7 mr-7 mt-7 flex justify-center">
      <div className="flex flex-col w-full">
        <div className="flex h-screen p-6 bg-white rounded-lg shadow-md items-center justify-center space-x-16 mb-7 relative flex-wrap">
          <a href="#" className="clickable-div transform transition-transform hover:scale-105">
            <div className="bg-main rounded-lg" style={squareDivStyle}>
              <div className="flex flex-col items-center justify-center h-full">
                <div className="text-9xl text-main-blue mb-4 mt-10">
                  <BiInfoSquare className="transform scale-150" />
                </div>
                <div className="text-2xl font-bold mt-10">Proqram haqqında</div>
                <div className="flex items-center">
                  <span className="text-xs">Daha ətraflı</span>
                  <FaLongArrowAltRight className="ml-1" />
                </div>
              </div>
            </div>
          </a>
          <a href="#" className="clickable-div transform transition-transform hover:scale-105">
            <div className="bg-main rounded-lg" style={squareDivStyle}>
              <div className="flex flex-col items-center justify-center h-full">
                <div className="text-9xl text-main-blue mb-4 mt-10">
                  <AiOutlineAppstoreAdd style={{ transform: 'scale(1.5)' }} />
                </div>
                <div className="text-2xl font-bold mt-10">Bölmələr haqqında</div>
                <div className="flex items-center">
                  <span className="text-2sm">Daha ətraflı</span>
                  <FaLongArrowAltRight className="ml-1" />
                </div>
              </div>
            </div>
          </a>
          <a href="#" className="clickable-div transform transition-transform hover:scale-105">
            <div className="bg-main rounded-lg" style={squareDivStyle}>
              <div className="flex flex-col items-center justify-center h-full">
                <div className="text-9xl text-main-blue mb-4 mt-10">
                  <HiOutlineUserGroup style={{ transform: 'scale(1.5)' }} />
                </div>
                <div className="text-2xl font-bold mt-10">Qurucular haqqında</div>
                <div className="flex items-center">
                  <span className="text-2sm">Daha ətraflı</span>
                  <FaLongArrowAltRight className="ml-1" />
                </div>
              </div>
            </div>
          </a>
          <button className="absolute top-4 right-4 md:top-2 md:right-2 lg:top-4 lg:right-4 bg-main-blue rounded-lg px-4 py-2 text-white hover:bg-main transition duration-300">
            <FaVideo className="inline-block mr-2" />
            Video Təlimat
          </button>
        </div>
      </div>
    </div>
  );
};

export default Help;
