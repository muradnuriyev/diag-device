import { Suspense, lazy } from "react";
import { Navigate, RouterProvider, createBrowserRouter } from "react-router-dom";
import AuthLayout from "./layouts/AuthLayout";

const LoginPage = lazy(() => import("./pages/Login"));
const HomePage = lazy(() => import("./pages/HomePage"));
const HelpPage = lazy(() => import("./pages/Help"));
const HistoryPage = lazy(() => import("./pages/History"));
const NotePage = lazy(() => import("./pages/Note"));
const TechnicalProsPlanPage = lazy(() => import("./pages/TechnicalProsPlan"));
const IQ3JournalPage = lazy(() => import("./pages/IQ3Journal"));
const CurrentAnalysisPage = lazy(() => import("./pages/CurrentAnalysis"));
const IntervalAnalysisPage = lazy(() => import("./pages/IntervalAnalysis"));

const router = createBrowserRouter([
  {
    path: "/",
    element: <Navigate to="login" />,
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
        element: <Navigate to="/login" />,
      },
    ],
  },
]);

function App() {
  return (
    <div className="h-full w-full bg-white">
      <Suspense
        fallback={
          <div className="h-full w-full flex items-center justify-center">
            <span className="text-gray-600">Loading...</span>
          </div>
        }
      >
        <RouterProvider router={router} />
      </Suspense>
    </div>
  );
}

export default App;
