// /utils/calculateRemainingTime.ts

export const calculateRemainingTime = (endingDate: string): string | null => {
  const endDate = new Date(endingDate).getTime();
  const now = new Date().getTime();
  const timeDiff = endDate - now;

  if (timeDiff <= 0) {
    return null; // Times up
  }

  const days = Math.floor(timeDiff / (1000 * 60 * 60 * 24));
  const hours = Math.floor((timeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  // const minutes = Math.floor((timeDiff % (1000 * 60 * 60)) / (1000 * 60));

  // return `${days} DAYS ${hours} HOURS ${minutes} MIN`; //with minutes
  return `${days} dagar ${hours} timmar`; // without minutes
};
