import { Navigate } from "react-router-dom";

const Logout = () => {
  localStorage.removeItem("userFullName");
  localStorage.removeItem("sahe");
  localStorage.removeItem("access_token");

  return <Navigate to="/login" />;
};

export default Logout;
