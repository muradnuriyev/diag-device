import { useEffect, useState } from "react";
import { LuCalendarDays } from "react-icons/lu";
import { format } from "date-fns";
import { az } from "date-fns/locale/az";

const CurrentDate = () => {
  const now = new Date();
  const getDate = () => format(now, "d MMM yyyy, EEEEE", { locale: az });
  const [date, setDate] = useState(getDate());

  useEffect(() => {
    const interval = setInterval(() => {
      setDate(getDate());
    }, 1000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="flex items-center justify-center">
      <p className="text-4xl">
        <LuCalendarDays />
      </p>
      <p className="text-lg ml-2">{date}</p>
    </div>
  );
};

export default CurrentDate;
