import { FC, memo, useState } from "react";
import { useNavigate } from "react-router-dom";
import Button from "@components/Button";
import TextInput from "@components/TextInput";
import logo from "@assets/logo.png";
import { BsPersonFill } from "react-icons/bs";
import axios from "axios";
import { API_BASE_URL } from "../config";

const Login: FC = memo(() => {
  const navigate = useNavigate();
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [errorMessage, setErrorMessage] = useState("");

  const handleLogin = async () => {
    try {
      const response = await axios.post(`${API_BASE_URL}/login`, {
        username,
        password,
      });
      if (response.data.message === "Login successful") {
        const userFullName = response.data.user_info.fullName;
        const sahe = response.data.user_info.sahe; // Fetched "Sahe" value
        localStorage.setItem("userFullName", userFullName);
        localStorage.setItem("sahe", sahe);
        navigate("/auth/home");
      } else {
        setUsername("");
        setPassword("");
        setErrorMessage("Invalid username or password");
      }
    } catch (error) {
      console.error("Login error:", error);
    }
  };

  return (
    <>
      <div className="h-full w-full bg-background bg-cover">
        <div className="h-full max-w-xs flex items-center m-auto">
          <form className="bg-main shadow-md rounded-xl">
            <div className="w-full bg-main-blue rounded-xl">
              <img src={logo} alt="logo" className="pt-2 px-16" />
              <p className="text-white font-medium text-center mt-2 pb-2 px-6">
                Yoldəyişdiricilərin Diaqnostika Sistemi
              </p>
            </div>
            <div className="px-14 pt-12 pb-12">
              <TextInput
                Icon={<BsPersonFill size={25} />}
                placeholder="İstifadəçi adı"
                type="text"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
              />
              <TextInput
                className="mt-3"
                placeholder="Parol"
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
              {errorMessage && (
                <p className="text-red-500 text-sm mt-2">{errorMessage}</p>
              )}
              <div className="flex justify-center mt-10">
                <Button onClick={handleLogin}>DAXİL OL</Button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </>
  );
});

export default Login;
