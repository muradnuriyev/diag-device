import { useEffect, useState } from 'react';
import { AiOutlineClockCircle } from 'react-icons/ai'

const CurrentTime = () => {
    const [time, setTime] = useState(new Date().toLocaleTimeString("az"));

    useEffect(() => {
        const interval = setInterval(() => {
            setTime(new Date().toLocaleTimeString("az"));
        }, 1000);
        return () => clearInterval(interval);
    }, []);

    return (
        <div className="flex items-center">
            <p className="text-4xl">
                <AiOutlineClockCircle />
            </p>
            <p className="text-lg ml-2">{time}</p>
        </div>
    );
}

export default CurrentTime;