"use client";

import { useEffect, useState } from "react";

interface CountdownProps {
  targetDate: Date;
}

const Countdown: React.FC<CountdownProps> = ({ targetDate }) => {
  const [timeLeft, setTimeLeft] = useState<{
    days: number;
    hours: number;
    minutes: number;
    seconds: number;
  }>({
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0
  });
  
  const [isExpired, setIsExpired] = useState<boolean>(false);

  useEffect(() => {
    const calculateTimeLeft = () => {
      const difference = targetDate.getTime() - new Date().getTime();
      
      if (difference <= 0) {
        setIsExpired(true);
        return {
          days: 0,
          hours: 0,
          minutes: 0,
          seconds: 0
        };
      }
      
      return {
        days: Math.floor(difference / (1000 * 60 * 60 * 24)),
        hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
        minutes: Math.floor((difference / 1000 / 60) % 60),
        seconds: Math.floor((difference / 1000) % 60)
      };
    };

    // Initial calculation
    setTimeLeft(calculateTimeLeft());

    // Update every second
    const timer = setInterval(() => {
      const calculated = calculateTimeLeft();
      setTimeLeft(calculated);
      
      // Clear interval when time is up
      if (calculated.days === 0 && 
          calculated.hours === 0 && 
          calculated.minutes === 0 && 
          calculated.seconds === 0) {
        clearInterval(timer);
      }
    }, 1000);

    // Cleanup
    return () => clearInterval(timer);
  }, [targetDate]);

  if (isExpired) {
    return <p className="text-red-500 font-medium">Slutat</p>;
  }

  // Format time with leading zeros
  const formatTime = (value: number): string => {
    return value < 10 ? `0${value}` : `${value}`;
  };

  return (
    <div className="font-medium text-base">
      {timeLeft.days > 0 && (
        <span className="mr-1">
          {timeLeft.days}d{" "}
        </span>
      )}
      <span>
        {formatTime(timeLeft.hours)}:{formatTime(timeLeft.minutes)}:{formatTime(timeLeft.seconds)}
      </span>
    </div>
  );
};

export default Countdown; 