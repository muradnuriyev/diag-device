import { useEffect, useState } from "react";
import { LuCalendarDays } from "react-icons/lu"

const CurrentDate = () => {
    const getDate = () => new Date()
        .toLocaleDateString("en-GB", { day: '2-digit', month: '2-digit', year: 'numeric' })
        .replace(/\//g, '.')

    const [date, setDate] = useState(getDate());

    useEffect(() => {
        const interval = setInterval(() => {
            setDate(getDate());
        }, 1000);
        return () => clearInterval(interval);
    }, []);

    return (
        <div className="flex items-center">
            <p className="text-4xl">
                <LuCalendarDays />
            </p>
            <p className="text-lg ml-2">{date}</p>
        </div>
    );
}

export default CurrentDate;
