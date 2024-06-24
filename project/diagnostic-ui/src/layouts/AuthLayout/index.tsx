import { FC, useEffect } from "react";
import { Link, Outlet, useLocation, useNavigate } from "react-router-dom";
import logo from "@assets/logo.png";
import { AiFillHome } from "react-icons/ai";
import { FaSearchengin } from "react-icons/fa";
import { IoAnalyticsSharp,} from "react-icons/io5";
import {
  BsFillJournalBookmarkFill,
  BsFillQuestionCircleFill,
} from "react-icons/bs";
import { FaSignOutAlt, FaLightbulb } from "react-icons/fa";
import { VscHistory } from "react-icons/vsc";
import { SlNote } from "react-icons/sl";
import { BsPersonCircle, BsJournalText } from "react-icons/bs";
import CurrentTime from "./components/CurrentTime";
import CurrentDate from "./components/CurrentDate";

const AuthLayout: FC = () => {
  const { pathname } = useLocation();
  const navigate = useNavigate();
  const userFullName = localStorage.getItem("userFullName");

  useEffect(() => {
    if (!userFullName) {
      navigate("/login");
    }
  }, [userFullName]);

  const menuButtons = [
    { icon: <AiFillHome />, label: "Əsas səhifə", path: "/auth/home" },
    {
      icon: <FaSearchengin />,
      label: "Cari analiz",
      path: "/auth/current-analysis",
    },
    {
      icon: <IoAnalyticsSharp />,
      label: "Interval analiz",
      path: "/auth/interval-analysis",
    },
    {
      icon: <BsJournalText />,
      label: "İQ-3 jurnalı",
      path: "/auth/iq3-journal",
    },
    {
      icon: <BsFillJournalBookmarkFill />,
      label: "IQ-64 jurnalı",
      path: "/auth/iq64-journal",
    },
    {
      icon: <FaLightbulb />,
      label: "Tex.pros.planı",
      path: "/auth/technical-pros-plan",
    },
    { icon: <VscHistory />, label: "Tarixçə", path: "/auth/history" },
    { icon: <SlNote />, label: "Qeyd", path: "/auth/note" },
    { icon: <BsFillQuestionCircleFill />, label: "Kömək", path: "/auth/help" },
    { icon: <FaSignOutAlt />, label: "Çıxış", path: "/auth/logout" },
  ];

  return (
    <div className="h-full flex">
      <div className="lg:max-w-[248px] bg-main-blue h-full flex flex-col">
        <img
          src={logo}
          alt="logo"
          className="h-4 lg:h-auto object-cover self-center mt-4 lg:px-8"
        />
        <div className="flex flex-col mt-8">
          {menuButtons.map((button) => (
            <Link
              to={button.path}
              key={button.path}
              className={`transition-colors text-white text-2xl flex py-3 items-center px-4 group ${
                pathname === button.path ? "bg-main" : "bg-main-blue"
              }`}
            >
              <p className="text-3xl">{button.icon}</p>
              <p className="text-white ml-2 font-normal hidden lg:block">
                {button.label}
              </p>
              <p
                className={`origin-left lg:hidden scale-x-0 group-hover:scale-x-100 absolute transition-all ml-[46px] ${
                  pathname === button.path
                    ? "bg-main border-t-2 border-r-2 border-b-2 border-main-blue"
                    : "bg-main-blue"
                } py-[11px] px-4 w-48`}
              >
                {button.label}
              </p>
            </Link>
          ))}
        </div>
      </div>
      <div className="flex h-ful flex-1 flex-col">
        <div className="flex h-[64px] w-full bg-white justify-between">
          <div className="flex pl-6 ml-5">
            <CurrentDate />
          </div>
          <div className="flex pl-12 mr-10">
            <CurrentTime />
          </div>
          <div className="flex items-center mr-10 ml-10">
            <div className="text-3xl mr-3">
              <BsPersonCircle />
            </div>
            {userFullName && (
              <p className="text-2xl font-bold text-gray-800 mr-10">
                {userFullName}
              </p>
            )}
          </div>
        </div>
        <div className="overflow-y-scroll flex flex-1 w-full bg-main-cream">
          <Outlet />
        </div>
      </div>
    </div>
  );
};

export default AuthLayout;
