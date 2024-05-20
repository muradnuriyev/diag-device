import {
  Navigate,
  RouterProvider,
  createBrowserRouter,
} from "react-router-dom";
import LoginPage from "./pages/Login";
import HomePage from "@pages/HomePage";
import AuthLayout from "./layouts/AuthLayout";
import HelpPage from "@pages/Help";
import HistoryPage from "@pages/History";
import NotePage from "@pages/Note";
import TechnicalProsPlanPage from "@pages/TechnicalProsPlan";
import IQ3JournalPage from "@pages/IQ3Journal";
import CurrentAnalysisPage from "@pages/CurrentAnalysis";
import IntervalAnalysisPage from "@pages/IntervalAnalysis";
import Logout from "@pages/Logout.tsx";

const access_token = localStorage.getItem("access_token");

const router = createBrowserRouter([
  {
    path: "/",
    element: access_token ? (
      <Navigate to="auth/home" />
    ) : (
      <Navigate to="login" />
    ),
  },
  {
    path: "login",
    element: <LoginPage />,
  },
  {
    path: "auth",
    element: <AuthLayout />,
    children: [
      {
        path: "home",
        element: <HomePage />,
      },
      {
        path: "current-analysis",
        element: <CurrentAnalysisPage />,
      },
      {
        path: "interval-analysis",
        element: <IntervalAnalysisPage />,
      },
      {
        path: "iq3-journal",
        element: <IQ3JournalPage />,
      },
      {
        path: "technical-pros-plan",
        element: <TechnicalProsPlanPage />,
      },
      {
        path: "history",
        element: <HistoryPage />,
      },
      {
        path: "note",
        element: <NotePage />,
      },
      {
        path: "help",
        element: <HelpPage />,
      },
      {
        path: "logout",
        element: <Logout />,
      },
    ],
  },
]);

function App() {
  return (
    <div className="h-full w-full bg-white">
      <RouterProvider router={router} />
    </div>
  );
}

export default App;
